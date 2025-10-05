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
│   ├── GIT_SETUP.md        # Git setup documentation
│   └── setup-git.sh        # Git configuration setup script
├── src/
│   └── main.c              # Main C source file
├── build/                  # Build output directory
│   └── debug/             # Debug build artifacts
│       ├── bin/           # Debug executables
│       └── ...            # CMake build files
├── .clang-format           # Code formatting configuration
├── .clang-tidy             # Static analysis configuration  
├── .clangd                 # Language server configuration
├── CMakeLists.txt          # CMake build configuration
├── CMakePresets.json       # CMake preset configurations
├── GITHUB_ACTIONS_GUIDE.md # GitHub Actions CI documentation
├── VALGRIND_GUIDE.md       # Valgrind memory debugging guide
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
- **Valgrind** memory checker for detecting leaks, buffer overflows, and memory errors
- **Git** with SSH signing support
- **Docker extension** for container management
- **VSCode extensions**: clangd, CMake Tools, Docker, CodeLLDB, GitHub Actions

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

## Memory Debugging with Valgrind

Valgrind is integrated for detecting memory leaks, buffer overflows, and other memory issues:

### Command Line Usage
```bash
# Basic memory check
valgrind ./build/debug/bin/hello_world

# Full memory check with leak detection
valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./build/debug/bin/hello_world

# Cache profiling
valgrind --tool=cachegrind ./build/debug/bin/hello_world
```

### VS Code Integration
- **Press `Ctrl+Shift+P`** → "Tasks: Run Task" → "valgrind-check"
- **Or use the terminal**: `valgrind --leak-check=full ./build/debug/bin/hello_world`

### What Valgrind Detects
- **Memory leaks** (allocated but never freed)
- **Buffer overflows** (writing beyond allocated memory)
- **Use after free** (accessing freed memory)
- **Double free** (freeing the same memory twice)
- **Uninitialized memory** access

See `VALGRIND_GUIDE.md` for comprehensive usage instructions.

## Documentation

The project includes comprehensive documentation for various development workflows:

### 📚 **Available Guides**

#### **`GITHUB_ACTIONS_GUIDE.md`**
- **CI/CD workflow** setup and configuration
- **GitHub Actions** integration and automation
- **Build pipeline** management and troubleshooting
- **Artifact handling** and deployment strategies

#### **`VALGRIND_GUIDE.md`**
- **Memory debugging** with Valgrind Memcheck
- **Performance profiling** with Cachegrind
- **Memory leak detection** and analysis
- **Advanced Valgrind** usage patterns and tips

#### **`.devcontainer/GIT_SETUP.md`**
- **Git configuration** setup in dev containers
- **SSH key management** and commit signing
- **Troubleshooting** common Git issues
- **Security best practices** for development

### 📖 **Quick Reference**

| Guide | Purpose | When to Use |
|-------|---------|-------------|
| `GITHUB_ACTIONS_GUIDE.md` | CI/CD workflows | Setting up automated builds and testing |
| `VALGRIND_GUIDE.md` | Memory debugging | Finding memory leaks and performance issues |
| `GIT_SETUP.md` | Git configuration | Troubleshooting Git setup in containers |

## Static Analysis with clang-tidy

The project includes a comprehensive clang-tidy configuration (`.clang-tidy`) with 200+ checks:

### Check Categories Enabled

#### 🐛 **Bug Detection (`bugprone-*`):**
- **Buffer overflows** and null pointer dereferences
- **Memory leaks** and use-after-free detection
- **Infinite loops** and suspicious conditions
- **Macro issues** and string handling problems
- **Narrowing conversions** and type safety

#### 🚀 **Performance (`performance-*`):**
- **Inefficient loops** and unnecessary copies
- **Move semantics** and copy optimization
- **Type promotions** in math functions
- **Automatic move** detection

#### 📖 **Readability (`readability-*`):**
- **Function complexity** (max 20 cognitive complexity)
- **Function size** (max 50 lines)
- **Identifier naming** (min 3 characters)
- **Code formatting** and brace usage
- **Magic numbers** detection

#### 🔄 **Modernization (`modernize-*`):**
- **Deprecated functions** detection
- **Loop conversion** suggestions
- **Auto keyword** usage
- **Nullptr** instead of NULL
- **Override** keyword usage

#### 🛡️ **Security (`cert-*`):**
- **Buffer overflow** prevention
- **Integer overflow** detection
- **Unsafe functions** warnings
- **Memory management** issues

### Usage

#### **Command Line:**
```bash
# Basic analysis
clang-tidy src/main.c -- -Ibuild/debug -std=c17

# With specific checks
clang-tidy -checks='bugprone-*,performance-*' src/main.c -- -Ibuild/debug -std=c17
```

#### **VS Code Integration:**
- **Real-time analysis** with clangd extension
- **Error highlighting** in editor
- **Quick fixes** for common issues
- **Hover information** for warnings

#### **CI Integration:**
- **Automated analysis** on every commit
- **Error reporting** in pull requests
- **Artifact upload** for detailed reports

### Configuration

The `.clang-tidy` file includes:
- **200+ enabled checks** across all categories
- **Custom thresholds** for complexity and size
- **Naming conventions** for identifiers
- **Performance warnings** configuration
- **Excluded checks** for C++-specific rules

### Example Output

```
src/main.c:30:9: warning: variable name 'i' is too short, expected at least 3 characters [readability-identifier-length]
src/main.c:31:5: warning: kernel performance could be improved by unrolling this loop [altera-unroll-loops]
src/main.c:39:19: warning: parameter name 'a' is too short [readability-identifier-length]
src/main.c:41:19: warning: statement should be inside braces [readability-braces-around-statements]
src/main.c:51:30: warning: narrowing conversion from 'unsigned long' to signed type 'int' [bugprone-narrowing-conversions]
```

## Continuous Integration

The project includes a comprehensive GitHub Actions CI workflow that runs on every push and pull request:

### CI Pipeline Features

#### ✅ **Multi-Build Testing:**
- **Debug build** with full debugging symbols
- **Release build** with maximum optimization
- **Parallel builds** using all available CPU cores

#### ✅ **Static Analysis:**
- **clang-tidy** with comprehensive checks (200+ rules)
- **Bug detection** (buffer overflows, null pointer derefs, etc.)
- **Performance analysis** (inefficient loops, unnecessary copies)
- **Code style** enforcement (naming, formatting, complexity)
- **Modern C practices** (deprecated functions, best practices)
- **C17 standard** compliance verification
- **Warning detection** with `-Wall -Wextra`

#### ✅ **Dynamic Analysis:**
- **Valgrind Memcheck** for memory leak detection
- **Valgrind Cachegrind** for performance profiling
- **Both debug and release** builds tested

#### ✅ **Artifact Management:**
- **Build artifacts** uploaded for inspection
- **Valgrind reports** preserved for analysis
- **7-day retention** for debugging failed builds

### CI Workflow Triggers
- **Push** to `main` or `master` branch
- **Pull requests** targeting `main` or `master` branch

### Viewing CI Results

#### **GitHub Actions Extension (VS Code):**
- **Real-time workflow status** in the sidebar
- **Pinned workflows** for quick access
- **Log viewing** directly in VS Code
- **Workflow management** and re-running
- **Artifact download** from the editor

#### **GitHub Web Interface:**
1. Go to your GitHub repository
2. Click on **"Actions"** tab
3. Select the workflow run
4. Download artifacts for detailed analysis

### GitHub Actions Extension Features

The dev container includes the **GitHub Actions extension** with:

#### ✅ **Workflow Management:**
- **Pin workflows** for quick access
- **View workflow status** in real-time
- **Re-run failed workflows** with one click
- **Cancel running workflows** when needed

#### ✅ **Log Integration:**
- **View logs** directly in VS Code
- **Syntax highlighting** for YAML workflows
- **Error highlighting** and navigation
- **Step-by-step execution** tracking

#### ✅ **Artifact Management:**
- **Download artifacts** from VS Code
- **Browse build outputs** without leaving the editor
- **Valgrind reports** accessible locally
- **Build artifacts** inspection

#### ✅ **Development Workflow:**
- **Edit workflows** with IntelliSense
- **Validate YAML** syntax
- **Quick actions** for common tasks
- **Integration** with Git operations
