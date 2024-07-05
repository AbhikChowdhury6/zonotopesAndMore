%Abhik Chowdhury


x10 = [5 5 6 6];
x20 = [-1 1 1 -1];

initialpgon = polyshape(x10, x20);

%initialpgon.FaceAlpha = 0;
%initialpgon.EdgeColor = 'r';

plot(initialpgon, 'FaceAlpha',0, 'EdgeColor' ,'r');

%% 

A = [-7 1; 8 -10];

targetTime = 0.2;

x1r = [0 0 0 0];
x2r = [0 0 0 0];

At = A * targetTime;
eToTheAt = expm(At);


for i=1:size(x10,2)
    %do the bits
    startpoint = [x10(i); x20(i)];
    newpoint = eToTheAt * startpoint;
    %disp(newpoint);
    x1r(i) = newpoint(1);
    x2r(i) = newpoint(2);
end

rpgon = polyshape(x1r, x2r);

plot(rpgon, 'FaceAlpha',0, 'EdgeColor' ,'b');

%% 

%I want 4 sets vectors

%for each point
targetTime = 0.2;
timeStep = 0.0001;

timeSteps = targetTime/timeStep;

for i=1:size(x10,2)
    %make the line
    startpoint = [x10(i); x20(i)];
    
    x1s = zeros(1, timeSteps);
    x2s = zeros(1, timeSteps);
    
    for j=1:timeSteps
        %calc time
        t = timeStep*j;
        At = A * t;
        eToTheAt = expm(At);
        
        %calc new point
        newpoint = eToTheAt * startpoint;

        %split and add to lists
        x1s(j) = newpoint(1);
        x2s(j) = newpoint(2);
    end
    %graph that list 
    %disp(x1s);
    plot(x1s, x2s);
    
end

hold on;















    