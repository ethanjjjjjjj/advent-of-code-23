using BenchmarkTools

struct Repeater{T}
    data::Vector{T}
end

@inline Base.getindex(A::Repeater,index::Int)  = @inbounds getindex(A.data,mod1(index,length(A.data)))
@inline Base.getindex(A::Repeater, I::Vector{Int}) = @inbounds I .|> index -> getindex(A,index)
@inline Base.getindex(A::Repeater, I::UnitRange{Int}) = @inbounds I |> collect .|> index -> getindex(A,index)


file=open("input.txt")
lines=readlines(file)

@inline step(starts, mapping, instruction) = begin 
    for i in eachindex(starts)
        @inbounds starts[i]=mapping[starts[i]][instruction]
    end
end

@inline stepone(start,mapping,instruction) = mapping[start][instruction]

function solveall(starts::Array{String},mapping::Dict{String,Tuple{String,String}},instructions::Repeater{SubString{String}})
    index=1
    while !(map(x->x[3]=='Z',starts) |> all)
        instruction=(instructions[index] == "L") ? 1 : 2
        step(starts,mapping,instruction)
        index+=1
    end
    return index-1
end

function solveone(start,mapping,instructions)
    index=1
    while start[3] != 'Z'
        instruction=(instructions[index] == "L") ? 1 : 2 # (instructions[index] == "L") + 1
        start=stepone(start,mapping,instruction)
        index+=1
    end
    return index-1
end

    

function solve(lines::Vector{String})
    line = split(lines[1],"")
    instructions=Repeater(line)
    rest=lines[3:end]
    mapping=Dict{String,Tuple{String,String}}()
    for line in rest
        @inbounds a,b,c=line[1:3],line[8:10],line[13:15]
        mapping[a]=(b,c)
    end

    filterkeys=keys->filter(key->key[3]=='A',keys)
    starts = mapping |> keys |> filterkeys
    
    solveeach(start)=solveone(start,mapping,instructions)
    out=solveeach.(starts)
    out=reduce(lcm,out)
    return out
end


@show solve($lines) 
