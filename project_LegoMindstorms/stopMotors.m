function stopMotors(motorLeft, motorRight)
    motorLeft.Power = 0;
    motorRight.Power = 0;
    motorLeft.SendToNXT();
    motorRight.SendToNXT();
end
