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

"""
A revolute joint implementation.
"""
struct RevoluteJoint{F<:Real} <: AbstractJoint 

end

"""
A prismatic joint implementation.
"""
struct PrismaticJoint{F<:Real} <: AbstractJoint end

"""
A fixed-joint implementation.
"""
struct FixedJoint <: AbstractJoint end

