using  HorizonSideRobots

function Obhod2(r,HS)
    a = 0
    b = 0
    x = 0
    Flag = true
    while isborder(r,HorizonSide(HS)) && !isborder(r,HorizonSide((HS + 1) % 4))
        move!(r,HorizonSide((HS + 1) % 4))
        x += 1
        a += 1
    end
    if isborder(r,HorizonSide(HS)) && isborder(r,HorizonSide((HS + 1) % 4))
        Flag = false
    end
    if  !isborder(r,HorizonSide(HS))     
        move!(r,HorizonSide(HS))
    end
    while !isborder(r,HorizonSide(HS)) && isborder(r,HorizonSide((HS + 3) % 4))
        move!(r,HorizonSide(HS))
        b += 1
    end
    for i = 1:x
        move!(r,HorizonSide((HS+3) % 4))
    end
    return Flag, (a)*(b)
end

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

function search(r)
    Flag = true
    summ = 0
    Z = 0
    if !isborder(r,Nord)
        Flag = true
        move!(r,Nord)
        while !isborder(r,Ost) || Flag
            if !isborder(r,Ost)
                move!(r,Ost)
            else
                Flag, Z = Obhod2(r,3)
                if summ < Z
                    summ = Z
                end
            end
        end
    end
    
    Flag = true
    while !isborder(r, West) || Flag
        if !isborder(r, West)
            move!(r, West)
        else
            Flag = Obhod(r,1)
        end
    end
    return summ
end

function all(r)
    summ = 0
    Z = 0
    ugl(r)
    while !isborder(r,Nord)
        Z = search(r)
        if summ < Z
            summ = Z
        end
    end
    return summ
end

all(r)