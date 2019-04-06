clear; close all; clc;
%Name: Khang Vu
%Project 4: DNA Sequence and Promoter Detection
%Date submitted: 5/3/2016
%Date due: 5/5/2016
%Version 1.0

fileName=[input('Enter a file name please:\n','s'),'.txt'];
data=textread(fileName,'%c'); 
%NOTE: Matlab 'thinks' that textscan would be more efficent, but only
%textread will work.

%Inverts the data so all the functions onward can read it.
data=data';

%Checks and reorients the data so it reads from 5' to 3'
if data(1)=='3'
    data=fliplr(data);
    disp('flip');
end
    data=data(2:length(data)-1);

%Prompts user for promoter, also displays the options.
promoter=input(['Please enter a promoter sequence:\n1:TATAAT\n2:TATATA'...
    '\n3:TATAAA\n'],'s');    
promoterLoc=strfind(data,promoter);

if isempty(promoterLoc)
    %Returns an error if there promoter was not found.
    error(['No promoter was found in the given DNA sequence. '...
        'Melting temperature will not be calculated']);
else
    disp(['The DNA downstream of the promoter is: ' ...
        data(promoterLoc+length(promoter):length(data))]);
end

%'Snips' the data so only the bases after the promoter sequence remain.
data=data(promoterLoc+length(promoter):length(data));

%Computes number of 'G' and 'C' bases, used in both formulas.
G=strfind('G',data); C=strfind('C',data);
GandC=length(G)+length(C);

%Applies proper formula based on number of bases.
if length(data)>14
    temp=64.9+41*((GandC-16.4)/length(data));
else
    A=strfind('A',data); T=strfind('T',data);
    AandT=length(A)+length(T);
    temp=4*GandC+2*AandT;
end

%Displays final results.
fprintf('The melting temperature of the primer sequence is: %0.3f°C\n',...
    temp);