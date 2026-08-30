#include <stdbool.h>
#include <time.h>
#include <string.h>
#include <malloc.h>
#include "stdio.h"
#include "logger.h"

#define _PRINT_TRACE (1)

#if defined(_PRINT_TRACE) && (_PRINT_TRACE)
#   define PRINT_ENTER(fmt, ...) printf("%s ENTER " fmt "\n" , __PRETTY_FUNCTION__ __VA_OPT__(,) __VA_ARGS__)
#   define PRINT_BODY(fmt, ...) printf("%s " fmt "\n" , __PRETTY_FUNCTION__ __VA_OPT__(,) __VA_ARGS__)
#   define PRINT_EXIT() printf("%s EXIT | result = %s\n", __PRETTY_FUNCTION__, ((result == lgr_ok)? "OK" : "ERROR"))
#else
#   define PRINT_ENTER(...)
#   define PRINT_BODY(...)
#   define PRINT_EXIT(...)
#endif

const static char* FMT_TIME = "%y%m%d_%H%M%S.";
#define LEN_TIME_PREFIX (14)
#define SZ_FNAME (16)
#define SZ_BUFFER (64)

struct lg_logger {
    time_t interval_s;
    _Bool debug;

    FILE* file;
    time_t last_log;
    size_t count;
    char fname[SZ_FNAME];
};


enum {
    lgr_invalid_argument = lgr_reserved + 1
};

#define LG_COLLAPSE_ERROR(lgr) lgr = (lgr >= lgr_reserved)? lgr_error : lgr


static lg_result_e _roll_file(lg_logger_t* log);
static lg_result_e _open_next_file(lg_logger_t* log);

lg_result_e lg_create(lg_logger_t** log, time_t interval_s){
    PRINT_ENTER();
    lg_result_e result = (*log)? lgr_invalid_argument : lgr_ok;

    if (lgr_ok == result) {
        *log = malloc(sizeof(lg_logger_t));
        if (!*log) {
            result = lgr_error;
        }
    }

    if (lgr_ok == result){
        **log = (lg_logger_t){
          .interval_s = interval_s,
          .debug = false,
          .file = NULL,
          .last_log = time(NULL),
          .count = 0,
          .fname = {0}
        };
    }

    if (lgr_ok == result){
        struct tm* lt = localtime(&(*log)->last_log);
        // write the time prefix to the buffer is this is the first time
        if (strftime(&(*log)->fname[0], SZ_FNAME, FMT_TIME, lt) == 0){
            result = lgr_error;
        }
    }


    if (lgr_ok == result){
        result = _open_next_file(*log);
    }

    // cleanup on error
    if (lgr_error == result){
        if (*log){
            if ((*log)->file){
                fclose((*log)->file);
            }
            free(*log);
            *log = NULL;
        }
    }


    LG_COLLAPSE_ERROR(result);

    PRINT_EXIT();

    return result;
}

lg_result_e lg_destroy(lg_logger_t** log){
    PRINT_ENTER();

    lg_result_e result = (*log)? lgr_ok : lgr_error;

    if (lgr_ok == result){
        if (!(*log)->file){
            result = lgr_error;
        }
    }

    if (lgr_ok == result) {
        if (EOF == fflush((*log)->file)){
            result = lgr_error;
        }
    }

    if (lgr_ok == result) {
        if (EOF == fclose((*log)->file)){
            result = lgr_error;
        }
    }

    // unconditionally try to free the memory
    if (*log) {
        (*log)->file = NULL;
        free(*log);
        *log = NULL;
    }

    PRINT_EXIT();
    return result;
}

lg_result_e lg_set_debug_output(lg_logger_t* log, _Bool on_off){
    PRINT_ENTER();

    lg_result_e result = log? lgr_ok : lgr_error;

    if (lgr_ok == result){
        log->debug = on_off;
    }
    PRINT_EXIT();

    return result;
}

lg_result_e lg_log(lg_logger_t* log, const char* msg){
    PRINT_ENTER("\n\tmsg=%s", msg);

    lg_result_e result = log? lgr_ok : lgr_error;

    if (lgr_ok == result){
        if (!log->file){
            result = lgr_error;
        }
    }

    if (lgr_ok == result){
        result = _roll_file(log);
    }

    if (lgr_ok == result){
        if (EOF == fputs(msg, log->file)){
            result = lgr_error;
        }
    }

    if (lgr_ok == result){
        if (EOF == fputc('\n', log->file)){
            result = lgr_error;
        }
    }

    if (lgr_ok == result){
        if (log->debug){
            printf("<%zu>: %s\n", log->count, msg);
        }
    }
    PRINT_EXIT();

    return result;
}
static lg_result_e _open_next_file(lg_logger_t* log){
    PRINT_ENTER();
    lg_result_e result = log? lgr_ok : lgr_error;

    if (lgr_ok == result){
        result = log->file? lgr_error : lgr_ok;
    }

    char buffer[SZ_BUFFER] = {0,};

    if (lgr_ok == result){
        size_t chars_written = LEN_TIME_PREFIX;
        strcpy(&buffer[0], &log->fname[0]);
        chars_written += sprintf(&buffer[LEN_TIME_PREFIX], "%zu", log->count);
        if (chars_written >= SZ_BUFFER){
            result = lgr_error;
        }
    }

    if (lgr_ok == result){
        log->file = fopen(&buffer[0], "w");
        if (!log->file){
            result = lgr_error;
        }
    }
    PRINT_EXIT();

    return result;
}

static lg_result_e _roll_file(lg_logger_t* log){
    PRINT_ENTER("\n\tt0=%ld\n\tnow=%ld\n\tdiff=%ld\n\tinterval=%ld\n\tcount=%zu",
           log->last_log,
           time(NULL),
           time(NULL)-log->last_log,
           log->interval_s,
           log->count);

    lg_result_e result = log? lgr_ok : lgr_error;

    if (lgr_ok == result){
        if (!log->file){
            result = lgr_error;
        }
    }

    if (lgr_ok == result){
        time_t now = time(NULL);
        if ( now >= log->last_log + log->interval_s ){
            ++log->count;
            log->last_log = now;
            if(EOF == fflush(log->file) || EOF == fclose(log->file)){
                result = lgr_error;
            }
            else {
                log->file = NULL;
                result = _open_next_file(log);
            }
        }
    }

    PRINT_EXIT();
    return result;
}
