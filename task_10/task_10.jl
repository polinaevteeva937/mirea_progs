#ДАНО: Робот - в юго-западном углу поля, на котором расставлено некоторое количество маркеров.
#РЕЗУЛЬТАТ: Функция вернула значение средней температуры всех замаркированных клеток.
tempsum = 0
numofcells = 0
function count_avg_temp(r)
    dir = Ost
    move_while_can!(r,dir)
    dir = inverse(dir)
    while isborder(r,Nord)==0
        move!(r,Nord)
        move_while_can!(r,dir)
        dir = inverse(dir)
    end
    if numofcells > 0 
        return tempsum/numofcells
    else
        return 0
    end   
end
function move_while_can!(r,side)
    checkcell(r)
    while isborder(r,side)==0
        move!(r,side)
        checkcell(r) 
    end
end
function checkcell(r::Robot)
   global tempsum, numofcells
   if ismarker(r)==1
        tempsum += temperature(r) 
        numofcells += 1
   end
end
function inverse(side)
    return HorizonSide(mod(Int(side) + 2, 4))
end
count_avg_temp(r)

