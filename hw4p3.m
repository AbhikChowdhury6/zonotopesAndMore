%Abhik Chowdhury


w1 = dlarray([-4.2 -1; -3.2 2.2]);
b1 = dlarray([1; 2]);

w2 = dlarray([-1.4 3.2; -1 -5]);
b2 = dlarray([2; -1]);

w3 = dlarray([2 -1]);
b3 = dlarray([0.1]);

%% 

%generate the activations and jacobians 
%step size
stepSize = 0.01;

%x1 range
x1Start = -3;
x1End = 3;
x1range = x1Start + (0: ((x1End-x1Start)*(1/stepSize)))*stepSize;

%x2 range
x2Start = -3;
x2End = 3;
x2range = x2Start + (0: ((x2End-x2Start)*(1/stepSize)))*stepSize;

%create the matrix of activation values
activations = zeros(size(x1range,2), size(x2range,2));
jacobiansx1 = zeros(size(x1range,2), size(x2range,2));
jacobiansx2 = zeros(size(x1range,2), size(x2range,2));

for i=1:size(x1range,2)
   for j=1:size(x2range,2)
       currx1 = x1Start+i*stepSize;
       currx2 = x2Start+j*stepSize;
       currx = [currx1; currx2];
       
       z1 = relu(w1 * currx + b1);
       z2 = relu(w2 * z1 + b2);
       z3 = relu(w3 * z2 + b3);
       
       JF1 = w1;
       if z1(1,1) == 0
           JF1(1,1) = 0;
           JF1(1,2) = 0;
       end
       if z1(2,1) == 0
           JF1(2,1) = 0;
           JF1(2,2) = 0;
       end
       
       JF2 = w2;
       if z2(1,1) == 0
           JF2(1,1) = 0;
           JF2(1,2) = 0;
       end
       if z2(2,1) == 0
           JF2(2,1) = 0;
           JF2(2,2) = 0;
       end
       JF2 = JF2 * JF1;


       JF3 = w3;
       if z3(1,1) == 0
           JF3(1,1) = 0;
           JF3(1,2) = 0;
       end
       JF3 = JF3 * JF2;
       
       jacobiansx1(i,j) = JF3(1,1);
       jacobiansx2(i,j) = JF3(1,2);
       activations(i,j) = z3;
   end
end

%% 

%for the initial condition calculate the slope to find the locally active
%region
%x0 = dlarray([1.5; 2]);
x0 = dlarray([0.66; -2.59]);

%calculate forward prop layer activiations
z1 = relu(w1 * x0 + b1);
z2 = relu(w2 * z1 + b2);
z3 = relu(w3 * z2 + b3);

%calculate the jacobians
JF1 = w1;
if z1(1,1) == 0
   JF1(1,1) = 0;
   JF1(1,2) = 0;
end
if z1(2,1) == 0
   JF1(2,1) = 0;
   JF1(2,2) = 0;
end

JF2 = w2;
if z2(1,1) == 0
   JF2(1,1) = 0;
   JF2(1,2) = 0;
end
if z2(2,1) == 0
   JF2(2,1) = 0;
   JF2(2,2) = 0;
end
JF2 = JF2 * JF1;

JF3 = w3;
if z3(1,1) == 0
   JF3(1,1) = 0;
   JF3(1,2) = 0;
end
%the slope at x0
JF3x0 = JF3 * JF2;

%% 

%calculate and display the locally active regeion
locallyActiveRegionx0 = zeros(size(x1range,2), size(x2range,2));

currMaxActivation = 0;
currMaxLocationx1 = 0;
currMaxLocationx2 = 0;

for i=1:size(x1range,2)
   for j=1:size(x2range,2)
       locallyActiveRegionx0(i,j) = activations(i,j) - 1;
       if jacobiansx1(i,j) == JF3x0(1,1)
           if jacobiansx2(i,j) == JF3x0(1,2)
               locallyActiveRegionx0(i,j) = activations(i,j) + 0.01;
               if activations(i,j) > currMaxActivation
                   currMaxActivation = activations(i,j);
                   currMaxLocationx2 = i;
                   currMaxLocationx1 = j;
               end
           end
       end
   end
end


%% 

%plot it
figure(1)
surf(x1range, x2range, activations, 'EdgeColor','none');
hold on
surf(x1range, x2range, locallyActiveRegionx0, 'FaceColor','r', 'EdgeColor','none')
%plot the max point
plot3(x1range(currMaxLocationx1), x2range(currMaxLocationx2), currMaxActivation, 'o','MarkerSize',10, 'MarkerFaceColor', 'b')
plot3(extractdata(x0(2,1)), extractdata(x0(1,1)), extractdata(z3) + 0.02, 'o','MarkerSize',10 , 'MarkerFaceColor', 'g')
hold off
hold on



























