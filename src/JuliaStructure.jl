module JuliaStructure

# Export modules
export Types, Config, Helpers, DataService, AnalyticsService, MathUtils

# Include core modules
include("core/types.jl")
include("core/config.jl")
include("utils/helpers.jl")
include("services/data_service.jl")
include("services/analytics_service.jl")

# Include shared modules
include(joinpath(@__DIR__, "..", "modules", "MathUtils.jl"))

# Re-export modules from their namespaces
using .Types
using .Config
using .Helpers
using .DataService
using .AnalyticsService
using .MathUtils

end # module JuliaStructure