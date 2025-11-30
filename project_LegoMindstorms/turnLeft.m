function turnLeft(motorLeft, motorRight)
    pause(0.5); 
    stopMotors(motorLeft, motorRight);
    motorRight.Power = -31;
    motorRight.SendToNXT();
    pause(2);
end