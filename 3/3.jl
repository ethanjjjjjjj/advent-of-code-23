
using BenchmarkTools
file=open("input.txt")
lines=readlines(file)
function solve(lines)
    
    total=0
    for (i,line) in pairs(lines)
        m=eachmatch(r"(\d+)",line)
        for match1 in m
            matchlength=length(match1[1])
            #display(lines[max(i-1,1):min(i+1,end)][match.offset:min(end,match.offset+length(match[1]))])
            stringview=SubString.(lines[max(i-1,begin):min(i+1,end)],max(match1.offset-1,1),min(match1.offset+matchlength,length(lines[1])))
            

            matches=match.(r"[^.^\d]",stringview)

            if any(map((x)->x!==nothing,matches))
                total+=parse(Int32,match1[1])
            end

                
        end
    end
end
@benchmark solve($lines)