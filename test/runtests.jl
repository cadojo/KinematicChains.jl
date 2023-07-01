using Test
using Rotations, LinearAlgebra
using ManipulatorKinematics

@testset "Constructors" begin
    @test Transform(
           zeros(3), QuatRotation(I(3)),
    ) isa Transform{Float64}
end