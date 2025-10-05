# Valgrind Memory Debugging Guide

Valgrind is a powerful memory debugging tool that helps detect memory leaks, buffer overflows, use-after-free errors, and other memory-related issues in C/C++ programs.

## Available Valgrind Tools

### 1. **Memcheck** (Default Tool)
Detects memory errors and leaks:
```bash
valgrind ./your_program
valgrind --leak-check=full ./your_program
valgrind --leak-check=full --show-leak-kinds=all ./your_program
```

### 2. **Cachegrind**
Profiles CPU cache usage:
```bash
valgrind --tool=cachegrind ./your_program
```

### 3. **Callgrind**
Profiles function call costs:
```bash
valgrind --tool=callgrind ./your_program
```

### 4. **Helgrind**
Detects thread synchronization errors:
```bash
valgrind --tool=helgrind ./your_program
```

### 5. **DRD** (Data Race Detector)
Detects data races in multithreaded programs:
```bash
valgrind --tool=drd ./your_program
```

## Common Memcheck Options

### Memory Leak Detection
```bash
# Basic leak check
valgrind --leak-check=yes ./your_program

# Full leak check with all leak kinds
valgrind --leak-check=full --show-leak-kinds=all ./your_program

# Track origins of uninitialized values
valgrind --track-origins=yes ./your_program
```

### Suppression Files
```bash
# Use suppression file to ignore known false positives
valgrind --suppressions=my_suppressions.supp ./your_program
```

### Verbose Output
```bash
# More detailed output
valgrind --verbose ./your_program

# Show all errors, even suppressed ones
valgrind -s ./your_program
```

## Example Usage in This Project

### Build Debug Version
```bash
cmake --preset debug && cmake --build --preset debug
```

### Run with Valgrind
```bash
# Basic memory check
valgrind ./build/debug/bin/hello_world

# Full memory check with leak detection
valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./build/debug/bin/hello_world

# Cache profiling
valgrind --tool=cachegrind ./build/debug/bin/hello_world
```

## Understanding Valgrind Output

### Memory Leak Types
- **Definitely lost**: Memory that was allocated but never freed
- **Indirectly lost**: Memory lost through pointers to definitely lost memory
- **Possibly lost**: Memory that might be leaked (pointers exist but may be invalid)
- **Still reachable**: Memory that's still accessible at program exit

### Common Error Types
- **Invalid read/write**: Accessing memory that shouldn't be accessed
- **Use after free**: Using memory after it's been freed
- **Double free**: Freeing the same memory twice
- **Buffer overflow**: Writing beyond allocated memory boundaries

## Best Practices

### 1. Always Use Debug Builds
```bash
# Debug builds include symbols and are not optimized
cmake --preset debug && cmake --build --preset debug
valgrind ./build/debug/bin/hello_world
```

### 2. Use Appropriate Flags
```bash
# For development
valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./your_program

# For CI/CD (suppress known issues)
valgrind --leak-check=full --error-exitcode=1 ./your_program
```

### 3. Create Suppression Files
For known false positives (like system libraries):
```bash
valgrind --gen-suppressions=all ./your_program > suppressions.supp
```

## Integration with VS Code

### Add Valgrind Task
Add to `.vscode/tasks.json`:
```json
{
    "label": "valgrind-check",
    "type": "shell",
    "command": "valgrind",
    "args": [
        "--leak-check=full",
        "--show-leak-kinds=all",
        "--track-origins=yes",
        "${workspaceFolder}/build/debug/bin/hello_world"
    ],
    "group": "test",
    "presentation": {
        "echo": true,
        "reveal": "always",
        "focus": false,
        "panel": "shared"
    },
    "dependsOn": "build-debug"
}
```

### Run Valgrind from VS Code
1. Press `Ctrl+Shift+P`
2. Type "Tasks: Run Task"
3. Select "valgrind-check"

## Performance Impact

- **Memcheck**: 10-50x slower (normal for memory debugging)
- **Cachegrind**: 20-100x slower
- **Callgrind**: 20-100x slower
- **Helgrind/DRD**: 5-20x slower

Use release builds for performance testing, debug builds for memory debugging.

## Troubleshooting

### Debug Info Issues
If you see "unhandled dwarf2" warnings:
```bash
# Ensure debug symbols are included
cmake --preset debug && cmake --build --preset debug
```

### False Positives
Create suppression files for system libraries:
```bash
valgrind --gen-suppressions=all ./your_program 2>&1 | grep -A 10 "suppress"
```

## Example Output Interpretation

```
==12345== Invalid read of size 1
==12345==    at 0x484ED16: strlen (in /usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
==12345==    by 0x109202: demonstrate_memory_issues (src/main.c:22)
==12345==  Address 0x4a8d530 is 0 bytes inside a block of size 50 free'd
==12345==    at 0x484B27F: free (in /usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
==12345==    by 0x1091F0: demonstrate_memory_issues (src/main.c:21)
==12345==  Block was alloc'd at
==12345==    at 0x4848899: malloc (in /usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
==12345==    by 0x1091D3: demonstrate_memory_issues (src/main.c:19)
```

This shows:
- **Error**: Invalid read (use after free)
- **Location**: Line 22 in `src/main.c`
- **Problem**: Reading from freed memory
- **Allocation**: Memory was allocated at line 19
- **Free**: Memory was freed at line 21
