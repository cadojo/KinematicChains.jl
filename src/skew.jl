"""
The skew-symmetric matrix, which represents the vector cross-product.
"""
skew(x::Real, y::Real, z::Real) = @SMatrix [
    zero(x) -z y
    z zero(y) -x
    -y x zero(z)
]

function skew(vector::Union{<:AbstractVector,Tuple})
    x, y, z = vector
    return skew(x, y, z)
end

function skew(matrix::AbstractMatrix)
    x = matrix[begin+2, begin+1]
    y = matrix[begin, begin+2]
    z = matrix[begin+1, begin]

    return @SVector [x, y, z]
end
