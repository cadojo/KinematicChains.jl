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
    R, Rx, Ry, Rz, skew, rodrigues,
    AbstractJoint, Revolute, Prismatic, Fixed, AbstractChain,
    rotation, translation, type,
    MDHRotation, MDHTranslation, MDHTransformation, MDHMatrix, MDHJoint, MDHChain

using Rotations
using Symbolics
using StaticArrays
using LinearAlgebra
using ModelingToolkit
using CoordinateTransformations
using RequiredInterfaces

include("interface.jl")
include("skew.jl")
include("rotations.jl")
include("exp.jl")
include("log.jl")
include("spatial.jl")
include("mdh.jl")


end