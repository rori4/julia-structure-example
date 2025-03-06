module Config

export Configuration, load_config

# Maximum number of products allowed in a single order
const MAX_PRODUCTS_PER_ORDER = 50

# Default discount percentage for promotions
const DEFAULT_DISCOUNT_PERCENT = 10.0

# API version for external services
const API_VERSION = "v1.0"

struct Configuration
    environment::String
    debug::Bool
    api_url::String
    max_connections::Int
end

"""
Load configuration based on environment variable or default to development
"""
function load_config()
    env = get(ENV, "JULIA_ENV", "development")
    
    if env == "production"
        return Configuration(
            "production",
            false,
            "https://api.example.com/v1",
            100
        )
    elseif env == "testing"
        return Configuration(
            "testing",
            true,
            "https://test-api.example.com/v1",
            10
        )
    else # development
        return Configuration(
            "development",
            true,
            "http://localhost:3000/api",
            5
        )
    end
end

end # module Config
