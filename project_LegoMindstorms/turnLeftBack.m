function turnLeftBack(motorLeft, motorRight) 
    pause(2); 
    stopMotors(motorLeft, motorRight);
    motorLeft.Power = 30;
    motorLeft.SendToNXT();
    pause(2);
end