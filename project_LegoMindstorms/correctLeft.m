function correctLeft(motorLeft, motorRight)
    motorLeft.Power = 0;
    motorRight.Power = -10;
    motorLeft.SendToNXT();
    motorRight.SendToNXT();
    fprintf('CorrectLeft');
    pause(0.5);
    moveForward(motorLeft, motorRight, 20);
end