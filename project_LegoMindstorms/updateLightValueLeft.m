function updateLightValueLeft ()
    global lightValueLeft;
    fprintf('Лево');
    lightValueLeft = GetLight(SENSOR_4);
    if lightValueLeft < 370
        fprintf('Correction');
        correctLeft(motorLeft, motorRight);
    end
end