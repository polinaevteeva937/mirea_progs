using HorizonSideRobots

function ugl(r)
    Flag = true
    y = true
    while !isborder(r,Sud) || Flag 
        if !isborder(r,Sud)
            move!(r,Sud)
        end
        if isborder(r,Sud)
            Flag =  Obhod(r,2)
        end
    end
    while !isborder(r,West)
        move!(r,West)
    end
    if !isborder(r,Nord)
        move!(r,Nord)
    else
        Obhod(r,0)
    end
end


function Obhod(r,HS)
    x = 0
    Flag = true
    while isborder(r,HorizonSide(HS)) && !isborder(r,HorizonSide((HS + 3) % 4))
        move!(r,HorizonSide((HS + 3) % 4))
        x += 1
    end
    if isborder(r,HorizonSide(HS)) && isborder(r,HorizonSide((HS + 3) % 4))
        Flag = false
    end
    if  !isborder(r,HorizonSide(HS))     
        move!(r,HorizonSide(HS))
    end
    while !isborder(r,HorizonSide(HS)) && isborder(r,HorizonSide((HS + 1) % 4))
        move!(r,HorizonSide(HS))
    end
    for i = 1:x
        move!(r,HorizonSide((HS+1) % 4))
    end
    return Flag
end

function count(r)
    count1 = 0
    count2 = 0
    StopCount = true
    while  !isborder(r,Ost) || StopCount
        if isborder(r,Sud)
            count1 += 1
        else
            if count1 != 0
                count2 += 1
            end
            count1 = 0
        end
        if !isborder(r,Ost)
            move!(r,Ost)
        else
            StopCount = false
            if count1 != 0
                count2 += 1
            end
        end
    end
    while !isborder(r,West)
        move!(r,West)
    end
    return(count2)
    
end


function all(r)
    ugl(r)
    Flag2 = true
    Summ = 0
    while !isborder(r,Nord) || Flag2
        Summ += count(r)
        if !isborder(r,Nord)
            move!(r,Nord)
        else
            Flag2 = Obhod(r,0)
        end
    end
    return Summ
end
all(r)