function moveForward(motorLeft, motorRight, speed)
    motorLeft.Power = -speed;
    motorRight.Power = -speed;
    motorLeft.SendToNXT();
    motorRight.SendToNXT();
end