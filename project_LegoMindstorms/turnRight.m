function turnRight(motorLeft, motorRight)
    stopMotors(motorLeft, motorRight);
    motorLeft.Power = -28;
    motorLeft.SendToNXT();
    pause(2);
end