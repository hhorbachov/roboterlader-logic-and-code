function grip(motorGrip)

    motorGrip.Power = -10;
    motorGrip.SendToNXT();
    pause(1);
    motorGrip.Power = 0;
    motorGrip.SendToNXT();
end