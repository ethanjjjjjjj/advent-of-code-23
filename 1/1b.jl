file=open("input.txt")
lines=readlines(file)

function getdigits(line::String)
    regex=r"(one|two|three|four|five|six|seven|eight|nine|[1-9])"
    m=collect(eachmatch(regex,line,overlap=true))
    firstmatch=first(m)
    lastmatch=last(m)
    return firstmatch.match,lastmatch.match
end

function decodeword(word)::Char
    if word == "one"
        return '1'
    end
    if word == "two"
        return '2'
    end
    if word == "three"
        return '3'
    end
    if word == "four"
      return '4'
    end
    if word =="five"
        return '5'
    end
    if word=="six"
        return '6'
    end
    if word=="seven"
        return '7'
    end
    if word == "eight"
        return '8'
    end
    if word=="nine"
        return '9'
    end
    return word[1]
end

sum=0

for line in lines
    a,b=getdigits(line)
    println(line)
    println(a,b)
    num=decodeword(a)*decodeword(b)
    println(num)
    global sum+=parse(Int32,num)
    println("")
end
println(sum)