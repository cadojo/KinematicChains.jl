# 
# Modified DH Parameeter Kinematics
#

#=
Base.@kwdef struct MDHParameters{F} <: FieldVector{4,F}
    a::F = 0.0
    α::F = 0.0
    d::F = 0.0
    θ::F = 0.0

    MDHParameters{F}(::UndefInitializer) where {F} = new{F}()
    MDHParameters(::UndefInitializer) = MDHParameters{Float64}(undef)

    MDHParameters{F}(a, α, d, θ) where {F} = new{F}(a, α, d, θ)
    MDHParameters(a, α, d, θ) = new{promote_type(typeof(a), typeof(α), typeof(d), typeof(θ))}(a, α, d, θ)
    MDHParameters{F}(state::NamedTuple) =
        let
            (; a, α, d, θ) = merge((; a=zero(F), α=zero(F), d=zero(F), θ=zero(F)), state)
            MDHParameters{F}(a, α, d, θ)
        end
    MDHParameters(state::NamedTuple) = MDHParameters{Float64}(state)

end

Base.@kwdef struct MDHJoint{T<:AbstractJointType,F} <: AbstractJoint{T}
    parameters::MDHParameters{F}

    MDHJoint(a, α, d, θ, type=Revolute()) = new{typeof(type),promote_type(typeof(a), tyepof(α), typeof(d), typeof(θ))}(MDHParameters(a, α, d, θ))
    MDHJoint(; a=0.0, α=0.0, d=0.0, θ=0.0, type=Revolute()) = new{typeof(type),promote_type(typeof(a), tyepof(α), typeof(d), typeof(θ))}(MDHParameters(a, α, d, θ))
end

=#

"""
Given **modified** DH parameters, return the coordinate rotation
which maps orientation i-1 to frame i.
"""
function MDHRotation(α, θ)
    R = @SMatrix [
        cos(θ) -sin(θ) 0
        sin(θ)*cos(α) cos(θ)*cos(α) -sin(α)
        sin(θ)*sin(α) cos(θ)*sin(α) cos(α)
    ]

    return LinearMap(R)
end

MDHRotation(a, α, d, θ) = MDHRotation(α, θ)

function MDHRotation(a::AbstractVecOrMat, α::AbstractVecOrMat, d::AbstractVecOrMat, θ::AbstractVecOrMat)
    return mapreduce(MDHRotation, CoordinateTransformations.compose, collect(a), collect(α), collect(d), collect(θ))
end

"""
Given **modified** DH parameters, return the translation from frame 
i-1 to frame i **without** any rotations applies.
"""
function MDHTranslation(a, α, d)
    return Translation(a, -sin(α) * d, cos(α) * d)
end

MDHTranslation(a, α, d, θ) = MDHTranslation(a, α, d)

function MDHTranslation(a::AbstractVecOrMat, α::AbstractVecOrMat, d::AbstractVecOrMat, θ::AbstractVecOrMat)
    return mapreduce(MDHTranslation, CoordinateTransformations.compose, collect(a), collect(α), collect(d), collect(θ))
end


"""
Given **modified** DH parameters, return the coordinate mapping
from frame i-1 to frame i.
"""
function MDHTransformation(a, α, d, θ)
    R = MDHRotation(a, α, d, θ).linear
    P = MDHTranslation(a, α, d).translation

    return AffineMap(R, P)
end

function MDHTransformation(a::AbstractVecOrMat, α::AbstractVecOrMat, d::AbstractVecOrMat, θ::AbstractVecOrMat)
    return mapreduce(MDHTransformation, CoordinateTransformations.compose, collect(a), collect(α), collect(d), collect(θ))
end

"""
Given **modified** DH parameters, return the coordinate frame 
matrix which maps frame i-1 to frame i.
"""
function MDHMatrix(a, α, d, θ)
    R = MDHRotation(a, α, d, θ).linear
    P = MDHTranslation(a, α, d, θ).translation

    return vcat(
        hcat(R, P),
        SMatrix{1,4}(0, 0, 0, 1)
    )
end


function MDHMatrix(a::AbstractVecOrMat, α::AbstractVecOrMat, d::AbstractVecOrMat, θ::AbstractVecOrMat)
    result = mapreduce(MDHTransformation, CoordinateTransformations.compose, collect(a), collect(α), collect(d), collect(θ))
    R = result.linear
    P = result.translation

    return vcat(
        hcat(R, P),
        SMatrix{1,4}(0, 0, 0, 1)
    )
end

struct MDHJoint{T,F} <: AbstractJoint{T}
    a::F
    α::F
    d::F
    θ::F

    MDHJoint{T}(a, α, d, θ) where {T} = new{T,promote_type(typeof(a), typeof(α), typeof(d), typeof(θ))}(a, α, d, θ)
    MDHJoint{T}(; a=0.0, α=0.0, d=0.0, θ=0.0) where {T} = MDHJoint{T}(a, α, d, θ)
end

rotation(joint::MDHJoint) = MDHRotation(joint.α, joint.θ)
translation(joint::MDHJoint) = MDHTranslation(joint.a, joint.α, joint.d)
transformation(joint::MDHJoint) = MDHTransformation(joint.a, joint.α, joint.d, joint.θ)

struct MDHChain{N,T} <: AbstractChain{N,T}
    joints::NTuple{N,T}

    function MDHCHain(joints)
        N = length(joints)
        T = NTuple{N,promote_type(typeof.(joints)...)}
        return new{N,T}(tuple(joints))
    end
end

