"""
Kinematic models for serial and parallel robotic manipulators.

# Extended Help

## Exports

$(EXPORTS)

## Imports

$(IMPORTS)
"""
module ManipulatorKinematics

using DocStringExtensions
include("docstrings.jl")

export 
    Rx, Ry, Rz,
    Transform, transform

using Rotations
using Symbolics
using StaticArrays
using LinearAlgebra
using ModelingToolkit
using BlockArrays
using CoordinateTransformations

# TODO: should I use an adjoint, or a transpose, below?

"""
An active rotation about the X axis.
"""
Rx(θ) = RotX(θ)'

"""
An active rotation about the Y axis.
"""
Ry(θ) = RotY(θ)'

"""
An active rotation about the Z axis.
"""
Rz(θ) = RotZ(θ)'


"""
A full 6DOF Cartesian state for robotic manipulators. The orientation is an **active** rotation.
"""
struct Transform{F<:Real} <: Transformation  
    position::SVector{3,F}
    orientation::Rotations.Rotation{3,F}

    function Transform(position, orientation) 
        F = Base.promote_eltype(position, orientation)
        new{F}(SVector{3,F}(position), orientation)
    end

    function Transform(::LinearAlgebra.UniformScaling{F}) where F
        return new{F}(zeros(F, 3), Rotations.RotMatrix{3,F}(I))
    end
end

"""
Given **modified** DH parameters, return the transformation matrix
which maps frame i-1 to frame i.
"""
function Transform(α::Real, a::Real, d::Real, θ::Real)
    R = @SMatrix [
        cos(θ) -sin(θ) 0
        sin(θ)*cos(α) cos(θ)*cos(α) -sin(α)
        sin(θ)*sin(α) cos(θ)*sin(α) cos(α)
    ]
    P = @SMatrix [
        a
        -sin(α)*d
        cos(α)*d
    ]
    
    Transform(P, R)
end

function Base.collect(transform::Transform{F}) where {F}
    return Matrix(BlockArrays.mortar(transform))
end

function BlockArrays.mortar(transform::Transform{F}) where {F}
    R = Rotations.RotMatrix{3,F}(transform.orientation)
    P = SMatrix{3,1,F}(transform.position)
    Z = SMatrix{1,3,F}(zero(F), zero(F), zero(F))
    O = SMatrix{1,1,F}(one(F))

    return mortar(reshape([R,Z,P,O], 2, 2))
end

function Base.show(io::Core.IO, mime::MIME"text/plain", state::Transform{F}) where F
    println(io, "6DOF ", typeof(state))
    Base.print_matrix(io, BlockArrays.mortar(state))
end

end # module ManipulatorKinematics
