clear;clc;close all;
%Khang Vu, Project 3, Completed: 

%Part 1
%Problem A
%The dot product is calculated by multiplying the magnitudes of both
%vectors and the cosine of the angle between both vectors
A=[3 4 -5 7 9]; B=[-7 3 0 -15 -4];
dotProd=dot(A,B);
fprintf('The dot product of A and B is %0.0f\n',dotProd);

%Problem B
%The vector norm is the magnitude of the vector in Euclidian geometry. It
%is calculated by squaring all the values in the vector, adding them all,
%then taking the square root.
normA=norm(A);
normB=norm(B);
fprintf('The norm of A is %0.0f\nThe norm of B is %0.0f\n',normA,normB);

%Problem C
%The cross product is calculated by using the idea that a cross product of
%a 3 dimensional matrix is similar to the determinant of that matrix.
X=[-1 4 -5];Y=[-5 13 7];
CrossProd=cross(X,Y);
fprintf('The cross product of X and y is %0.0fi+%0.0fj+%0.0fk\n',...
    CrossProd(1),CrossProd(2),CrossProd(3));

%Part 2
%Part A
Bob=[1 2 3;2 4 5;3 5 6]; George=[-4 3 -7; 5 2 1; 3 5 2];
invBob=inv(Bob);
disp('The inverse of matrix "Bob" is: ');
disp(invBob);

%Part B
AugBob=[Bob eye(size(Bob))];
rrefBob=rref(AugBob);
disp('The inverse matrix of "Bob" obtained through the rref function is');
disp(rrefBob(:,4:6));

%Part C
disp('The array product of Bob and George is: ');
disp(Bob.*George);

disp('The matrix product of Bob and George is: ');
disp(Bob*George);

%Part D
fprintf('The determinant of "Bob" is %0.0f\n', det(Bob));
fprintf('The determinant of "Geroge" is %0.0f\n', det(George));

%Part E
fprintf('The rank of "Bob" is %0.0f\n', rank(Bob));
fprintf('The rank of "George" is %0.0f\n',rank(George));

%Part 3
%Part A
A=[2 2 -2 ;2 1 2 ;1 1 -2 ];
B=[1;0;1];
%a
disp('Using inv function:');
disp(inv(A)*B);
%b
disp('Using A\B:');
disp(A\B);
%c
disp('Using linsolve:');
disp(linsolve(A,B));
%d
disp('Using rref:');
C=rref([A B]);
disp(C(:,4));
%Part B
%pinv was the function used, this function finds the best fit answer or the
%"smallest squares" solution in a systems of equations that has more than
%one solution.
A=[3 -3 -6;2 -2 -4; -2 3 1];
B=[-3; 10; 7];
disp('Pinv:');
disp(pinv(A)*B);

%Part 4
%Part A
figure (1);
n=1;
interval=[2 1 0.5 0.1 .005 .001];

while n<=6    
subplot(3,2,n);
x=0:interval(n):20;
f=2-2*exp(-0.2.*x).*cos(x);
deriv=diff(f);
plot(x(1:length(x)-1),deriv);
title(['Interval of ',num2str(interval(n))]);
xlabel('Time (seconds)');
ylabel('Difference');
grid on;
n=n+1;
end

%Part B
disp('Trapz function:');
disp(trapz(x,f));

%Part C
disp('Integral Function:');
func=@(x) 2-2*exp(-0.2.*x).*cos(x);
disp(integral(func,0,20));

%The results of Part B and C agree