using  HorizonSideRobots

function Obhod(r,HS)
    x = 0
    Flag = true
    while isborder(r,HorizonSide(HS)) && !isborder(r,HorizonSide((HS + 1) % 4))
        move!(r,HorizonSide((HS + 1) % 4))
        x += 1
    end
    if isborder(r,HorizonSide(HS)) && isborder(r,HorizonSide((HS + 1) % 4))
        Flag = false
    end
    if  !isborder(r,HorizonSide(HS))     
        move!(r,HorizonSide(HS))
    end
    while !isborder(r,HorizonSide(HS)) && isborder(r,HorizonSide((HS + 3) % 4))
        move!(r,HorizonSide(HS))
    end
    for i = 1:x
        move!(r,HorizonSide((HS+3) % 4))
    end
    return Flag
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

function Vozvrat(r,y,z)
    Flag = true
    for i = 1:z
        move!(r,West)
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
    while !isborder(r,Ost)
        move!(r,Ost)
        z += 1
    end
    return y,z
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

function markers(r)
    y = 0
    z = 0
    y, z = ugl(r)
    putmarker!(r)
    for HS = 0:3
        while !isborder(r,HorizonSide(HS))
        move!(r,HorizonSide(HS))
        putmarker!(r)
        end
    end
    Vozvrat(r,y,z)
end

markers(r)