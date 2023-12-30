using BenchmarkTools

struct Repeater{T}
    data::Vector{T}
end

@inline Base.getindex(A::Repeater,index::Int)  = @inbounds getindex(A.data,mod1(index,length(A.data)))

file=open("input.txt")
lines=readlines(file)

function solve(lines::Vector{String})

    line = split(lines[1],"")
    instructions=Repeater(line)
    rest=lines[3:end]
    mapping=Dict{String,Tuple{String,String}}()
    
    @inbounds for line in rest
        a,b,c=line[1:3],line[8:10],line[13:15]
        mapping[a]=(b,c)
    end

    index=1
    current="AAA"
    @inbounds while current != "ZZZ"
        direction=(instructions[index] == "L") ? 1 : 2
        current=mapping[current][direction]
        index+=1
    end
    return index-1
end

@show solve(lines)
