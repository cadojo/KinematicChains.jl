"""
Kinematic models for serial and parallel robotic manipulators.

# Extended Help

## Exports

$(EXPORTS)

## Imports

$(IMPORTS)
"""
module KinematicChains

using DocStringExtensions
include("docstrings.jl")

export 
    Rx, Ry, Rz, skew,
    MDHRotation, MDHTranslation, MDHTransformation, MDHMatrix

using Rotations
using Symbolics
using StaticArrays
using LinearAlgebra
using ModelingToolkit
using CoordinateTransformations

"""
The skew-symmetric matrix, which represents the vector cross-product.
"""
skew(x::Real, y::Real, z::Real) = @SMatrix [
    zero(x) -z y
     z zero(y) -x
     -y x zero(z)
]

function skew(vector::AbstractVecOrMat) 
    x, y, z = vector
    return skew(x, y, z)
end

"""
An active rotation about the X axis.
"""
function Rx(θ::Real)
    o = zero(θ)
    l = one(θ)
    
    c = cos(θ)
    s = sin(θ)

    matrix = @SMatrix [
        l  o  o
        o  c -s
        o  s  c
    ]

    return RotMatrix{3}(matrix)
end

"""
An active rotation about the Y axis.
"""
function Ry(θ::Real)
    o = zero(θ)
    l = one(θ)
    
    c = cos(θ)
    s = sin(θ)

    matrix = @SMatrix [
         c  o  s
         o  l  o
        -s  o  c
    ]

    return RotMatrix{3}(matrix)
end

"""
An active rotation about the Z axis.
"""
function Rz(θ::Real)
    o = zero(θ)
    l = one(θ)
    
    c = cos(θ)
    s = sin(θ)

    matrix = @SMatrix [
        c -s  o
        s  c  o
        o  o  l
    ]

    return RotMatrix{3}(matrix)
end

include("mdh.jl")


end