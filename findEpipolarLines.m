function [EpipolarLines1, EpipolarLines2] = findEpipolarLines(worldCoord3DPoints, cam1, cam1PixelCoords, cam2, cam2PixelCoords)
% 

e = project3DTo2D(cam1, cam2.position');
e_prime = project3DTo2D(cam2, cam1.position');

x = linspace(0,1920,1920);
EpipolarLines1 = zeros(size(cam1PixelCoords,2),1920);
EpipolarLines2 = zeros(size(cam1PixelCoords,2),1920);

for i = 1:size(cam1PixelCoords,2)
    EpipolarLines1(i,:) = ((cam1PixelCoords(2,i) - e(2)) / (cam1PixelCoords(1,i) - e(1)) .* (x - e(1))) + e(2);
    EpipolarLines2(i,:) = ((cam2PixelCoords(2,i) - e_prime(2)) / (cam2PixelCoords(1,i) - e_prime(1)) .* (x - e_prime(1))) + e_prime(2);
end
end
