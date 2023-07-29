#
# Abstract interfaces, and implementations, for revolute, prismatic, and fixed joints
#

abstract type AbstractJoint end

abstract type AbstractRevoluteJoint <: AbstractJoint end

abstract type AbstractPrismaticJoint <: AbstractJoint end

abstract type AbstractFixedJoint <: AbstractJoint end

struct RevoluteJoint{F<:Real} <: AbstractRevoluteJoint
    rotation::RotMatrix{3,F}
    translation::SVector{3,F}
end

