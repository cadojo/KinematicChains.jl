#
# The abstract interface for all joints, and chains
#

abstract type AbstractJointType end
struct Revolute <: AbstractJointType end
struct Prismatic <: AbstractJointType end
struct Fixed <: AbstractJointType end

abstract type AbstractJoint{T<:AbstractJointType} end

@required AbstractJoint begin
    rotation(::AbstractJoint, q)
    translation(::AbstractJoint, q)
    transformation(::AbstractJoint, q)
end

Base.@pure type(::AbstractJoint{T}) where {T} = T

abstract type AbstractChain{N,T<:NTuple{N,<:AbstractJointType}} end

@required AbstractChain begin
    rotation(::AbstractChain, q)
    translation(::AbstractChain, q)
    transformation(::AbstractChain, q)
end