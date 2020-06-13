module Hw2
using CSV, DataFrames, DelimitedFiles

# PUNCTUATION
to_sep = Vector{Char}([',', ':', '!', ';', '(', ')', '?', '.', '"'])
split_set = Dict(zip(to_sep, map(x -> " $(x) ", to_sep)))

get_lines()::Array{String,1} =
    map(x -> sep(lowercase(x), split_set), readlines("browncorpus.txt"))
contexts(w) = [w[i:(i + 2)] for i = 1:(length(w) - 3)]

function sep(s, pairs)
    for p in pairs
        s = replace(s, p)
    end
    s = replace(s, "  " => " ")
    s
end

get_context_arr() = vcat(contexts.(split.(get_lines(), " "))...)

function get_contexts(; ctxs = get_context_arr())::Dict{String,Dict{String,Int}}
    d = Dict()
    for elt in ctxs
        cx = join([elt[1], elt[end]], " ")
        # @show cx
        v = string(elt[2])
        if haskey(d, cx)
            if haskey(d[cx], v)
                d[cx][v] += 1
            else
                d[cx][v] = 1
            end
        else
            d[cx] = Dict(v => 1)
        end
    end
    d
end


dust(d::Dict{String,Dict{String,Int}}, ; n = 50) = filter(x -> sum(values(last(x))) > n, d)

# write this out 
context_list(ctxs)::AbstractDataFrame = sort(
    DataFrame(:cx => collect(keys(ctxs)), :wc => length.(values(ctxs))),
    :wc,
    rev = true,
)

contexts_to_dfs(ctxs)::Dict{String, DataFrame} = Dict(zip(collect(keys(ctxs)), map(
    x -> sort(DataFrame(:w => collect(keys(x)), :n => collect(values(x))), :n, rev = true),
	values(ctxs)))
)

function words_in_contexts(df_dict::Dict{String,DataFrame}; n = 5)
    rs = []
    for (ctx, df) in df_dict
        if nrow(df) < n
            r = vcat(ctx, collect.(zip(df.w[1:end], df.n[1:end]))...)
			r = vcat(r, fill(0, 2n + 1 - length(r)))
            push!(rs, r)
        else
            r = vcat(ctx, collect.(zip(df.w[1:5], df.n[1:5]))...)
            push!(rs, r)
        end
    end
	ns = vcat("context", collect(Iterators.flatten(zip("word_" .* string.(1:5), "n_" .* string.(1:5)))))
	clean_sort_wics(DataFrame(permutedims(hcat(rs...)), Symbol.(ns)))
	# write this out
end

function clean_sort_wics(df) 
	df[:, r"n_\d"] = Int.(df[:, r"n_\d"])
	df.sum = sum.(eachrow(df[:, r"n_\d"]))
	sort(df, :sum, rev=true)
end

function assignment()
	cs = dust(get_contexts())
	cl = context_list(cs)
	wics = words_in_contexts(contexts_to_dfs(cs))
	cl, wics
end

export get_lines, get_contexts, context_list, dust, contexts_to_dfs, words_in_contexts

end
