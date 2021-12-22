#ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля.
#РЕЗУЛЬТАТ: Робот - в исходном положении, и все клетки поля промакированы.
function mark_all(r)
    x,y = num_sudwest!(r)
    mark_all!(r)
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
function mark_all!(r)
    while ismarker(r)==0
        for side in [Nord,Sud]
            while isborder(r,side)==0
                putmarker!(r)        
                move!(r,side)
            end
            if isborder(r,Ost)==0
                putmarker!(r)
                move!(r,Ost)
            else
                break
            end  
        end
    end
    while isborder(r,Sud)==0
        move!(r,Sud)
    end
    while isborder(r,West)==0
        move!(r,West)
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
mark_all(r)