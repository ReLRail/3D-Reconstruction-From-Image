function recovered3DPoints = reconstruct3DFrom2D(cam1, cam1PixelCoords, cam2, cam2PixelCoords)

P = cam1.Kmat * cam1.Pmat;
P_prime = cam2.Kmat * cam2.Pmat;
x = cam1PixelCoords(1,:);
y = cam1PixelCoords(2,:);
x_prime = cam2PixelCoords(1,:);
y_prime = cam2PixelCoords(2,:);

recovered3DPoints = zeros(3, size(cam1PixelCoords,2));

for i = 1:size(cam1PixelCoords,2)
    A = [y(i) * P(3,:) - P(2,:);
        P(1,:) - x(i) * P(3,:); 
        y_prime(i) * P_prime(3,:) - P_prime(2,:);
        P_prime(1,:) - x_prime(i) * P_prime(3,:)];

    % solve SVD SX = 0
    [U, S, V] = svd(A);
    recovered3DPoints(:,i) = V(1:3,4) / V(4,4);
end

end

