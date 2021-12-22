#ДАНО: Робот - рядом с горизонтальной перегородкой (под ней), бесконечно продолжающейся в обе стороны, в которой имеется проход шириной в одну клетку.
#РЕЗУЛЬТАТ: Робот - в клетке под проходом.
function find_gap(r)
    i = 1
    j = 3
    while isborder(r,Nord)==1
        for n in 1:i
            move!(r,HorizonSide(j % 4))
            if isborder(r,Nord)==0
                break
            end
        end
        j += 2
        i += 4
    end  
end
find_gap(r)