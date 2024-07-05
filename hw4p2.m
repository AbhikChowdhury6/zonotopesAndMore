%Abhik Chowdhury

Ap2 = [-0.1 -1 0 0 0 0];
Ap2 = cat(1, Ap2, [1 -0.1 0 0 0 0]);
Ap2 = cat(1, Ap2, [0 0 -0.2 -2 0 0]);
Ap2 = cat(1, Ap2, [0 0 2 -0.1 0 0]);
Ap2 = cat(1, Ap2, [0 0 0 0 -0.2 0]);
Ap2 = cat(1, Ap2, [0 0 0 0 0 -0.25]);

%disp(Ap2);

Bp2 = [0.74; 0.07; -0.62; -0.27; -0.86; 0.65];

Cp2 = [0.84 -1.03 1.07 -0.88 0.5 0];
Cp2 = cat(1, Cp2, [-0.60 -1.35 -0.26 -0.27 0 -0.5]);

%disp(Cp2);

x0p2 = [0.9 1.1; 0.9 1.1; 0.9 1.1; 0.9 1.1; 0.9 1.1; 0.9 1.1];

ut = [-1 1];

initialZono = zonotope([1; 1; 1; 1; 1; 1], eye(6).* 0.1);

plot(initialZono);

%initialZono = zonotope(interval([0.9; 0.9; 0.9; 0.9; 0.9; 0.9],[1.1; 1.1; 1.1; 1.1; 1.1; 1.1]));

%initialZono = zonotope(


sys = linearSys(Ap2, Bp2, [], Cp2);

params.tFinal = 20;
params.R0 = initialZono;
params.U = zonotope(interval(-1,1));


options.timeStep = 0.01;
options.taylorTerms = 20;
%options.zonotopeOrder = 1;

%R = reach(sys,params,options);

%plot(R);

options.points = 100;
options.fracVert = 0.5;
options.fracInpVert = 1;
options.inpChanges = 10;
% random simulation
simRes = simulateRandom(sys,params,options);

plot(simRes);


rpgon = polyshape([-8 -8 -12 -12], [-8 -12 -12 -8]);

plot(rpgon, 'FaceAlpha',1, 'FaceColor' ,'r');


hold on






















