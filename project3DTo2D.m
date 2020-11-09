function projected2DPoints  = project3DTo2D(camera, worldCoord3DPoints)

worldCoord3DPoints(4,:) = 1;
projected2DPoints = camera.Kmat * camera.Pmat * worldCoord3DPoints;

for i = 1:size(projected2DPoints, 2)
    projected2DPoints(1:2,i) = projected2DPoints(1:2,i) / projected2DPoints(3,i);
end

projected2DPoints(3,:) = 1;
end

