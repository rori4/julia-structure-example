module Types

export User, Product, Order

struct User
    username::String
    password::String
    email::String
end

struct Product
    id::Int
    name::String
    price::Float64
end

struct Order
    id::Int
    user::User
    products::Vector{Product}
    total::Float64
    
    # Constructor with calculated total
    function Order(id::Int, user::User, products::Vector{Product})
        total = isempty(products) ? 0.0 : sum(p.price for p in products)
        new(id, user, products, total)
    end
end

end # module Types
