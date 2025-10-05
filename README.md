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

# Build default and run immediately
cmake --preset default && cmake --build --preset run-default
```

#### Build Only
```bash
# Debug build
cmake --preset debug
cmake --build --preset debug
./build-debug/bin/hello_world

# Release build
cmake --preset release
cmake --build --preset release
./build-release/bin/hello_world

# Default build
cmake --preset default
cmake --build --preset default
./build/bin/hello_world
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

- **Clang compiler** (C17 standard)
- **Clangd language server** for enhanced IntelliSense and code analysis
- **Clang-tidy** for static analysis and code quality checks
- **CMake build system** with automatic configuration
- **GDB debugger** for debugging
- **Valgrind** memory checker
- **Git** with SSH signing support
- **Docker extension** for container management
- **VSCode extensions**: clangd, CMake Tools, Docker
