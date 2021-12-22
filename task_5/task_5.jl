function mark_corner_frame_with_borders(r)
    home=[]
    home = move_to_corner!(r)
    mark_corner_frame(r)
    move_to_home!(r,home)
    end
function move_to_border!(r,side)
    count=0
    while isborder(r,side)==0
        move!(r,side)
        count +=1    
    end
    return count
end
function move_to_corner!(r)
home=[]
    while isborder(r,Nord)==0 || isborder(r,West)==0
        x = move_to_border!(r,Nord)
        y = move_to_border!(r,West)
        push!(home,x)
        push!(home,y)
    end
    return home
end
function countmove!(r,side,count)
    for i in 1:count
        move!(r,side)
    end
end
function mark_corner_frame(r)
    putmarker!(r)
    for side in [Sud,Ost,Nord,West]
        while isborder(r,side)==0
            move!(r,side)
        end
        putmarker!(r)
    end
end
function move_to_home!(r,home)
    reverse!(home)
    for i = 1:length(home)
        if i%2==0
            countmove!(r,Sud,home[i])
        else
            countmove!(r,Ost,home[i]) 
        end 
    end
end
mark_corner_frame_with_borders(r)