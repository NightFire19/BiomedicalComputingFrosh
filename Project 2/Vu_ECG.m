clear; close all; clc

%NOTE CONCERNING VARIABLE NAME DEFINITION:
%(condition) is used to mean both 'Normal' and 'Afib', for example:
%'(condition)-heartrate' means both Normalheartrate and Afibheartrate
%Also: Variables are created and defined in the first section they are used
%in, but may also be used any subsequent section.

%---DATA CONDITIONING AND DISPLAY---
%Variable Names
%ECG-(condition).....Array containing values of the ECG of the condition
%time................Array of time for the plot.



%Data is uploaded into the workspace
load ECGafib.txt;
load ECGnormal.txt;

time=0:(1/250):((length(ECGafib)/250)-(1/250));

%Data is inverted
ECGafib=-1*ECGafib;
ECGnormal=-1*ECGnormal;


%Two subplots for both conditions' ECGs are created
figure(1);
subplot(2,1,1);
plot(time, ECGnormal);
xlabel('Time (sec)');
ylabel('ECG Signal µV)');
title('ECG Normal');
grid on;

subplot(2,1,2)
plot(time, ECGafib,'r'), hold on;
xlabel('Time (sec)');
ylabel('ECG Signal (µV)');
title('Atrial Fibrillation ECG');
grid on;

%---PQRST DETECTION---
%VARIABLE NAMES:
%(condition)-peak.....Array of the peak heights of condition
%(condition)-index....Array of the index of the peaks of condition
%index................Array of the indecies

%The findpeaks function is used to find both the local maximum 
%The maximum must be greater than 1000 microVolts
%The findpeaks function returns the peak value and its corresponding index
%The peaks are then plotted on the ECG.


index=1:2500;

%Peaks are found along with corresponding index
[afibpeak,afibindex]=findpeaks(ECGafib,'MINPEAKHEIGHT',1000);
[normalpeaks,normalindex]=findpeaks(ECGnormal,'MINPEAKHEIGHT',1000);

%ECG is plotted, along with the peaks in green.
figure(2);
subplot(2,1,2);
plot(index, ECGafib,'r'), hold on;
scatter(afibindex, afibpeak, 'g', '*'), hold off;
xlabel('Data Indicies');
ylabel('ECG Signal (µV)');
title('Atrial Fibrillation ECG');
grid on;

subplot(2,1,1);

plot(index, ECGnormal,'b'), hold on;
scatter(normalindex, normalpeaks, 'g', '*'), hold off;
xlabel('Data Indicies');
ylabel('ECG Signal µV');
title('Normal ECG');
grid on;

%---HEART RATE CALCULATION---
%VARIABLE NAMES:
%(condition)-Intervals....Array that shows the heart beat in
%                         (#seconds/beat)
%(condition)-HeartRate....Array that shows the heart beat in beats per
%                         minute

%The following 'for' loops compute (#seconds/beat) and 
%put them in an array, one for each condition.


for n = 2:12
    normalIntervals(n-1)=(normalindex(n)-normalindex(n-1))/250;
end

for n = 2:12
    afibIntervals(n-1)=(afibindex(n)-afibindex(n-1))/250;
end

%The heart rate for each condition is computed here.
normalHeartRate=(1./(normalIntervals)).*60;
afibHeartRate=(1./(afibIntervals)).*60;

%The heart rate is then plotted for each condition
figure(3);
plot(normalindex(1:11),normalHeartRate,afibindex(1:11), afibHeartRate);
xlabel('Data Indicies');
ylabel('Heart Rate (Beats per Minute)');
title('Heart Rate');
grid on;
legend('Atrial Fibrilation Heart Rate','Normal Heart Rate',...
    'Location','northwest');

%The average heart rate for both conditions is displayed in the 
%command window
disp(['The normal heart rate detected is ',...
    num2str(mean(normalHeartRate)),' beats per minute']);
disp(['The afib heart rate detected is ',...
    num2str(mean(afibHeartRate)),' beats per minute']);

%---PQRST EXTRACTION AND AVERAGING---
%VARIABLES
%(condition)-ECG...........Array containing all the PQRST complexes for the
%                          corresponding condition's ECG
%(condition)-Ave...........Array containing the average PQRST complex
%time......................Array for time for the plot.

%Two arrays, one for each condition, are created with only zeros
NormAve=zeros(221,1);
AfibAve=zeros(221,1);
time=0:1/250:0.88;
NormECG=zeros(221,12);
AfibECG=zeros(221,11);

%Each Array is loaded with the PQRST complexes detected

for n=1:12
    NormECG(:,n)=ECGnormal(normalindex(n)-110:normalindex(n)+110)';
end

for n=2:12
    AfibECG(:,n-1)=ECGafib(afibindex(n)-110:afibindex(n)+110)';
end


%Average of each row of the ECG array is assigned to the average
%array in a 'for' loop.
for n=1:221
    NormAve(n,1)=mean(NormECG(n,:));
end

for n=1:221
    AfibAve(n,1)=mean(AfibECG(n,:));
end

%Plot of the average PQRST complex is created with a legend
figure(4);
plot(time,NormAve,'r',time,AfibAve);
xlabel('Time (sec)');
ylabel('µV');
title('Average PQRST complex');
legend('Normal Average',...
    'Atrial Fibrilation Average',...
    'Location','northwest');
legend('boxoff'); %Removes box around legend due to it
%interfering with the plot

%---TOTAL AVERAGE POWER---
%Variable 
%Ave-(condition)-Power.......Average power of PQRST, in Watts.

%Total Average Power for each condition is computed here
AveNormalPower=((1/length(NormAve))*(sum((NormAve).^2)));
AveAfibPower=((1/length(AfibAve))*(sum((AfibAve).^2)));

%Total Average Power is displayed for each condition
disp(['The Total Average Power of Normal Average PQRST is ',...
    num2str(AveNormalPower),' Watts.']);
disp(['The Total Average Power of Afib Average PQRST is ',...
    num2str(AveAfibPower),' Watts.']);
