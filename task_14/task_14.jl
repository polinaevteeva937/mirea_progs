#ДАНО: Робот находится в произвольной клетке ограниченного прямоугольного поля с внутренними перегородками.
#РЕЗУЛЬТАТ: Робот — в исходном положении в центре прямого креста из маркеров, расставленных вплоть до внешней рамки.
function mark_krest(r)
    for i = 0:3
        mark_line(r,i)
    end
    putmarker!(r)
end
function mark_line(r,HS)
    y = 0
    flag = true
    while !isborder(r,HorizonSide(HS % 4)) || flag
        if isborder(r,HorizonSide(HS % 4))==0
            move!(r,HorizonSide(HS % 4))
            putmarker!(r)
            y += 1
        end
        if isborder(r,HorizonSide(HS))
            flag, y = round(r,HS,y)
            putmarker!(r)
        end
        if flag == false
            break
        end
    end
    return(r,HS,y)
end
function return(r,HS,y)
    x = 0
    flag = true
    while isborder(r,HorizonSide(HS)) && !isborder(r,HorizonSide((HS + 1) % 4))
        move!(r,HorizonSide((HS + 1) % 4))
        x += 1
    end
    if isborder(r,HorizonSide(HS)) && isborder(r,HorizonSide((HS + 1) % 4))==1
        flag = false
    end
    if  isborder(r,HorizonSide(HS))==0  
        move!(r,HorizonSide(HS))
        y += 1
    end
    while !isborder(r,HorizonSide(HS)) && isborder(r,HorizonSide((HS + 3) % 4))
        move!(r,HorizonSide(HS))
        y += 1
    end
    for i = 1:x
        move!(r,HorizonSide((HS+3) % 4))
    end
    return flag,y
end
mark_krest(r)