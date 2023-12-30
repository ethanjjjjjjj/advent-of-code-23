file=open("testinput.txt")
lines=readlines(file)
time= eachmatch(r"\d+",lines[1]) |> collect |> (x) -> map((y)->y.match,x) |> x -> map((y) -> parse(Int32,y),x)
game=eachmatch(r"\d+",lines[2]) |> collect |> (x) -> map((y)->y.match,x) |> x -> map((y) -> parse(Int32,y),x)
total=1
for i in eachindex(time)
    options=0:time[i]
    distances=options.*reverse(options)
    ways=count((x)->x>game[i],distances)
    global total*=ways
end
println(total)
