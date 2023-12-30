using IterTools
convert(seed::Int64,source::Int64,destination)::Int64 = seed+destination-source
inrange(seed::Int64,source::Int64,length)::Bool =  (seed >=source) && (seed<(source+length))

function mapforward(sections::Vector{Vector{Vector{Int64}}},value::Int64,sectionnum::Int64=1)
    for section in sections[sectionnum:end]
        for mapping in section
            source, destination, length=mapping
            if inrange(value,destination,length) value=convert(value,destination,source); break end
        end
    end
    return value
end

function mapbackward(sections::Vector{Vector{Vector{Int64}}},value::Int64,sectionnum::Int64=1)
    for section in Iterators.reverse(sections[begin:sectionnum])
        for mapping in section
            source, destination, length=mapping
            if inrange(value,source,length) value=convert(value,source,destination); break end
        end
    end
    return value
end

function rangeoverlaps(sections::Vector{Vector{Vector{Int64}}},seedranges::Vector{UnitRange{Int64}}) 
    getsectionlist(section, sections, i)::Vector{Int64} = section .|> x -> begin destination=x[1] ; mapbackward(sections,destination, i) end
    beginnings::Vector{Int64} = begin pairs(sections) |> collect .|> x -> getsectionlist(x[2], sections, x[1]) end |> A -> reduce(vcat, A) 
    return (beginnings |> beginnings-> filter(beginning -> any(in.(beginning,seedranges)),beginnings) .|> seed -> mapforward(sections,seed)) |> minimum
end

file=open("input.txt")
lines=read(file,String)

gensections(lines::String) = begin lines |> x -> split(x,"\n\n") .|> section-> split(section,"\n") |> section -> section[2:end] .|> split .|> nums -> parse.(Int64,nums) end |> x->x[2:end]
genseedranges(lines::String) = IOBuffer(lines) |> readline |> split |> x-> parse.(Int64,x[2:end]) |> x-> partition(x,2,2) |> collect .|> x -> x[1]:x[1]+x[2]-1 

sections=gensections(lines)
seedranges=genseedranges(lines)

@time rangeoverlaps(sections,seedranges)