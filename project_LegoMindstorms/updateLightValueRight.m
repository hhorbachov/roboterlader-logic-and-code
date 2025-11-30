function updateLightValueRight ()
    global lightValueRight;
    fprintf('Право');
    lightValueRight = GetLight(SENSOR_3);
    if lightValueRight < 400
        fprintf('Correction');
        correctRight(motorLeft, motorRight);
    end
end