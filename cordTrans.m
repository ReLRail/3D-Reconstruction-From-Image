function [cords] = cordTrans(cords, camera)

cords(4,:) = 1;
cords = camera.Kmat * camera.Pmat * cords;

for i = 1:size(cords, 2)
    cords(1:2,i) = cords(1:2,i) / cords(3,i);
end

cords(3,:) = [];
end

