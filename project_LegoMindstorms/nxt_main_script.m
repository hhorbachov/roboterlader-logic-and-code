% nxt_main.m
% LEGO NXT obstacle-avoiding robot using RWTH Toolbox

COM_CloseNXT all;
h = COM_OpenNXT();
COM_SetDefaultNXT(h);

% Настройка моторов
motorGrip = NXTMotor('A');
motorLeft = NXTMotor('C');
motorRight = NXTMotor('B');

threshold = 80;

isColorMode = false;

finished = 0;

pos1 = 0;
pos2 = 0;

positionFirstBox = 0;
positionSecondBox = 0;

diameter = 5.2;
circumference = diameter * pi;

% Открытие датчиков
OpenUltrasonic(SENSOR_1);
OpenLight(SENSOR_4, 'ACTIVE');
OpenLight(SENSOR_3, 'ACTIVE');




while true


    fprintf('pos1: %d, pos2: %d', pos1, pos2);


    lightValueRight = GetLight(SENSOR_3);
    lightValueLeft = GetLight(SENSOR_4);

    distance = GetUltrasonic(SENSOR_1);

    if lightValueLeft < 450 && lightValueRight >= 450
        fprintf('Left\n');
        correctLeft(motorLeft, motorRight);
    elseif lightValueLeft >= 450 && lightValueRight < 450
        fprintf('Right\n');
        correctRight(motorLeft, motorRight);
    elseif lightValueLeft <= 500 && lightValueRight <= 500
        moveForward(motorLeft, motorRight, 20);
        pause(1);
       
        stopMotors(motorLeft, motorRight);

    
        pause(2);

    if (lightValueLeft > 530 && lightValueLeft < 630) || (lightValueRight > 530 && lightValueRight < 650) % Red
        fprintf('Red\n');
            moveForward(motorLeft, motorRight, -20);

        pause(13);
        stopMotors(motorLeft, motorRight);
    end
    if (lightValueLeft > 350 && lightValueLeft < 430) || (lightValueRight > 350 && lightValueRight < 430)% blau
        fprintf('Blue\n');
            moveForward(motorLeft, motorRight, -20);

        pause(10.5);
        stopMotors(motorLeft, motorRight);
    end
    if (lightValueRight > 470 && lightValueRight < 500) || (lightValueLeft > 470 && lightValueLeft < 500) % green
        fprintf('green\n');
            moveForward(motorLeft, motorRight, -20);
        pause(8.3);
        stopMotors(motorLeft, motorRight);
    end

    CloseSensor(SENSOR_1);
    CloseSensor(SENSOR_3);
    CloseSensor(SENSOR_4);
    
    COM_CloseNXT(h);
    
    error('Program finished.');

    else 
        fprintf('Forward\n');
        moveForward(motorLeft, motorRight, 20);
    end

    

    fprintf('Расстояние: %d см, Свет1: %d, Ligh4t 2: %d, positionFirstBox: %d, positionSecondBox: %d\n', ...
        distance, lightValueLeft, lightValueRight, positionFirstBox, positionSecondBox);

    if pos2 == 1
        positionSecondBox = 15;
    end
    if pos2 == 2
        positionSecondBox = 20;
    end
    if pos2 == 3
        positionSecondBox = 40;
    end

    if pos1 == 1
        positionFirstBox = 15;
    end
    if pos1 == 2
        positionFirstBox = 20;
    end
    if pos1 == 3
        positionFirstBox = 40;
    end

    if distance < 65 && pos1 == 0
        if distance >= 14 && distance <= 22
            pos1 = 1;
            while 1
                lightValueRight = GetLight(SENSOR_3);
                lightValueLeft = GetLight(SENSOR_4);
            
                distance = GetUltrasonic(SENSOR_1);

                if distance > 120
                    break;
                end

                if lightValueLeft < 450 && lightValueRight >= 450
                    fprintf('Left\n');
                    correctLeft(motorLeft, motorRight);
                elseif lightValueLeft >= 450 && lightValueRight < 450
                    fprintf('Right\n');
                    correctRight(motorLeft, motorRight);
                else 
                    fprintf('Forward\n');
                    moveForward(motorLeft, motorRight, 20);
                end
            end
        elseif distance >= 32 && distance <= 39
            pos1 = 2;
            while 1
                lightValueRight = GetLight(SENSOR_3);
                lightValueLeft = GetLight(SENSOR_4);
            
                distance = GetUltrasonic(SENSOR_1);

                if distance > 100
                    break;
                end

                if lightValueLeft < 450 && lightValueRight >= 450
                    fprintf('Left\n');
                    correctLeft(motorLeft, motorRight);
                elseif lightValueLeft >= 450 && lightValueRight < 450
                    fprintf('Right\n');
                    correctRight(motorLeft, motorRight);
                else 
                    fprintf('Forward\n');
                    moveForward(motorLeft, motorRight, 20);
                end
            end
        elseif distance >= 55 && distance <= 60
            pos1 = 3;
            
            while 1

                fprintf('cicle');
                lightValueRight = GetLight(SENSOR_3);
                lightValueLeft = GetLight(SENSOR_4);
            
                distance = GetUltrasonic(SENSOR_1);

                if distance > 100
                    break;
                end

                if lightValueLeft < 450 && lightValueRight >= 450
                    fprintf('Left\n');
                    correctLeft(motorLeft, motorRight);
                elseif lightValueLeft >= 450 && lightValueRight < 450
                    fprintf('Right\n');
                    correctRight(motorLeft, motorRight);
                else 
                    fprintf('Forward\n');
                    moveForward(motorLeft, motorRight, 20);
                end
            end
        end
    end
    
    if distance < 65 && pos1 ~= 0 && pos2 == 0 
        if distance >= 10 && distance <= 30
            pos2 = 1;
        
        elseif distance >= 35 && distance <= 45
            pos2 = 2;
            
        elseif distance > 50 && distance < 60
            pos2 = 3;
        end
    end

    % Обнаружение линии
    

    % Обнаружение препятствий
    if positionFirstBox ~= 0 && positionSecondBox ~= 0

        if pos1 ~= pos2 

            if pos2 == 1
                turnLeftBack(motorLeft,motorRight);
            else
            turnLeft(motorLeft, motorRight);
            end
            stopMotors(motorLeft, motorRight);
                
            rotations = (positionSecondBox - 1) / circumference;
            degrees = abs(round(rotations * 360));
    
            ungrip(motorGrip);
    
            motorLeft.TachoLimit = degrees;
            motorRight.TachoLimit = degrees;

            moveForward(motorLeft, motorRight, 20);
    
            fprintf('degrees: %d', degrees);
    
            motorLeft.WaitFor();
            motorRight.WaitFor();
    
            stopMotors(motorLeft, motorRight);
    
            grip(motorGrip);

                

            if abs(pos2 - pos1) == 2 

                moveDistance = 44;
             
            elseif abs(pos2 - pos1) == 1
                moveDistance = 24;
            end

            rotations = abs(moveDistance) / circumference;
             degrees = abs(round(rotations * 360));
         
             motorLeft.TachoLimit = degrees;
             motorRight.TachoLimit = degrees;
             moveForward(motorLeft, motorRight, -20);
            motorLeft.WaitFor();
            motorRight.WaitFor();
             motorLeft.TachoLimit = 0;
             motorRight.TachoLimit = 0;
            end
         if pos2 < pos1
             
             if abs(pos2 - pos1) == 2 

                moveDistance = 44;
             
            elseif abs(pos2 - pos1) == 1
                moveDistance = 24;
            end

             rotations = moveDistance / circumference;
             degrees = abs(round(rotations * 360));
         
             motorLeft.TachoLimit = degrees;
             motorRight.TachoLimit = degrees;
             moveForward(motorLeft, motorRight, 20);
            motorLeft.WaitFor();
            motorRight.WaitFor();
             motorLeft.TachoLimit = 0;
             motorRight.TachoLimit = 0;
         
         end
         
         stopMotors(motorLeft, motorRight);
         ungrip(motorGrip);
         
         
         if pos1 == 1
            rotations = (positionFirstBox - 2) / circumference;
             degrees = abs(round(rotations * 360));
             
             
             motorLeft.TachoLimit = degrees;
             motorRight.TachoLimit = degrees;
             moveForward(motorLeft, motorRight, -20);
                motorLeft.WaitFor();
                motorRight.WaitFor();
             motorLeft.TachoLimit = 0;
             motorRight.TachoLimit = 0;
         end

         if pos1 == 2
             rotations = (positionFirstBox + 10) / circumference;
             degrees = abs(round(rotations * 360));
             
             
             motorLeft.TachoLimit = degrees;
             motorRight.TachoLimit = degrees;
             moveForward(motorLeft, motorRight, -20);
                motorLeft.WaitFor();
                motorRight.WaitFor();
             motorLeft.TachoLimit = 0;
             motorRight.TachoLimit = 0;
         end
         

         if pos1 == 3
             rotations = (positionFirstBox + 14) / circumference;
             degrees = abs(round(rotations * 360));
             
             
             motorLeft.TachoLimit = degrees;
             motorRight.TachoLimit = degrees;
             moveForward(motorLeft, motorRight, -20);
                motorLeft.WaitFor();
                motorRight.WaitFor();
             motorLeft.TachoLimit = 0;
             motorRight.TachoLimit = 0;
         end
         
         
         
         turnRight(motorLeft, motorRight);

        positionFirstBox = 0;
        positionSecondBox = 0;
        pos1 = 10;
        pos2 = 10;

        end
        

    end



    

    % Выход по клавише (например, "q")
    if strcmp(get(gcf, 'CurrentCharacter'), 'q')
        break;
    end
end


