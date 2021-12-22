#ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля/
#РЕЗУЛЬТАТ: Робот - в исходном положении, и клетки поля промакированы так: 
#нижний ряд - полностью, следующий - весь, за исключением одной последней клетки на Востоке и т.д.
function mark_diag(r)
    x,y = num_sudost!(r)
    mark_diag!(r)
    return_sudost!(r,x,y)
end
function num_sudost!(r)
    x=0
    y=0
    while isborder(r,Sud)==0
        move!(r,Sud)
        x+=1
    end
    while isborder(r,Ost)==0
        move!(r,Ost)
        y+=1
    end
    return x,y
end
function mark_diag!(r)
    while isborder(r,Nord)==0
        putmarker!(r)
        move!(r,Nord)
        move!(r,West)
    end      
    while ismarker(r)==0
        for side in [West,Ost]
            while isborder(r,side)==0 && ismarker(r)==0
                putmarker!(r)
                move!(r,side)
            end    
            putmarker!(r)
            if isborder(r,Sud)==0
                move!(r,Sud)
            end     
        end
    end
    while isborder(r,Ost)==0
        move!(r,Ost)
    end
end     
function return_sudost!(r,x,y)
    for i in 1:x
        move!(r,Nord)
    end
    for i in 1:y
        move!(r,West)
    end
end
mark_diag(r)