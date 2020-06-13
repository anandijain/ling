using BenchmarkTools

include("./contexts_to_categories.jl")
using .Hw2

@show @benchmark assignment()

