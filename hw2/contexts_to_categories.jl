module Hw2
using CSV, DataFrames, DelimitedFiles

# PUNCTUATION
to_sep = Vector{Char}([',', ':', '!', ';', '(',')', '?', '.', '"'])
split_set = Dict(zip(to_sep, map(x-> " $(x) ", to_sep)))

get_lines()::Array{String, 1} = map(x->sep(lowercase(x), split_set), readlines("browncorpus.txt"))
contexts(w) = [w[i:i+2] for i in 1:length(w)-3]

function sep(s, pairs)
       for p in pairs
       s = replace(s, p)
	end
       s = replace(s, "  "=>" ")
       s
end

get_context_arr() = vcat(contexts.(split.(get_lines(), " "))...)

function get_contexts(;ctxs=get_context_arr())
	d = Dict()
    for elt in ctxs
       cx = (elt[1], elt[end])
	   if haskey(d, cx)
		   if haskey(d[cx], elt[2])
           		d[cx][elt[2]] += 1
			else
				d[cx][elt[2]] = 1
			end
       else
           d[cx] = Dict(elt[2]=>1)
       end
    end
       d
end


dust(d::Dict; n=50) = filter(x -> sum(values(last(x))) > n, d)

function get_outputs(;write=false)
	cs = dust(get_contexts())
	context_list = sort(DataFrame(:cx=>join.(keys(cs), " "), :wc=>length.(values(cs))), :wc, rev=true)
	= map(x->DataFrame(:w=>collect(keys(x)), :n=>collect(values(x))), values(cs))
	if write
		CSV.write("context_list.txt", context_list) 
	end
end

function fuckit(dfs)
	for df in dfs
		if nrow(df) < 5
			r = vcat(collect.(zip(df.w[1:end], df.n[1:end]))...)
			r = vcat(r, fill(missing, 10-length(r)))
		else 
			r = vcat(collect.(zip(df.w[1:5], df.n[1:5]))...)


export get_lines, get_contexts, get_outputs, dust
	
end

