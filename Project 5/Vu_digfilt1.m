function [output, a]=Vu_digfilt1(input)

d=size(input);
if d(1)>d(2)
    input=input';
    d=size(input);
    fprintf('Array was transposed, dimension is now %0.0f by %0.0f\n',...
        d(1),d(2));
else
    fprintf('Array dimension is %0.0f by %0.0f\n',d(1),d(2));
end
a=1;
output=[1 length(input)-8];
for n=9:1:length(input)
output(a)=1/231*((-21*input(n)+14*input(n-1)+39*input(n-2)+54*input(n-3)+...
    59*input(n-4)+54*input(n-5)+39*input(n-6)+14*input(n-7)-...
    21*input(n-8)));
a=a+1;
end
fprintf('Size of output file is %0.0f', length(output));
a=length(output);