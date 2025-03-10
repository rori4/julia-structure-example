#!/usr/bin/env julia

# Add parent directory to LOAD_PATH
push!(LOAD_PATH, joinpath(@__DIR__, ".."))

# Import shared module
include(joinpath(@__DIR__, "..", "modules", "MathUtils.jl"))

# Import our core modules
include("core/types.jl")
include("utils/helpers.jl")

module StatsApp

using ..MathUtils
using ..Types
using ..Helpers
using Dates

function run()
    println("Starting Stats Application...")
    println("Current time: $(Helpers.format_datetime(now()))")
    
    # Sample dataset creation
    println("\nCreating sample dataset...")
    products = [
        Types.Product(1, "Laptop", 1200.0),
        Types.Product(2, "Phone", 800.0),
        Types.Product(3, "Tablet", 500.0),
        Types.Product(4, "Monitor", 300.0),
        Types.Product(5, "Keyboard", 100.0),
    ]
    
    println("Created $(length(products)) products")
    
    # Extract prices for analysis
    prices = [p.price for p in products]
    println("\nProduct prices: $prices")
    
    # Use the shared MathUtils module for calculations
    println("\nPerforming statistical analysis...")
    mean_price = MathUtils.calculate_mean(prices)
    median_price = MathUtils.calculate_median(prices)
    variance = MathUtils.calculate_variance(prices)
    std_dev = MathUtils.calculate_std(prices)
    
    # Print results
    println("Mean price: \$$(round(mean_price, digits=2))")
    println("Median price: \$$(round(median_price, digits=2))")
    println("Price variance: $(round(variance, digits=2))")
    println("Price standard deviation: $(round(std_dev, digits=2))")
    
    # Apply discount using helper function
    discount_percent = 15.0
    println("\nCalculating $(discount_percent)% discount on all products...")
    
    discounted_prices = [
        Helpers.calculate_discount(p.price, discount_percent) for p in products
    ]
    
    println("Original prices: $prices")
    println("Discounted prices: $discounted_prices")
    
    # Calculate savings
    total_original = sum(prices)
    total_discounted = sum(discounted_prices)
    savings = total_original - total_discounted
    
    println("\nTotal original price: \$$(round(total_original, digits=2))")
    println("Total after discount: \$$(round(total_discounted, digits=2))")
    println("Total savings: \$$(round(savings, digits=2))")
    
    println("\nApplication finished.")
end

end # module StatsApp

# Run the application
StatsApp.run()