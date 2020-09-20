@show ARGS

if length(ARGS) !== 2
    error("provide two arguments for string edit distance")
end

letters = collect('a':'z')
vowels = ['a', 'e', 'i', 'o', 'u']
consonants = filter!(x-> !in(x, vowels), letters)

s1, s2 = ARGS
l1, l2 = length.([s1, s2]) 

d = fill(0., (l1 + 1, l2 + 1))

d[2:end, 1] = 2 * (1:l1)
d[1, 2:end] = 2 * (1:l2)




function cost(a::Char, b::Char)
    if a == b
        0.
    elseif a ∈ vowels && b ∈ vowels
        0.5
    elseif a ∈ consonants && b ∈ consonants
        0.6
    else 
        3.
    end
end


for i in 2:size(d, 1)
    for j in 2:size(d, 2)

            d[i,j] = min(
                d[i-1, j] + 2.,
                d[i, j-1] + 2.,
                d[i-1, j-1] + cost(s1[i-1], s2[j-1])
            )
        println("d[$i, $j] = $(d[i, j])")
    end 
end
            
#= todo 
* make dfs 
* write to file
=#
