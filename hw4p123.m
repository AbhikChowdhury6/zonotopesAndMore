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

rpgon = polyshape(x1r, x2r);

plot(rpgon, 'FaceAlpha',0, 'EdgeColor' ,'b');
