# C Project Template Using DevContainer

A minimal C project template with CMake build system and VSCode devcontainer.

## Features

- Simple C program with standard directory structure
- CMake build system configured for C17 standard
- Clang compiler with clangd for enhanced IntelliSense
- VSCode devcontainer with Docker
- Essential C development tools pre-installed

## Getting Started

1. Open this project in VSCode
2. When prompted, click "Reopen in Container" or use Command Palette: `Dev Containers: Reopen in Container`
3. The container will automatically build the project
4. Run the program: `./build/bin/hello_world`

## Project Structure

```
.
├── .devcontainer/
│   ├── devcontainer.json   # VSCode devcontainer configuration
│   ├── Dockerfile          # Docker image definition
│   └── setup-git.sh        # Git configuration setup script
├── src/
│   └── main.c              # Main C source file
├── .clang-format           # Code formatting configuration
├── .clang-tidy             # Static analysis configuration  
├── .clangd                 # Language server configuration
├── CMakeLists.txt          # CMake build configuration
├── CMakePresets.json       # CMake preset configurations
├── .gitignore             # Git ignore rules
└── README.md              # This file
```

## Building

### Using CMake Presets (Recommended)

#### Build and Run (One Command)
```bash
# Build debug and run immediately
cmake --preset debug && cmake --build --preset run-debug

# Build release and run immediately
cmake --preset release && cmake --build --preset run-release
```

#### Build Only
```bash
# Debug build
cmake --preset debug
cmake --build --preset debug
./build/debug/bin/hello_world

# Release build
cmake --preset release
cmake --build --preset release
./build/release/bin/hello_world
```

### Manual Building

```bash
mkdir build
cd build
cmake ..
make
./bin/hello_world
```

## Code Quality Tools

The project includes comprehensive code quality configurations:

### `.clang-format`
- **LLVM-based style** with C-specific adjustments
- **4-space indentation** with Linux brace style
- **100-character line limit** for readability
- **Automatic include sorting** and formatting

### `.clang-tidy`
- **C-focused static analysis** checks
- **Bug detection** and performance analysis
- **Code style enforcement** with snake_case naming
- **Security checks** (CERT guidelines)

### `.clangd`
- **C17 standard** support with background indexing
- **Inlay hints** for parameters and types
- **Integration** with clang-format and clang-tidy

These tools provide:
- Real-time code formatting and linting
- Advanced code completion and navigation
- Static analysis and bug detection
- Consistent code style enforcement

## Development Tools Included

- **Clang compiler** (C17 standard) with maximum optimization for release builds
- **Clangd language server** for enhanced IntelliSense and code analysis
- **Clang-tidy** for static analysis and code quality checks
- **CMake build system** with automatic configuration
- **LLDB debugger** for debugging (integrated with clangd)
- **Valgrind** memory checker
- **Git** with SSH signing support
- **Docker extension** for container management
- **VSCode extensions**: clangd, CMake Tools, Docker, CodeLLDB

## Build Configurations

### Debug Build
- **Optimization**: `-O0` (no optimization for easier debugging)
- **Debug symbols**: `-g` (full debugging information)
- **Warnings**: `-Wall -Wextra` (comprehensive warning detection)
- **Size**: ~17KB (with debug symbols)

### Release Build (Maximum Optimization)
- **Optimization**: `-O3` (maximum speed optimization)
- **Link-time optimization**: `-flto` (whole-program optimization)
- **CPU-specific**: `-march=native -mtune=native` (optimized for current CPU)
- **Math optimization**: `-ffast-math` (aggressive floating-point optimizations)
- **Loop optimization**: `-funroll-loops` (unroll loops for speed)
- **Frame pointer**: `-fomit-frame-pointer` (smaller, faster code)
- **Dead code elimination**: `-Wl,--gc-sections` (remove unused code)
- **Symbol stripping**: `-Wl,--strip-all` (remove debug symbols)
- **Size**: ~15KB (highly optimized)

## Debugging

The project is configured for debugging with LLDB (Low Level Debugger) which integrates seamlessly with clangd:

### VS Code Debugging
1. **Set breakpoints** by clicking in the gutter next to line numbers
2. **Press F5** or go to Run and Debug panel
3. **Select debug configuration**:
   - "Debug with LLDB" (debug build)

### Debug Features
- **Breakpoints** and step-through debugging
- **Variable inspection** and watch expressions
- **Call stack** navigation
- **Integrated terminal** for LLDB commands
- **Automatic build** before debugging

### Command Line Debugging
```bash
# Build debug version
cmake --preset debug && cmake --build --preset debug

# Debug with LLDB
lldb build/debug/bin/hello_world
(lldb) breakpoint set --name main
(lldb) run
```
