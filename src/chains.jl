#
# Kinematic Chains
#

"""
An abstract supertype for all kinematic chains.
"""
abstract type AbstractChain end

"""
An abstract supertype for all serial kinematic chains.
"""
abstract type AbstractSerialChain <: AbstractChain end

"""
An abstract supertype for all parallel kinematic chains.
"""
abstract type AbstractParallelChain <: AbstractChain end

"""
An abstract supertype for all joints.
"""
abstract type AbstractJoint end

"""
An abstract supertype for revolute joints.
"""
abstract type AbstractRevoluteJoint end

"""
An abstract supertype for prismatic joints.
"""
abstract type AbstractPrismaticJoint end

"""
An abstract supertype for all joint constraints.
"""
abstract type AbstractJointConstraints end

struct JointLimits{F<:Real} <: AbstractJointConstraints
    position::NamedTuple{(:lower,:upper), Tuple{F,F}}
    velocity::NamedTuple{(:lower,:upper), Tuple{F,F}}
    acceleration::NamedTuple{(:lower,:upper), Tuple{F,F}}

    function JointLimits(; position=(-Inf, +Inf), velocity=(-Inf, +Inf), acceleration=(-Inf, +Inf))
        F = Base.promote_eltype(position, velocity, acceleration)
        T = NamedTuple{(:lower, :upper),Tuple{F,F}}
        return new{F}(T(position), T(velocity), T(acceleration))
    end
end

"""
A revolute joint implementation.
"""
struct RevoluteJoint{F<:Real} <: AbstractRevoluteJoint
    limits::JointLimits{F}

    RevoluteJoint(; )
end

"""
A prismatic joint implementation.
"""
struct PrismaticJoint{F<:Real} <: AbstractPrismaticJoint end

"""
A fixed-joint implementation.
"""
struct FixedJoint <: AbstractJoint end

struct SerialChain{F<:Real}