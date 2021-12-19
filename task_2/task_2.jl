#ДАНО: Робот - в произвольной клетке поля (без внутренних перегородок и маркеров).
#РЕЗУЛЬТАТ: Робот - в исходном положении, и все клетки по периметру внешней рамки промакированы.
function mark_frame_perimetr!(r)
    x,y = num_sudwest!(r)
    markframe!(r)
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
function markframe!(r)
    for side in [Nord,Ost,Sud,West]
        while isborder(r,side)==0
            putmarker!(r)  
            move!(r,side) 
        end 
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
mark_frame_perimetr!(r)