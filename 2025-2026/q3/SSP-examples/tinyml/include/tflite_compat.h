/*
 * Copyright (C) 2025 Kiril V. Strezikozin
 *
 * SPDX-License-Identifier: MIT
 */

#ifndef TFLITE_COMPAT_H
#define TFLITE_COMPAT_H

// Convenience header for TensorFlow Lite includes
// The Arduino macro undefs should already be done in main.cpp
// before including this header
#include <TensorFlowLite.h>
#include <tensorflow/lite/micro/micro_interpreter.h>
#include <tensorflow/lite/micro/micro_mutable_op_resolver.h>
#include <tensorflow/lite/schema/schema_generated.h>

#endif /* TFLITE_COMPAT_H */
