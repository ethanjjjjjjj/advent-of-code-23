file=open("input.txt")
lines=readlines(file)
println(lines)
time= eachmatch(r"\d+",lines[1]) |> collect |> (x) -> map((y)->y.match,x) |> join |>(y) -> parse(Int64,y)
game=eachmatch(r"\d+",lines[2]) |> collect |> (x) -> map((y)->y.match,x) |> join |>(y) -> parse(Int64,y)
total=1
for i in eachindex(time)
    options=0:time[i]
    distances=options.*reverse(options)
    ways=count((x)->x>game[i],distances)
    global total*=ways
end
println(total)