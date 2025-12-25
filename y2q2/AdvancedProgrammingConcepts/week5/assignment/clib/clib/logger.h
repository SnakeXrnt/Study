#ifndef INCLUDED_CLIB_LOGGER_H
#define INCLUDED_CLIB_LOGGER_H

#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

    /**
     * \enum lg_result
     * Result codes for all the logger functions.
     */
    typedef enum lg_result {
        lgr_error = 0,
        lgr_ok = 1,
        lgr_reserved = 0x100
    } lg_result_e;

    /**
     * \struct lg_logger
     * Structure with runtime information about the logger state.
     */
    struct lg_logger;
    typedef struct lg_logger lg_logger_t;

    /**
     * Creates and initializes a new lg_logger object
     * @param [in,out] log an address of a pointer to ::lg_logger_t, this pointer must be NULL
     * @param [in] interval_s an interval of the log-rolling
     * @return One of the possible result codes #lg_result
     */
    extern lg_result_e lg_create(lg_logger_t** log, time_t interval_s);

    /**
     * Destroys and cleans up a lg_logger object initialized with lg_create
     * @param [in,out] log an address of a pointer to initialized ::lg_logger_t
     * @return One of the possible result codes #lg_result
     */
    extern lg_result_e lg_destroy(lg_logger_t** log);

    /**
     * Enables or disables additional logging to console on calls to lg_log
     * @param [in] log a pointer to initialized ::lg_logger_t
     * @param [in] on_off true enables, false disables
     * @return One of the possible result codes #lg_result
     */
    extern lg_result_e lg_set_debug_output(lg_logger_t* log, bool on_off);

    /**
     * Logs a message
     * @param [in] log a pointer to initialized ::lg_logger_t
     * @param msg message to log
     * @return One of the possible result codes #lg_result
     */
    extern lg_result_e lg_log(lg_logger_t* log, const char* msg);

#ifdef __cplusplus
};
#endif

#endif /* INCLUDED_CLIB_LOGGER_H */
