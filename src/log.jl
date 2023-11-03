#
# The matrix logarithm
#

function rodrigues(R::AbstractMatrix)
    trace = tr(R)
    θ = acos((1 // 2) * (trace - one(trace)))
    ω̂ = skew((one(trace) / (2 * sin(θ)) * (R - transpose(R))))

    return ω̂, θ
end