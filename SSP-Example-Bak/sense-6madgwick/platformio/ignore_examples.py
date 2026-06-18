Import("env")  # noqa: F821


def ignore_library_examples(env, node):
    _ = env  # Unused.

    path = str(node)

    # Ignore any source file that is part of the bmi270-pid library's examples.
    if "bmi270-pid" in path and "examples" in path.lower():
        return None

    # Otherwise, proceed with compiling it.
    return node


# Tell PlatformIO to run every source file through this filter
env.AddBuildMiddleware(ignore_library_examples)  # noqa: F821
