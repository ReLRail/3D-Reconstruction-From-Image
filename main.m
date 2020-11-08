%load all data
load('Subject4-Session3-Take4_mocapJoints.mat')

vue2 = load('vue2CalibInfo.mat').vue2
vue4 = load('vue4CalibInfo.mat').vue4

vue2video = VideoReader('Subject4-Session3-24form-Full-Take4-Vue2.mp4');
vue4video = VideoReader('Subject4-Session3-24form-Full-Take4-Vue4.mp4');


mocapFnum = 1000; %mocap frame number 1000

x = mocapJoints(mocapFnum,:,1); %array of 12 X coordinates
y = mocapJoints(mocapFnum,:,2); % Y coordinates
z = mocapJoints(mocapFnum,:,3); % Z coordinates
conf = mocapJoints(mocapFnum,:,4) %confidence values

vue2video.CurrentTime = (mocapFnum-1)*(50/100)/vue2video.FrameRate;
vid2Frame = readFrame(vue2video);
image(vid2Frame)

cords = project3DTo2D(vue2,[x; y; z]);

hold on;
scatter(cords(1,:), cords(2,:), 5, 'red');
hold off;


vue4video.CurrentTime = (mocapFnum-1)*(50/100)/vue2video.FrameRate;
vid4Frame = readFrame(vue4video);
image(vid4Frame)

cords = project3DTo2D(vue4,[x; y; z]);

hold on;
scatter(cords(1,:), cords(2,:), 5, 'red');
hold off;

cords0 = project3DTo2D(vue2, [x; y; z]);
cords1 = project3DTo2D(vue4, [x; y; z]);
cords_3D = reconstruct3DFrom2D(vue2, cords0, vue4, cords1);
disp('Reconstruction error');
disp(mean(L2([x; y; z], cords_3D)));


[lines1 , lines2] = findEpipolarLines(cords0, cords1, vue2, vue4);

tmp = linspace(0,1920,1920);

colors = 'ymcrgbw';

figure(1)
image(vid2Frame)
hold on;
for i = 1:size(cords0,2)
    color = mod(i,size(colors,2)) + 1;
    plot(tmp, lines1(i,:), 'Color', colors(color));
    scatter(cords0(1,i), cords0(2,i), 20, colors(color), 'filled');
end
    
hold off;
figure(2)
image(vid4Frame)
hold on;
for i = 1:size(cords1,2)
    color = mod(i,size(colors,2)) + 1;
    plot(tmp, lines2(i,:), 'Color', colors(color));
    scatter(cords1(1,i), cords1(2,i), 20, colors(color), 'filled');
end


x = zeros(1,size(mocapJoints,2));
y = zeros(1,size(mocapJoints,2));
z = zeros(1,size(mocapJoints,2));
totalError = zeros(1);
errFrames = zeros(1);
ind = 1;
for frame = 1:size(mocapJoints,1)
    if sum(mocapJoints(frame,:,4)) == 12
        x(ind,:) = mocapJoints(frame,:,1);
        y(ind,:) = mocapJoints(frame,:,2);
        z(ind,:) = mocapJoints(frame,:,3);
        worldCoords = [x(ind,:); y(ind,:); z(ind,:)];
        imageCoords1 = project3DTo2D(vue2, worldCoords);
        imageCoords2 = project3DTo2D(vue4, worldCoords);
        recovered = reconstruct3DFrom2D(vue2, imageCoords1, vue4, imageCoords2);
        totalError(ind) = sum(L2(recovered, worldCoords));
        errFrames(ind) = frame;
        ind = ind + 1;
    end
end

for i = 1:size(mocapJoints,2)
    worldCoords = [x(:,i)'; y(:,i)'; z(:,i)'];
    imageCoords1 = project3DTo2D(vue2, worldCoords);
    imageCoords2 = project3DTo2D(vue4, worldCoords);
    recovered = reconstruct3DFrom2D(vue2, imageCoords1, vue4, imageCoords2);
    values = L2(recovered, worldCoords);
    fprintf('Joint: %d\n',i);
    fprintf('Mean: %d\n',mean(values));
    fprintf('Stdev: %d\n',std(values));
    fprintf('Minimum: %d\n',min(values));
    fprintf('Median: %d\n',median(values));
    fprintf('Maximum: %d\n\n',max(values));
end


worldCoords = [reshape(x(:,:),1,[]); reshape(y(:,:),1,[]); reshape(z(:,:),1,[])];
imageCoords1 = project3DTo2D(vue2, worldCoords);
imageCoords2 = project3DTo2D(vue4, worldCoords);
recovered = reconstruct3DFrom2D(vue2, imageCoords1, vue4, imageCoords2);
values = L2(recovered, worldCoords);
disp('Entire dataset L2 error stats');
fprintf('Mean: %d\n',mean(values));
fprintf('Stdev: %d\n',std(values));
fprintf('Minimum: %d\n',min(values));
fprintf('Median: %d\n',median(values));
fprintf('Maximum: %d\n\n',max(values));

figure(3)
plot(1:size(totalError,2), totalError);

[val, frameNumMin] = min(totalError); % min error frame
vidFrameMin = errFrames(frameNumMin);
[val, frameNumMax] = max(totalError); % max error frame
vidFrameMax = errFrames(frameNumMax);

h = figure(4);
vue2video.CurrentTime = (vidFrameMin-1)*(50/100)/vue2video.FrameRate;
vid2FrameMin = readFrame(vue2video);
image(vid2FrameMin)

x_s = x(frameNumMin,:);
y_s = y(frameNumMin,:);
z_s = z(frameNumMin,:);
skelMin = [x_s; y_s; z_s];
imageCoords = project3DTo2D(vue2, skelMin);
skelMin = skeleton(imageCoords);
hold on;
plot(skelMin(1,:), skelMin(2,:));
hold off;

figure(5)

vue2video.CurrentTime = (vidFrameMax-1)*(50/100)/vue2video.FrameRate;
vid2FrameMax = readFrame(vue2video);
image(vid2FrameMax)

x_s = x(frameNumMax,:);
y_s = y(frameNumMax,:);
z_s = z(frameNumMax,:);
skelMax = [x_s; y_s; z_s];
imageCoords = project3DTo2D(vue2, skelMax);
skelMax = skeleton(imageCoords);
hold on;
plot(skelMax(1,:), skelMax(2,:));
hold off;

figure(7)
mocapFnum = 1000; 
x_s = mocapJoints(mocapFnum,:,1);
y_s = mocapJoints(mocapFnum,:,2);
z_s = mocapJoints(mocapFnum,:,3);
skel = [x_s; y_s; z_s];
skel = skeleton(skel);
plot3(skel(1,:), skel(2,:), skel(3,:));

worldCoords = [x_s; y_s; z_s];
imageCoords1 = project3DTo2D(vue2, worldCoords);
imageCoords2 = project3DTo2D(vue4, worldCoords);
recovered = reconstruct3DFrom2D(vue2,imageCoords1, vue4, imageCoords2);
skel = skeleton(recovered);
hold on;
figure(8);
plot3(skel(1,:), skel(2,:), skel(3,:));
