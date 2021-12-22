#ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля (без внутренних перегородок).
#РЕЗУЛЬТАТ: Робот - в исходном положении, в клетке с роботом стоит маркер, и все остальные клетки поля промаркированы в шахматном порядке.
parity = true
function mark_chess(r)
    x,y = num_sudwest!(r)
    paintcell!(r)
    dir = Ost
    move_while_can(r,dir,paintcell!)
    dir = inverse(dir)
    while isborder(r,Nord)==0
        move!(r,Nord)
        paintcell!(r)
        move_while_can(r,dir,paintcell!)
        dir = inverse(dir)
    end    
    while isborder(r,West)==0
        move!(r,West)
    end
    while isborder(r,Sud)==0
        move!(r,Sud)
    end    
    corner_sudwest!(r)
    return_sudwest!(r,x,y)
end
function num_sudwest!(r)
    x=0
    y=0
    while isborder(r,Sud)==0
        move!(r,Sud)
        x+=1
    end
    while isborder(r,West)==0
        move!(r,West)
        y+=1
    end
    return x,y
end
function f(r)
    global parity
    parity = !parity
end
function paintcell!(r)
    global parity 
    parity = !parity
    if parity==1
        putmarker!(r)
    end    
end
function move_while_can(r,side,callback)
    while isborder(r,side)==0
        move!(r,side)
        callback(r)
    end
end
function inverse(side)
    return HorizonSide(mod(Int(side) + 2, 4))
end
function corner_sudwest!(r)
    while isborder(r,West)==0
        move!(r,West)
    end
    while isborder(r,Sud)==0
        move!(r,Sud)
    end
end  
function return_sudwest!(r,x,y)
    for i in 1:x
        move!(r,Nord)
    end
    for i in 1:y
        move!(r,Ost)
    end
end
mark_chess(r)