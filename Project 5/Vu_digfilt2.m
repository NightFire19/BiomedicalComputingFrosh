function [output, a]=Vu_digfilt2(input)

d=size(input);
if d(1)>d(2)
    input=input';
    d=size(input);
    fprintf('Array was transposed, dimension is now %0.0f by %0.0f\n',...
        d(1),d(2));
else
    fprintf('Array dimension is %0.0f by %0.0f\n',d(1),d(2));
end

output=[1 length(input)-8]; 
output=1/231*((-21*input(n)+14*input(n-1)+39*input(n-2)+54*input(n-3)+...
    59*input(n-4)+54*input(n-5)+39*input(n-6)+14*input(n-7)-...
    21*input(n-8)));

fprintf('Size of output file is %0.0f\n', length(output));
a=length(output);