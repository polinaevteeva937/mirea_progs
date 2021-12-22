#ДАНО: На ограниченном внешней прямоугольной рамкой поле имеется ровно одна внутренняя перегородка в форме прямоугольника. Робот - в произвольной клетке поля между внешней и внутренней перегородками. 
#РЕЗУЛЬТАТ: Робот - в исходном положении и по всему периметру внутренней перегородки поставлены маркеры.
function mark_whole_border(r)
    x,y = corner_border(r)
    i = find_whole_border(r)
    frame_border(r,i)
    secondcorner(r)
    back_home(r,x,y)
end
function find_whole_border(r)
    c = 1
    cc = 1
    while isborder(r,Ost)==0
        move!(r,Ost)
        c += 1
    end
    move!(r,Nord)
    i=0
    while true
        while isborder(r,West)==0
            move!(r,West)
            cc += 1
        end
        if cc == c
            cc = 1
            move!(r,Nord)
        else
            i=1
            break
        end
        while isborder(r,Ost)==0
            move!(r,Ost)
            cc += 1
        end
        if cc == c
            cc = 1
            move!(r,Nord)
        else
            i = 3
            break
        end
    end
return i
end
function corner_border!(r)
    x=0
    y=0
    while isborder(r,Sud)==0
        move!(r,Sud)
        y+= 1
    end
    while isborder(r,West)==0
        move!(r,West)
        x += 1
    end
    while isborder(r,Sud)==0
        move!(r,Sud)
        y+= 1
    end
    while isborder(r,West)==0
        move!(r,West)
        x += 1
    end
    return x, y
end
function secondcorner(r)
    while isborder(r,Sud)==0
        move!(r,Sud)
    end
    while isborder(r,West)==0
        move!(r,West)
    end
end
function back_home(r,x,y)
    for i in 1:x
        move!(r,Ost)
    end
    for i in 1:y
        move!(r,Nord)
    end
end
function frame_border(r,i)
    putmarker!(r)
    while isborder(r,HorizonSide(i))
        move!(r,HorizonSide(0))
        putmarker!(r)
    end
    move!(r,HorizonSide(i))
    putmarker!(r)
    while isborder(r,HorizonSide(2))
        move!(r,HorizonSide(i))
        putmarker!(r)
    end
    move!(r,HorizonSide(2))
    putmarker!(r)
    i += 2
    while isborder(r,HorizonSide(i % 4))
        move!(r,HorizonSide(2))
        putmarker!(r)
    end
    move!(r,HorizonSide(i % 4))
    putmarker!(r)
    while isborder(r,HorizonSide(0))
        move!(r,HorizonSide(i % 4))
        putmarker!(r)
    end
end
mark_whole_border(r)