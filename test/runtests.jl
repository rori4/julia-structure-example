using Test
using JuliaStructure
using Dates

# Include all test files
include("test_math_utils.jl")
include("test_services.jl")
include("test_utils.jl")
include("test_core.jl")

@testset "JuliaStructure.jl" begin
    # Run all tests from included files
    include("test_math_utils.jl")
    include("test_services.jl")
    include("test_utils.jl")
    include("test_core.jl")
end
