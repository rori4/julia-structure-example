module Helpers

export format_datetime, calculate_discount, validate_email

using Dates

"""
Format a DateTime object to a human-readable string
"""
function format_datetime(dt::DateTime)
    return Dates.format(dt, "yyyy-mm-dd HH:MM:SS")
end

"""
Calculate a discounted price
"""
function calculate_discount(price::Float64, discount_percent::Float64)
    if discount_percent < 0 || discount_percent > 100
        throw(ArgumentError("Discount percentage must be between 0 and 100"))
    end
    
    discount_amount = price * (discount_percent / 100)
    return price - discount_amount
end

"""
Validate an email address using a simple regex pattern
"""
function validate_email(email::String)
    # Simple regex for email validation
    pattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
    return occursin(pattern, email)
end

"""
Generate a random ID suitable for various entities
"""
function generate_id()
    return abs(rand(Int)) % 10000
end

end # module Helpers