%  Publisher: Kyle Hall 
%  Date: 12/7/201
%  Program Name: HW7
%  Pro1gram Description:
%  Robot finds randomly located sailors and prints their location. If the
% robot runs low of fuel it goes back to base to refuel. 
% The robot scans randomly outward from the center contained by one grid mark at a time. 

function [  ] = HW7( )
    % This is a program to control a robotic ship.
    % 3 sailors are lost at sea, and this program
    % moves the ship around to "find" the 3 sailors
     
    cla reset;  % clear graphics
    clc;  % clear command window
    clear; % clear all variables
    hold;  % This keeps the figure window open 
    axis([0, 40, 0, 40])  %set the plot area
    
    %Declare variables
    radius=2;
    currentx=20;
    currenty=20;
   
    newx=20;
    newy=20;
    currentEnergy=400;
    newEnergy=400;
    
    %Call to random sailor function
    [sailor1x,sailor1y,sailor2x,sailor2y,sailor3x,sailor3y] =randSailor();
   
    %Declare variables
    sailor1x= sailor1x;
    sailor1y=sailor1y;
    sailor2x=sailor2x;
    sailor2y=sailor2y;
    sailor3x=sailor3x;
    sailor3y=sailor3y;
    foundSailorx=0;
    foundSailory=0;
    boolSailor=0;
    numSailorsFound=0;
    
    scatter(currentx,currenty,20,'red','filled');   % plot home base   
    
    %Loop until all sailors are found
    while currentEnergy>-1
       
       
        dir = randi(4) - 1;  %random integer from 0 to 3
        %move function is called
        [radius, newx, newy,newEnergy ]= move(radius,currentx,currenty,dir,currentEnergy);
        %A line is created from the current location to the new one.
        color = 'green'; 
        line([currentx,newx],[currenty,newy],'Color',color);
        pause(.001)% pause to allow graphic
        %The new location and energy become the current ones.
        currentx =newx;
        currenty =newy;
        currentEnergy = newEnergy;
        %Fuction call to compareLocaion
        [foundSailorx,foundSailory,boolSailor,sailor1x,sailor1y,sailor2x,sailor2y,sailor3x,sailor3y]=compareLocation(currentx,currenty,sailor1x,sailor1y,sailor2x,sailor2y,sailor3x,sailor3y)
        %If statement to test if a new sailor was found 
        if boolSailor==1
            numSailorsFound =numSailorsFound+1;
        end
        
        %Reset the switch 
        boolSailor=0;
        
        % Prints the current location and the remaining fuel.
        msg = sprintf('Current x = %f Current y=%d Energy left=%d',currentx,currenty,currentEnergy);
        display(msg);
        
        currentEnergy = currentEnergy-1;
        %Ends Program when it finds the Last sailor, and prints their
        %locations.
        if numSailorsFound ==3
            msg = sprintf('Number of Sailors Found =%d',numSailorsFound);
            display(msg);
            msg = sprintf('The robot found all the Sailors!');
            display(msg);
            break;
        end
        
    end
   
  
end
function [radius, newx, newy,newEnergy ] = move(radius, currentx, currenty, dir,currentEnergy )
    %Take the radius allowed, currentX, currentY, direction, and current energy as input.
    %Assign a value to newx and newy based on DIRECTION as well as increment
    %radius and decrement Energy.

    %Declare variables
    newx = currentx;
    newy = currenty;
    newEnergy = currentEnergy;

    %Test if the robot has enough energy
    if currentEnergy>40
        %If the robot has enough energy test if the wanted position is within the
        %radius if it moves in the desired direction.
        if dir == 0% && (newy<20+radius)
            newy = newy+1;
        else if dir == 1  %&& (newx>20-radius)
            newx = newx-1; 
        else if dir == 2 % && (newy>20-radius)
            newy = newy-1;      
        else if dir ==3 %&& (newx<20+radius)
            newx = newx+1;
        %If it would go out of radius add one Energy to counter act the
        %Energy drop in the main.
        else
            currentEnergy= currentEnergy+1;
        end
        end
        end
        end
        %If the robot is at the bounds of the map it gets moved back in place
        %and gets an extra Energy unit to counteract teh Energy drop in main.
        if newx ==-1
            currentEnergy= currentEnergy+1;
        newx=0;
        else if newx ==41
            currentEnergy= currentEnergy+1;
            newx =40;
        else if newy ==-1
            currentEnergy= currentEnergy+1;
            newy=0;
        else if newy ==41
            newy =40;
            currentEnergy= currentEnergy+1;
        end
        end
        end    
        end
        %If the robot is low on Energy then these statement return it back to
        %base.
        else if newx>20
            newx = newx-1;
        else if newx<20 
            newx = newx+1;
        else if newy>20
            newy = newy-1;
        else if newy<20
            newy = newy+1;
        %Resets Energy to full and increases search area radius.
        else if newx==20 && newy==20
            newEnergy =400;
            radius = radius+.5;
        end
        end
        end
        end
    end
    end
end

function [sailor1x,sailor1y,sailor2x,sailor2y,sailor3x,sailor3y]= randSailor()
%This function has no inputs and returns the random location of three x
%cordinates and 3 y cordinates. These random cordinates are sailor1x,
%sailor1y,sailor2x,sailor2y,sailor3x,and sailor3y.

    %A random x and y cordinate are created and ploted as well as set to the
    %value for the sailor.
    randomx = randi(41) - 1;
    randomy = randi(41) - 1;
    scatter(randomx,randomy,20,'green','filled');
    sailor1x=randomx;
    sailor1y =randomy;
    %A random x and y cordinate are created and ploted as well as set to the
    %value for the sailor.
    randomx = randi(41) - 1;
    randomy = randi(41) - 1;
    scatter(randomx,randomy,20,'green','filled');
    sailor2x=randomx;
    sailor2y =randomy;
    %A random x and y cordinate are created and ploted as well as set to the
    %value for the sailor.
    randomx = randi(41) - 1;
    randomy = randi(41) - 1;
    scatter(randomx,randomy,20,'green','filled');
    sailor3x=randomx;
    sailor3y =randomy;
end
function [foundSailorx,foundSailory,boolSailor,sailor1x,sailor1y,sailor2x,sailor2y,sailor3x,sailor3y]=compareLocation(currentx,currenty,sailor1x,sailor1y,sailor2x,sailor2y,sailor3x,sailor3y)
%This function inputs the currentx,currenty,as well as, the cordinates for 
%sailor1x,sailor1y,sailor2x,sailor2y,sailor3x, and sailor3y. It then compares
%these cordiantes to see if there are any matches. Finally it returns 
%the foundSailorx and foundSailory to the rest of the program.
%The values for the sailor are returned so that the values can be printed in the main
%(sailor1x,sailor1y,sailor2x,sailor2y,sailor3x,and sailor3y),as well as
%boolSailor which is a boolean letting the program know if there
%was a found sailor.

    %Declare varibles
    foundSailorx=0;
    foundSailory=0;
    boolSailor=0;

    %Test if the sailor is at the same location as the current x and y. If it
    %is, the foundSailor x and y are set to it and the sailors position to set
    %to out of bounds.
    if currentx==sailor1x && currenty==sailor1y
        boolSailor=1;
        foundSailorx = currentx;
        foundSailory = currenty;
        msg = sprintf('Sailor 1 found at (%d,%d)',sailor1x,sailor1y);
        display(msg);
        sailor1x=-1;
        sailor1y=-1;
    %Test if the sailor is at the same location as the current x and y. If it
    %is, the foundSailor x and y are set to it and the sailors position to set
    %to out of bounds.  
    else if currentx==sailor2x && currenty==sailor2y
        boolSailor=1;
        foundSailorx = currentx;
        foundSailory = currenty;
        msg = sprintf('Sailor 2 found at (%d,%d)',sailor2x,sailor2y);
        display(msg);
        sailor2x=-1;
        sailor2y=-1;
    %Test if the sailor is at the same location as the current x and y. If it
    %is, the foundSailor x and y are set to it and the sailors position to set
    %to out of bounds.
    else if currentx==sailor3x && currenty==sailor3y
        boolSailor=1;
        foundSailorx = currentx;
        foundSailory = currenty;
        msg = sprintf('Sailor 3 found at (%d,%d)',sailor3x,sailor3y);
        display(msg);
        sailor3x=-1;
        sailor3y=-1;   
    end
    end
    end
end
