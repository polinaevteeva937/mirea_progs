using  HorizonSideRobots
function line(r)
    putmarker!(r)
    y = 0
    
    while !isborder(r,Ost)
       move!(r,Ost)
       putmarker!(r)
       y += 1
    end
    
    while !isborder(r,West)
        move!(r,West)
    end
    move!(r,Nord)
    
    return y-1
end

function line2(r,y)
    Flag = true
    putmarker!(r)
    
    while y > 0
        if !isborder(r,Ost)
            move!(r,Ost)
            putmarker!(r)
            y -= 1
        else
            Flag, y = Obhod3(r,3,y)
            if y >= 0
                putmarker!(r)
            end
        end
    end

    while !isborder(r,West) || Flag
        if !isborder(r,West)
            move!(r,West)
        else
            Flag =Obhod(r,1)
        end
    end
end

function prohod(r,y)
    while !isborder(r,Nord)
        line2(r,y)
        y -= 1
        move!(r,Nord)
    end
    
    line2(r,y)
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

function Vozvrat(r,y,z)
    Flag = true

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
function all(r)
    y = 0
    z = 0
    x = 0
    y, z = ugl(r)
    x = line(r)
    prohod(r,x)

    while !isborder(r,Sud)
        move!(r,Sud)
    end

    Vozvrat(r,y,z)
end
all(r)