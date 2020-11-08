function projected2DPoints  = project3DTo2D(camera, projected2DPoints)

projected2DPoints(4,:) = 1;
projected2DPoints = camera.Kmat * camera.Pmat * projected2DPoints;

for i = 1:size(projected2DPoints, 2)
    projected2DPoints(1:2,i) = projected2DPoints(1:2,i) / projected2DPoints(3,i);
end

projected2DPoints(3,:) = [];
end

