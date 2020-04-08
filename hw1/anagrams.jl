module Anagrams
using DataFrames

f = unique(map(lowercase, readlines("english-words-235k.txt")))
α(f) = map(join ∘ sort ∘ collect, f)
# ag_lens = map(x -> length(x), f2)

df = DataFrame(w=f, alpha=α(f), len=length.(f))
uq = unique(df.alpha)

gdf = groupby(df, :alpha)

end

