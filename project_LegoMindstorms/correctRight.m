function correctRight(motorLeft, motorRight)
    motorRight.Power = 0;
    motorLeft.Power = -10;
    motorLeft.SendToNXT();
    motorRight.SendToNXT();
    fprintf('CorrectRight');
    pause(0.5);
    moveForward(motorLeft, motorRight, 20);
end