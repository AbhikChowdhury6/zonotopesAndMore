%Abhik Chowdhury

x10 = [5 5 6 6];
x20 = [-1 1 1 -1];

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

point1 = [x1r(1); x2r(1)];
point2 = [x1r(2); x2r(2)];
point3 = [x1r(3); x2r(3)];
point4 = [x1r(4); x2r(4)];

%calculate the center
c = [(x1r(1) + x1r(3))/2; (x2r(1) + x2r(3))/2];

%calculate the generator coefficents of arm 1
%calc unit vector describing direction and multiply by the magnitude over 2
direction = point2 - point1;
direction_scaled = direction/norm(direction); % vector with length 1
g1 = (direction_scaled * norm(point2 - point1))/2;


%calculate the generator coefficents of arm 2
%calc unit vector describing direction and multiply by the magnitude over 2
direction = point4 - point1;
direction_scaled = direction/norm(direction); % vector with length 1
g2 = (direction_scaled * norm(point4 - point1))/2;


rpgon = polyshape(x1r, x2r);

plot(rpgon, 'FaceAlpha',0, 'EdgeColor' ,'b');
