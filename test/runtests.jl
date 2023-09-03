using Test
using CoordinateTransformations
using KinematicChains

@testset "Constructors" begin
    @test MDHTranslation(0,0,0,0) isa Transformation
    @test MDHRotation(0,0,0,0) isa Transformation
    @test MDHTransformation(0,0,0,0) isa Transformation
    @test MDHMatrix(0,0,0,0) isa AbstractMatrix

    @test MDHTranslation([0],[0],[0],[0]) isa Transformation
    @test MDHRotation([0],[0],[0],[0]) isa Transformation
    @test MDHTransformation([0],[0],[0],[0]) isa Transformation
    @test MDHMatrix([0],[0],[0],[0]) isa AbstractMatrix
end