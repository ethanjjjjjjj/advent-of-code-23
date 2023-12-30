file=open("input.txt")
lines=readlines(file)

function getdigits(line::String)
    first::Bool=true
    firstchar::Char='.'
    lastchar::Char='.'
    for char in line
        if char <= '9' && char >='0'
            if first
                firstchar=char
                first=false
            end
            lastchar=char
        end
    
    end
    return firstchar*lastchar
end

sum=0
for line in lines
    num=parse(Int32,getdigits(line))
    global sum+=num
end
println(sum)