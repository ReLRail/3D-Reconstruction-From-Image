function [distance] = L2(cords0, cords1)
distance = sum((cords0 - cords1) .^ 2);
end