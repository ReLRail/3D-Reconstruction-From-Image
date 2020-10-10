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

cords = cordTrans([x; y; z], vue2);

hold on;
scatter(cords(1,:), cords(2,:), 5, 'red');
hold off;


vue4video.CurrentTime = (mocapFnum-1)*(50/100)/vue2video.FrameRate;
vid4Frame = readFrame(vue4video);
image(vid4Frame)

cords = cordTrans([x; y; z], vue4);

hold on;
scatter(cords(1,:), cords(2,:), 5, 'red');
hold off;

cords0 = cordTrans([x; y; z], vue2);
cords1 = cordTrans([x; y; z], vue4);
cords_3D = triangulate(cords0, cords1,  vue2, vue4);
disp('Reconstruction error');
disp(mean(L2([x; y; z], cords_3D)));

