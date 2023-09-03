# 
# Modified DH Parameeter Kinematics
#

"""
Given **modified** DH parameters, return the coordinate rotation
which maps orientation i-1 to frame i.
"""
function MDHRotation(α::Real, a::Real, d::Real, θ::Real)
    R = @SMatrix [
        cos(θ) -sin(θ) 0
        sin(θ)*cos(α) cos(θ)*cos(α) -sin(α)
        sin(θ)*sin(α) cos(θ)*sin(α) cos(α)
    ]

    return LinearMap(R)
end


function MDHRotation(α::AbstractVecOrMat, a::AbstractVecOrMat, d::AbstractVecOrMat, θ::AbstractVecOrMat)
    return mapreduce(MDHRotation, CoordinateTransformations.compose, α, a, d, θ)
end

"""
Given **modified** DH parameters, return the translation from frame 
i-1 to frame i **without** any rotations applies.
"""
function MDHTranslation(α::Real, a::Real, d::Real, θ::Real)
    return Translation(a, -sin(α) * d, cos(α) * d)
end

function MDHTranslation(α::AbstractVecOrMat, a::AbstractVecOrMat, d::AbstractVecOrMat, θ::AbstractVecOrMat)
    return mapreduce(MDHTranslation, CoordinateTransformations.compose, α, a, d, θ)
end


"""
Given **modified** DH parameters, return the coordinate mapping
from frame i-1 to frame i.
"""
function MDHTransformation(α::Real, a::Real, d::Real, θ::Real)
    R = MDHRotation(α, a, d, θ).linear
    P = MDHTranslation(α, a, d, θ).translation

    return AffineMap(R,P)
end

function MDHTransformation(α::AbstractVecOrMat, a::AbstractVecOrMat, d::AbstractVecOrMat, θ::AbstractVecOrMat)
    return mapreduce(MDHTransformation, CoordinateTransformations.compose, α, a, d, θ)
end

"""
Given **modified** DH parameters, return the coordinate frame 
matrix which maps frame i-1 to frame i.
"""
function MDHMatrix(α::Real, a::Real, d::Real, θ::Real)
    R = MDHRotation(α, a, d, θ).linear
    P = MDHTranslation(α, a, d, θ).translation

    return vcat(
        hcat(R, P),
        SMatrix{1,4}(0,0,0,1)
    )
end


function MDHMatrix(α::AbstractVecOrMat, a::AbstractVecOrMat, d::AbstractVecOrMat, θ::AbstractVecOrMat)
    result = mapreduce(MDHTransformation, CoordinateTransformations.compose, α, a, d, θ)
    R = result.linear
    P = result.translation

    return vcat(
        hcat(R, P),
        SMatrix{1,4}(0,0,0,1)
    )
end
