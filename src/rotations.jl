
"""
An active rotation about the X axis.
"""
function Rx(θ::Real)
    o = zero(θ)
    l = one(θ)

    c = cos(θ)
    s = sin(θ)

    matrix = @SMatrix [
        l o o
        o c -s
        o s c
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
        c o s
        o l o
        -s o c
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
        c -s o
        s c o
        o o l
    ]

    return RotMatrix{3}(matrix)
end

function R(ω̂, θ)
    Sθ = sin(θ)
    Cθ = cos(θ)

    ω₁ = ω̂[begin]
    ω₂ = ω̂[begin+1]
    ω₃ = ω̂[begin+2]

    lmCθ = one(θ) - Cθ

    matrix = @SMatrix [
        (Cθ+ω₁^2*lmCθ) (ω₁*ω₂*lmCθ-ω₃*Sθ) (ω₁*ω₃*lmCθ+ω₂*Sθ)
        (ω₁*ω₂*lmCθ+ω₃*Sθ) (Cθ+ω₂^2*lmCθ) (ω₂*ω₃*lmCθ-ω₁*Sθ)
        (ω₁*ω₃*lmCθ-ω₂*Sθ) (ω₂*ω₃*lmCθ+ω₁*Sθ) (Cθ+ω₃^2*lmCθ)
    ]

    return RotMatrix{3}(matrix)
end