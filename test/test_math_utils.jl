#!/usr/bin/env julia

# Use the project environment
import Pkg
Pkg.activate(joinpath(@__DIR__, ".."))

# Import the package
using JuliaStructure
using JuliaStructure.MathUtils

# Test the mean function
function test_mean()
    println("Testing mean function...")
    
    # Test case 1: Basic test
    data = [1, 2, 3, 4, 5]
    expected = 3.0
    result = calculate_mean(data)
    println("Mean of $data: Expected=$expected, Got=$result")
    @assert result == expected "Mean calculation failed"
    
    # Test case 2: Negative numbers
    data = [-10, -5, 0, 5, 10]
    expected = 0.0
    result = calculate_mean(data)
    println("Mean of $data: Expected=$expected, Got=$result")
    @assert result == expected "Mean calculation with negative numbers failed"
    
    # Test case 3: Floating point numbers
    data = [1.5, 2.5, 3.5]
    expected = 2.5
    result = calculate_mean(data)
    println("Mean of $data: Expected=$expected, Got=$result")
    @assert result == expected "Mean calculation with floating point failed"
    
    println("Mean function tests passed!")
end

# Test the median function
function test_median()
    println("\nTesting median function...")
    
    # Test case 1: Odd number of elements
    data = [1, 3, 2, 5, 4]
    expected = 3.0
    result = calculate_median(data)
    println("Median of $data: Expected=$expected, Got=$result")
    @assert result == expected "Median calculation with odd number of elements failed"
    
    # Test case 2: Even number of elements
    data = [1, 3, 2, 4]
    expected = 2.5
    result = calculate_median(data)
    println("Median of $data: Expected=$expected, Got=$result")
    @assert result == expected "Median calculation with even number of elements failed"
    
    println("Median function tests passed!")
end

# Test the variance function
function test_variance()
    println("\nTesting variance function...")
    
    # Test case: Basic test
    data = [2, 4, 4, 4, 5, 5, 7, 9]
    expected = 4.5714285714285715  # Calculated manually
    result = calculate_variance(data)
    println("Variance of $data: Expected=$expected, Got=$result")
    @assert isapprox(result, expected) "Variance calculation failed"
    
    println("Variance function tests passed!")
end

# Test the standard deviation function
function test_std()
    println("\nTesting standard deviation function...")
    
    # Test case: Basic test
    data = [2, 4, 4, 4, 5, 5, 7, 9]
    expected = 2.1381  # Rounded for display
    result = calculate_std(data)
    println("Standard deviation of $data: Expected≈$expected, Got=$result")
    @assert isapprox(result, sqrt(4.5714285714285715)) "Standard deviation calculation failed"
    
    println("Standard deviation function tests passed!")
end

# Run all tests
function run_tests()
    println("Running MathUtils tests...")
    test_mean()
    test_median()
    test_variance()
    test_std()
    println("\nAll tests passed!")
end

# Run the tests
run_tests()