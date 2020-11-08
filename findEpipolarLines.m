function [EpipolarLines1, EpipolarLines2] = findEpipolarLines(cords0,cords1,vue2,vue4)
% [EpipolarLines1, EpipolarLines2] = findEpipolarLines(worldCoord3DPoints, cam1, cam1PixelCoords, cam2, cam2PixelCoords)

e = project3DTo2D(vue2, vue4.position');
e_prime = project3DTo2D(vue4, vue2.position');

x = linspace(0,1920,1920);
EpipolarLines1 = zeros(size(cords0,2),1920);
EpipolarLines2 = zeros(size(cords0,2),1920);

for i = 1:size(cords0,2)
    EpipolarLines1(i,:) = ((cords0(2,i) - e(2)) / (cords0(1,i) - e(1)) .* (x - e(1))) + e(2);
    EpipolarLines2(i,:) = ((cords1(2,i) - e_prime(2)) / (cords1(1,i) - e_prime(1)) .* (x - e_prime(1))) + e_prime(2);
end
end
