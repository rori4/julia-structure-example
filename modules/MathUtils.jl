module MathUtils

export calculate_mean, calculate_median, calculate_variance, calculate_std

"""
Calculate the mean of a vector of numbers
"""
function calculate_mean(values::Vector{<:Real})
    if isempty(values)
        throw(ArgumentError("Cannot calculate mean of an empty vector"))
    end
    
    return sum(values) / length(values)
end

"""
Calculate the median of a vector of numbers
"""
function calculate_median(values::Vector{<:Real})
    if isempty(values)
        throw(ArgumentError("Cannot calculate median of an empty vector"))
    end
    
    sorted_values = sort(values)
    n = length(sorted_values)
    
    if n % 2 == 0  # Even number of elements
        middle1 = sorted_values[div(n, 2)]
        middle2 = sorted_values[div(n, 2) + 1]
        return (middle1 + middle2) / 2
    else  # Odd number of elements
        return sorted_values[div(n + 1, 2)]
    end
end

"""
Calculate the variance of a vector of numbers
"""
function calculate_variance(values::Vector{<:Real})
    if length(values) < 2
        throw(ArgumentError("Need at least 2 values to calculate variance"))
    end
    
    mean_val = calculate_mean(values)
    squared_diffs = [(x - mean_val)^2 for x in values]
    
    return sum(squared_diffs) / (length(values) - 1)  # Sample variance
end

"""
Calculate the standard deviation of a vector of numbers
"""
function calculate_std(values::Vector{<:Real})
    return sqrt(calculate_variance(values))
end

end # module MathUtils