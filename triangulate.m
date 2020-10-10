function [cords_3D] = triangulate(cords0, cords1, camera0, camera1)

P = camera0.Kmat * camera0.Pmat;
P_prime = camera1.Kmat * camera1.Pmat;
x = cords0(1,:);
y = cords0(2,:);
x_prime = cords1(1,:);
y_prime = cords1(2,:);

cords_3D = zeros(3, size(cords0,2));

for i = 1:size(cords0,2)
    A = [y(i) * P(3,:) - P(2,:);
        P(1,:) - x(i) * P(3,:); 
        y_prime(i) * P_prime(3,:) - P_prime(2,:);
        P_prime(1,:) - x_prime(i) * P_prime(3,:)];

    % solve SVD SX = 0
    [U, S, V] = svd(A);
    cords_3D(:,i) = V(1:3,4) / V(4,4);
end

end

