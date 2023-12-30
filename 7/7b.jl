using StatsBase

function solve()
    file=open("input.txt")
    lines=readlines(file)

    handslist=[]
    for line in lines
        hand,bid=split(line," ")
        cards=split(hand,"")
        push!(handslist,(cards,parse(Int32,bid)))
    end
    sort!(handslist,lt=handlt,by=(x)->x[1])
    total=getfield.(handslist,2) |> pairs |> x->keys(x).*values(x)  |> sum

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
    elseif card=='T' return 10
    elseif card=='J' return 1
    else return parse(Int32,card)
    end
end

function handtype(hand::Dict{SubString{String}, Int64})::Int32

    vals=values(hand)
    if "J" in keys(hand)
        if hand["J"]==5 return 7 end
        jval=hand["J"]
        delete!(hand,"J")
        maxvalue=vals |> maximum
        maxkey=[k for (k,v) in hand if (v==maxvalue)] |> first
        hand[maxkey]+=jval
    end

    if 5 in vals return 7
    elseif 4 in vals return 6
    elseif 3 in vals && 2 in vals return 5
    elseif 3 in vals return 4
    elseif count((x)->x==2,vals)==2 return 3
    elseif 2 in vals return 2
    else return 1
    end
end

solve()