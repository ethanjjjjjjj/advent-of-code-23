using StatsBase

function solve()
    file=open("input.txt")
    lines=readlines(file)

    handslist=[]
    for line in lines
        hand,bid=split(line," ")
        cards=split(hand,"")
        push!(handslist,(cards,bid))
    end

    sort!(handslist,lt=handlt,by=(x)->x[1])
    total=0
    for (i,hand) in pairs(handslist)
        total+=i*parse(Int32,hand[2])
    end
    println(total)
end

function handlt(a::Array{SubString{String}},b::Array{SubString{String}})
    atype,btype=handtype.((countmap(a),countmap(b)))
    if atype<btype return true
    elseif btype<atype return false
    else
        for (as,bs) in zip(a,b)
            if cardvalue(only(as))<cardvalue(only(bs)) return true
            elseif cardvalue(only(bs))<cardvalue(only(as)) return false
            end
        end
    end
    return false
end

function cardvalue(card::Char)
    if card=='A' return 14
    elseif card=='K' return 13
    elseif card=='Q' return 12
    elseif card=='J' return 11
    elseif card=='T' return 10
    else return parse(Int32,card)
    end
end

function handtype(hand::Dict{SubString{String}, Int64})::Int32
    if 5 in values(hand) return 7
    elseif 4 in values(hand) return 6
    elseif 3 in values(hand) && 2 in values(hand) return 5
    elseif 3 in values(hand) return 4
    elseif count((x)->x==2,values(hand))==2 return 3
    elseif 2 in values(hand) return 2
    else return 1
    end
end

solve()