function solve(lines)

    


    seednums=  IOBuffer(lines) |> readline |> split |> x-> parse.(Int64,x[2:end])
    sections=lines |> x -> split(x,"\n\n") .|> section-> split(section,"\n") |> section -> section[2:end] .|> split .|> nums -> parse.(Int64,nums)

    inrange(seed,source,length) =  (seed >=source) && (seed<(source+length))
    convert(seed,source,destination) = seed+destination-source

    for section in sections
        sectionmapping::Vector{Int64}=[]
        converted::Vector{Int64}=[]
        for mapping in section
            destination,source,length=mapping
            for seed in seednums
                if inrange(seed,source,length) && !in(converted,seed)
                    append!(sectionmapping,convert(seed,source,destination))
                    append!(converted,seed)
                end
            end
        end
        append!(sectionmapping,setdiff(seednums,converted))
        seednums=sectionmapping
        sectionmapping=[]
    end
    return minimum(seednums)
end

file=open("testinput.txt")
lines=read(file,String)

solve(lines)