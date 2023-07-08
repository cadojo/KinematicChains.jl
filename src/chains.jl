#
# Kinematic Chains
#

"""
An abstract supertype for all kinematic chains.
"""
abstract type AbstractChain end

"""
An abstract supertype for all joints: connections between links 
which are a *location of interest*.
"""
abstract type AbstractJoint end

struct JointLimits{F<:Real} 
    position::NamedTuple{(:lower,:upper), Tuple{F,F}}
    velocity::NamedTuple{(:lower,:upper), Tuple{F,F}}
    acceleration::NamedTuple{(:lower,:upper), Tuple{F,F}}

    function JointLimits(; position=(-2π, +2π), velocity=(-Inf, +Inf), acceleration=(-Inf, +Inf))
        F = Base.promote_eltype(position, velocity, acceleration)
        T = NamedTuple{(:lower, :upper),Tuple{F,F}}
        return new{F}(T(position), T(velocity), T(acceleration))
    end
end

struct RevoluteJoint{F} <: AbstractJoint 

end

struct PrismaticJoint <: AbstractJoint end

struct FixedJoint <: AbstractJoint end

