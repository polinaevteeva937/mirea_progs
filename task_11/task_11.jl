#ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля, на котором могут находиться также внутренние прямоугольные перегородки (все перегородки изолированы друг от друга, прямоугольники могут вырождаться в отрезки)
#РЕЗУЛЬТАТ: Робот - в исходном положении, и в 4-х приграничных клетках, две из которых имеют ту же широту, а две - ту же долготу, что и Робот, стоят маркеры.
function mark_angles(r)
    for i = 0:3
        moves(r,i)
    end  
end
function moves(r,HS)
    y = 0
    flag = true
    while isborder(r,HorizonSide(HS)) || flag==0
        if isborder(r,HorizonSide(HS))==0
            move!(r,HorizonSide(HS))
            y += 1
        end
        if isborder(r,HorizonSide(HS))
            flag, y = round(r,HS,y)
        end
        if flag == false
            break
        end
    end
    putmarker!(r)
    return(r,HS,y)
end
function round(r,HS,y)
    x = 0
    flag = true
    while isborder(r,HorizonSide(HS)) && !isborder(r,HorizonSide((HS + 1) % 4))==1
        move!(r,HorizonSide((HS + 1) % 4))
        x += 1
    end
    if isborder(r,HorizonSide(HS)) && isborder(r,HorizonSide((HS + 1) % 4))
        flag = false
    end
    if  isborder(r,HorizonSide(HS))==0     
        move!(r,HorizonSide(HS))
        y += 1
    end
    while isborder(r,HorizonSide(HS)) && isborder(r,HorizonSide((HS + 3) % 4))==0
        move!(r,HorizonSide(HS))
        y += 1
    end
    for i = 1:x
        move!(r,HorizonSide((HS+3) % 4))
    end
    return flag,y
end
function return(r,HS,y)
    while y > 0
        if isborder(r,HorizonSide((HS + 2) % 4))==0
            move!(r,HorizonSide(((HS + 2) % 4)))
        else
            x = 0
            while isborder(r,HorizonSide((HS + 2) % 4)) && !isborder(r,HorizonSide((HS + 1) % 4))==1
                move!(r,HorizonSide((HS + 1) % 4))
                x += 1
            end    
            move!(r,HorizonSide((HS + 2) % 4))
            while isborder(r,HorizonSide((HS + 3) % 4))==1
                move!(r,HorizonSide((HS + 2) % 4))
                y -= 1
            end
            for i = 1:x
                move!(r,HorizonSide((HS + 3) % 4))
            end
        end
        y -= 1
    end
end
function all(r)
    for i = 0:3
        moves(r,i)
    end  
end
mark_angles(r)