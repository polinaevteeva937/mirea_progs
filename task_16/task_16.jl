using  HorizonSideRobots
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

function Obhod2(r,HS,y)
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
        y+=1
    end
    while !isborder(r,HorizonSide(HS)) && isborder(r,HorizonSide((HS + 1) % 4))
        move!(r,HorizonSide(HS))
        y+= 1
    end
    for i = 1:x
        move!(r,HorizonSide((HS+1) % 4))
    end
    return Flag,y
end

function Obhod3(r,HS,y)
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
        y-=1
    end
    while !isborder(r,HorizonSide(HS)) && isborder(r,HorizonSide((HS + 1) % 4))
        move!(r,HorizonSide(HS))
        y-= 1
    end
    for i = 1:x
        move!(r,HorizonSide((HS+1) % 4))
    end
    return Flag,y
end
function ugl(r)
    Flag = true
    y = 0
    z = 0
    while !isborder(r,Sud) || Flag 
        if !isborder(r,Sud)
            move!(r,Sud)
            y += 1
        end
        if isborder(r,Sud)
            Flag,y =  Obhod2(r,2,y)
        end
    end
    while !isborder(r,West)
        move!(r,West)
        z += 1
    end
    return y,z
end

function markers(r)
    Flag2 = true
    
    while !isborder(r,Nord) || Flag2
        Flag1 = true
        while !isborder(r,Ost) || Flag1
            putmarker!(r)
            if !isborder(r,Ost)
                move!(r,Ost)
            else
                Flag1 = Obhod(r,3)
            end
        end
        Flag1 = true
        while !isborder(r,West) || Flag1
            if !isborder(r,West)
                move!(r,West)
            else
                Flag1 = Obhod(r,1)
            end
        end
        if !isborder(r,Nord)
            move!(r,Nord)
        else
            Flag2 = Obhod(r,0)
        end
    end

end

function Vozvrat(r,y,z)
    Flag = true
    while !isborder(r,Sud)
        move!(r,Sud)
    end
    while !isborder(r,West)
        move!(r,West)
    end
    for i = 1:z
        move!(r,Ost)
    end
    while y > 0
        if !isborder(r,Nord)
            move!(r,Nord)
            y -= 1
        else
            Flag, y = Obhod3(r,0,y)
        end
    end
    
end

function all(r)
    y = 0
    z = 0
    y, z = ugl(r)
    markers(r)
    Vozvrat(r,y,z)
end

all(r)

