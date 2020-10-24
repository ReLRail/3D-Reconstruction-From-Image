function [] = epipolar(cords0,cords1,frame,vue2,vue4,vue2video,vue4video)

e = cordTrans(vue4.position', vue2);
e_prime = cordTrans(vue2.position', vue4);

vue2video.CurrentTime = (frame-1)*(50/100)/vue2video.FrameRate;
vid2Frame1 = readFrame(vue2video);

vue4video.CurrentTime = (frame-1)*(50/100)/vue4video.FrameRate;
vid2Frame2 = readFrame(vue4video);

x = linspace(0,size(vid2Frame1,2),size(vid2Frame1,2));
lines1 = zeros(size(cords0,2),size(vid2Frame1,2));
lines2 = zeros(size(cords0,2),size(vid2Frame1,2));

for i = 1:size(cords0,2)
    lines1(i,:) = ((cords0(2,i) - e(2)) / (cords0(1,i) - e(1)) .* (x - e(1))) + e(2);
    lines2(i,:) = ((cords1(2,i) - e_prime(2)) / (cords1(1,i) - e_prime(1)) .* (x - e_prime(1))) + e_prime(2);
end

colors = 'ymcrgbw';

figure(1)
image(vid2Frame1)
hold on;
for i = 1:size(cords0,2)
    color = mod(i,size(colors,2)) + 1;
    plot(x, lines1(i,:), 'Color', colors(color));
    scatter(cords0(1,i), cords0(2,i), 20, colors(color), 'filled');
end
    
hold off;
figure(2)
image(vid2Frame2)
hold on;
for i = 1:size(cords1,2)
    color = mod(i,size(colors,2)) + 1;
    plot(x, lines2(i,:), 'Color', colors(color));
    scatter(cords1(1,i), cords1(2,i), 20, colors(color), 'filled');
end
end
