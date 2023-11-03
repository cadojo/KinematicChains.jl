#
# The matrix exponential
#

function rodrigues(ω̂, θ)
    Ω = skew(ω̂)
    return I(3) + sin(θ) * Ω + (one(θ) - cos(θ)) * Ω^2
end