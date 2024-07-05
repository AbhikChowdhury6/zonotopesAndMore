%Abhik Chowdhury


%define the general problem
p = optimproblem;
x1 = optimvar('x1', 1, 'LowerBound', -3, 'UpperBound', 3);
x2 = optimvar('x2', 1, 'LowerBound', -3, 'UpperBound', 3);
q = optimvar('q', 1, 'Type', 'integer','LowerBound', 0, 'UpperBound', 1);
y = optimvar('y', 1, 'LowerBound', 0);
p.ObjectiveSense = 'maximize';
p.Objective = y;

%get the values of the neural network given some initial conditions
M = 999999999;




%use those values to define constraints
p.constraints.c1 = ;
p.constraints.c1 = ;
p.constraints.c1 = ;
p.constraints.c1 = ;


%solve the constraints to get the location of the maximum value of y