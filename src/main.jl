#!/usr/bin/env julia

# Import modules
include("core/types.jl")
include("core/config.jl")
include("utils/helpers.jl")
include("services/data_service.jl")
include("services/analytics_service.jl")

module App

using ..Types
using ..Config
using ..Helpers
using ..DataService
using ..AnalyticsService
using Dates

function run()
    println("Starting application...")
    
    # Initialize with config
    config = Config.load_config()
    println("Loaded configuration: $(config.environment)")
    
    # Create data structures
    user = Types.User("julia_user", "password123", "user@example.com")
    println("Created user: $(user.username)")
    
    # Use utility functions
    formatted_date = Helpers.format_datetime(now())
    println("Current date: $formatted_date")
    
    # Use services
    data = DataService.fetch_data(config.api_url)
    println("Fetched $(length(data)) records")
    
    analysis = AnalyticsService.analyze_data(data)
    println("Analysis results: $analysis")
    
    println("Application finished.")
end

end # module App

# Run the application
App.run()