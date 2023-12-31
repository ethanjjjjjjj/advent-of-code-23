using BenchmarkTools
lines=open("input.txt") |> readlines

predict(seq::Vector{Int32})::Int32 = iszero(seq) ? 0 : last(seq)+predict(diff(seq))
solve(lines::Vector{String})::Int32 = (lines .|> split .|> x->parse.(Int32,x) |> predict) |> sum

@btime solve($lines)