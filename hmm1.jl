using Distributions


N = 2 # K in HMMBase.jl == unique(X) == unique(z1)
Π = fill(1//N, N)

A = [1//4 3//4; 3//4 1//4]
@assert all(sum.(eachrow(A)) .== 1)

x = [3//8 1//8]
vx = vec(x)

B = Dict( 
'p' => vx,
't' => vx,
'a' => reverse(vx),
'i' => reverse(vx)
)
K = collect(keys(B))

# lol
# hard to index and be sure using right char (as opposed to a dict)
omat = vcat(repeat(x, 2), repeat(reverse(x, dims=2), 2))

# could do dict of vector probs for observations?

O = "tipa"
T = length(O)

z1 = [1, 2, 1, 2, 1] # X
z2 = [1, 1, 2, 2, 2] # X

function path_prob(X, A, Π)
    p = Π[X[1]]
    for t in zip(X[1:end-1], X[2:end]) # from, to
        p *= A[t[1], t[2]]
    end
    p
end

gs = path_prob(z1, A, Π)
bs = path_prob(z2, A, Π)


function obs_prob(X, O, B)
    @assert length(X) == length(O) + 1
    obs_prob = 1//1
    d = collect(zip(collect(O), X[1:end-1])) # in this case O a str 
    for s in d 
        op = B[s[1]][s[2]]
        obs_prob *= op
        println("$s: $op")
    end
    obs_prob
end

bo = obs_prob(z1, out, dict_a)
go = obs_prob(z2, out, dict_a)

@assert (3//8)^4 == obs_prob(z1, out, dict_a)
# @assert 3//4096 == obs_prob(z2, out, dict_a) i think his document is wrong here 

jointb = bo * bs # ≈ 0.00313
jointg = go * gs # ≈ 1.29 * 10^-5

μ = (Π, A, B)
HMM = (z1, K, μ...)

function joint_prob(O, X, Π, A, B)

    p = Π[X[1]]
    for (s1, s2, obs) in zip(X[1:end-1], X[2:end], collect(O))
        p *= A[s1, s2] * B[obs][s1]
    end
    p

end

joint_prob(O, z1, Π, A, B)
joint_prob(O, z2, Π, A, B)

yum = rand(2)
A2 = hcat(yum, 1 .- yum)
@assert all(sum.(eachrow(A2)) .== 1)

function forward(A, B, Π::Vector, O::Vector)
    N, T = length.([Π, O])
    α = fill(0//1, (N, T))
    α[:, 1] = Π
    for t in 2:T
        for i in 1:N # to_state
            for j in 1:N # from_state
                α[i, t] += α[j, t-1] * A[j, i] * B[O[t]][j]
                println("α[$i, $t] = $(α[i, t])")
                #println("$(B[O[t]][j]) : $(A[j, i])")
            end
        end
    end
    α
end

function init(;A=A2, v=true)
    v && println("init:\n state 0 probabilities: $Π\n transition matrix: $A")
    words = readlines("data/english1000.txt")
    
