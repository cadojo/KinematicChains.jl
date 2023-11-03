#
# Spatial velocity
#

function twist(ωₛ, p, ṗ)
    vₛ = ṗ - ωₛ × p
    return vcat(ωₛ, vₛ)
end

function twist(T::AbstractMatrix, Ṫ::AbstractMatrix)
    M = inv(T) * Ṫ
    R = SMatrix{3,3}(@views M[begin:begin+2, begin:begin+2])
    p = SVector{3}(@views M[begin:begin+2, begin+3])

    return vcat(skew(R), p)
end

body_twist_to_spatial(Vᵦ, T) = T * Vᵦ * inv(T)
spatial_twist_to_body(Vₛ, T) = inv(T) * Vₛ * T