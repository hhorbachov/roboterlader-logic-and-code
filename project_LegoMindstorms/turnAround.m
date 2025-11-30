function turnAround(motorLeft, motorRight)
    motorLeft.Power = -40;
    motorRight.Power = 40;
    motorLeft.SendToNXT();
    motorRight.SendToNXT();
    pause(1.5); % Turn for 1 second
end
