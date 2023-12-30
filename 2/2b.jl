file=open("input.txt")#
lines=readlines(file)



total=0

for (i,line) in pairs(lines)
    mr=eachmatch(r"(\d+) red",line)
    mb=eachmatch(r"(\d+) blue",line)
    mg=eachmatch(r"(\d+) green",line)

    red=0
    green=0
    blue=0

    for m in mr
        if parse(Int32,m[1])>red
            red=parse(Int32,m[1])
        end
    end
    for m in mb
        if parse(Int32,m[1])>blue
            blue=parse(Int32,m[1])
        end
    end
    for m in mg
        if parse(Int32,m[1])>green
            green=parse(Int32,m[1])
        end
    end
    global total+=red*blue*green
end
println(total)