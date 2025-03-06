module DataService

export fetch_data, save_data, query_data

using ..Types
using ..Helpers

# Simulated database
const db = Dict{Symbol, Vector{Any}}(
    :users => [],
    :products => [],
    :orders => []
)

"""
Fetch data from a simulated API endpoint
"""
function fetch_data(api_url::String)
    # Simulate API request
    println("Fetching data from: $api_url")
    
    # Generate sample data
    data = [
        Dict("id" => 1, "name" => "Product 1", "price" => 19.99),
        Dict("id" => 2, "name" => "Product 2", "price" => 29.99),
        Dict("id" => 3, "name" => "Product 3", "price" => 39.99)
    ]
    
    # Convert to products
    products = [Types.Product(
        d["id"],
        d["name"],
        d["price"]
    ) for d in data]
    
    # Store in the database
    append!(db[:products], products)
    
    return products
end

"""
Save data to the simulated database
"""
function save_data(entity_type::Symbol, entity::Any)
    if !haskey(db, entity_type)
        db[entity_type] = []
    end
    
    push!(db[entity_type], entity)
    return true
end

"""
Query the database for specific data
"""
function query_data(entity_type::Symbol, filter_func::Function)
    if !haskey(db, entity_type)
        return []
    end
    
    return filter(filter_func, db[entity_type])
end

end # module DataService