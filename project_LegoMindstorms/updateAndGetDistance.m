function updateAndGetDistance()
    global distance prevDistance shortages;
    
    newDistance = GetUltrasonic(SENSOR_1);
    if newDistance < 50
        shortage = newDistance;
        shortages = [shortages, shortage];
    end
    % Update previous distance for next comparison
    prevDistance = newDistance;
    
    % Update global distance
    distance = newDistance;
end