module Config

export Configuration, load_config

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