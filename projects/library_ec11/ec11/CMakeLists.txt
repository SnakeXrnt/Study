set(LIBRARY_NAME ec11)

add_library(${LIBRARY_NAME} STATIC)

set(GENERATED_DIR ${CMAKE_CURRENT_SOURCE_DIR}/build)
set(INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/include/rotary_encoder/${LIBRARY_NAME})

target_sources(${LIBRARY_NAME} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/program.c)

if(NOT EXISTS ${GENERATED_DIR})
  file(MAKE_DIRECTORY ${GENERATED_DIR})
endif()

target_compile_options(${LIBRARY_NAME} PRIVATE -Wall -Wextra)

target_link_libraries(${LIBRARY_NAME} PUBLIC pico_stdlib hardware_pio)

target_include_directories(${LIBRARY_NAME}
                           PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)

# Generate header files from PIO code.
pico_generate_pio_header(
  ${LIBRARY_NAME} ${CMAKE_CURRENT_SOURCE_DIR}/${LIBRARY_NAME}.pio OUTPUT_DIR
  ${GENERATED_DIR})

set(GENERATED_HEADER ${INCLUDE_DIR}/hardware.h)

add_custom_command(
  OUTPUT ${GENERATED_HEADER}
  COMMAND ${CMAKE_COMMAND} -E copy ${GENERATED_DIR}/${LIBRARY_NAME}.pio.h
          ${GENERATED_HEADER}
  DEPENDS ${GENERATED_DIR}/${LIBRARY_NAME}.pio.h)

add_custom_target(${LIBRARY_NAME}_headers ALL DEPENDS ${GENERATED_HEADER})
