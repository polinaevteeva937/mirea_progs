#ДАНО: Робот находится в произвольной клетке ограниченного прямоугольного поля без внутренних перегородок и маркеров.
#РЕЗУЛЬТАТ: Робот — в исходном положении в центре прямого креста из маркеров, расставленных вплоть до внешней рамки.
#Рассмотреть отдельно еще случай, когда изначально в некоторых клетках поля могут находиться маркеры.
function krest!(r)
    for side in [Nord,West,Sud,Ost]
        if ismarker(r)==0
            putmarkers!(r,side)
        else
            move!(r,side)
        end
        reverskrest!(r,side)
    end
    putmarker!(r)
end
function putmarkers!(r,side)
    while isborder(r,side)==0 
        move!(r,side)
        putmarker!(r)
    end
end
function reverskrest!(r,side)
    while ismarker(r)==1
        move!(r,HorizonSide((Int(side)+2)%4))
    end
end
krest!(r)