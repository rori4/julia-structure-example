# JuliaStructure Package

This project demonstrates how to structure a Julia package with complex modules, showing proper module organization, importing, and function reuse.

## Project Structure

```
JuliaStructure/
├── bin/                  # Executable scripts
│   ├── main             # Main application entry point
│   └── stats_app        # Alternative application that uses the same modules
├── modules/              # Shared modules that can be reused across applications
│   └── MathUtils.jl     # Reusable mathematical utility functions
├── src/                  # Source code for the package
│   ├── JuliaStructure.jl # Main module file that exports all submodules
│   ├── core/            # Core modules with data types and configurations
│   │   ├── types.jl    # Data structure definitions
│   │   └── config.jl   # Application configuration
│   ├── utils/           # Utility functions
│   │   └── helpers.jl  # Common helper functions
│   └── services/        # Service modules
│       ├── data_service.jl     # Data handling service
│       └── analytics_service.jl # Analytics service
└── test/                 # Tests
    ├── runtests.jl      # Main test file for the package
    └── test_math_utils.jl # Tests for the MathUtils module
```

## Module Overview

### Core Modules

- `Types`: Defines the main data structures (User, Product, Order)
- `Config`: Handles application configuration based on environment

### Utility Modules

- `Helpers`: Common utility functions like date formatting, validation, etc.

### Service Modules

- `DataService`: Handles data operations (fetching, saving, querying)
- `AnalyticsService`: Performs data analysis and generates reports

### Shared Modules

- `MathUtils`: Reusable statistical functions that can be used by multiple applications

## Applications

1. **Main App** (`main.jl`): Demonstrates module usage with a simulated e-commerce application
2. **Stats App** (`stats_app.jl`): Shows how to reuse the same modules in a different application

## Installation

To install this package in development mode:

```bash
git clone https://github.com/yourusername/JuliaStructure.git
cd JuliaStructure
julia --project=. -e 'using Pkg; Pkg.develop(path=".")'
```

## How to Run

### Main Application

```bash
julia --project=. bin/main
```

### Statistical Application

```bash
julia --project=. bin/stats_app
```

### Running Tests

Run the comprehensive test suite:

```bash
julia --project=. -e 'using Pkg; Pkg.test()'
```

Or run individual test files:

```bash
julia --project=. test/test_math_utils.jl
```

## Module Import Patterns

This project demonstrates several module import patterns:

1. **Package organization** with the main module file:
   ```julia
   module JuliaStructure
   export Types, Config, Helpers, DataService, AnalyticsService, MathUtils
   # includes and uses submodules
   end
   ```

2. **Using a package in scripts**:
   ```julia
   using JuliaStructure
   using JuliaStructure.MathUtils
   ```

3. **Submodule organization** within a package:
   ```julia
   module Types
   export User, Product, Order
   # type definitions
   end
   ```

4. **Importing between submodules**:
   ```julia
   using ..Types
   using ..Helpers
   ```

5. **Proper package environment activation**:
   ```julia
   import Pkg
   Pkg.activate(joinpath(@__DIR__, ".."))
   ```

## Function Reuse Examples

This project demonstrates how functions can be reused across modules:

1. **Utility functions** from `Helpers` are used by service modules
2. **Data structures** from `Types` are used across the application
3. **Shared mathematical operations** from `MathUtils` are used in different applications