file=open("input.txt")#
lines=readlines(file)

red=12
green=13
blue=14

total=0

for (i,line) in pairs(lines)
    mr=eachmatch(r"(\d+) red",line)
    mb=eachmatch(r"(\d+) blue",line)
    mg=eachmatch(r"(\d+) green",line)

    redover=false
    blueover=false
    greenover=false
    for m in mr
        if parse(Int32,m[1])>red
            redover=true
            break
        end
    end
    for m in mb
        if parse(Int32,m[1])>blue
            blueover=true
            break
        end
    end
    for m in mg
        if parse(Int32,m[1])>green
            greenover=true
            break
        end
    end
    if !redover && !blueover && !greenover
        global total+=i
    end
end
println(total)