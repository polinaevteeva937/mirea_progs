#ДАНО: Где-то на неограниченном со всех сторон поле и без внутренних перегородок имеется единственный маркер. Робот - в произвольной клетке поля.
#РЕЗУЛЬТАТ: Робот - в клетке с тем маркером.
function find_marker(r)
    steps_max=1
    side=Nord
    while ismarker(r)==0
        for _ in 1:2
            find_marker!(r,side,steps_max)
            side=next(side)
        end
        steps_max+=1
    end
end
function find_marker!(r,side,steps_max)
    for _ in 1:steps_max
        if ismarker(r)
            return nothing
        end
        move!(r,side)
    end
end
next(side)=HorizonSide(mod(Int(side)+1,4))
find_marker(r)
