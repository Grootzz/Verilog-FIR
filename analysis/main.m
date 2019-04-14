% analysis of floating-point domain and fixed-point for FIR 
% FIR coef stem from FilterDesigner tool
% floating-point conversion to fixed-point

clc ,clear, close all;
fs = 48000; % simpling frequency
fpass = 2400;
fstop = 9600;
t = 0:1/fs:0.005; % 0.005 s signal 
signal = sin(2*pi*fpass*t) + sin(2*pi*2*fstop*t);

figure(1),subplot(2,1,1);
plot(t , signal);xlabel('signal with noise');

re_signal = filter(LPF , signal);
subplot(2,1,2);
plot(t,re_signal);xlabel('filtered signal without noise');

% floating-point conversion to fixed-point
% filter coefficients
coefStruct = load('coef');
coef = coefStruct.Num;
% define input word length and determined the scaling length
WL = 16;% input word length
IN_SCALE = 14;% input scaling length
COEF_SCALE = 16;% coefficients scaling length 

% quantize
signal_scale = round(signal * 2^IN_SCALE);
coef_scale = round(coef * 2^COEF_SCALE);
result_scale = filter(coef_scale , 1 , signal_scale);% filtering signal

err_signal = signal_scale * 2^(-IN_SCALE) - signal;
err_coef = coef_scale * 2^(-COEF_SCALE) - coef;

% de-scale result_scale
result_approximate = result_scale * 2^(-(IN_SCALE + COEF_SCALE));
fprintf('error of scaleing signal and the law singal : %d\n' , sumsqr(result_approximate-re_signal));

figure(2);
subplot(211);plot(t , err_signal); xlabel(['quantized err of signal,','sumsqr:',num2str(sumsqr(err_signal))]);
subplot(212);plot(0:length(coef)-1 , err_coef);xlabel(['quantized err of coef,','sumsqr:',num2str(sumsqr(err_coef))]);

figure(3);
subplot(211);plot(t,signal_scale);xlabel('scaled signal input');
subplot(212);plot(t,result_scale);xlabel('scaled filter output');

figure(4);
plot(t , result_approximate-re_signal);xlabel('Error of between fixed-output and float-output');

f = fopen('databin.txt' , 'w');
fprintf(f ,'%g\n' , signal_scale');
fclose(f);
