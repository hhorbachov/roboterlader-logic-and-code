function ungrip(motorGrip)

    motorGrip.Power = 5;
    motorGrip.SendToNXT();
    pause(1);
    motorGrip.Power = 0;
    motorGrip.SendToNXT();
end