% read data solved by physical FIR 
% dataout.txt is the read object 
fid = fopen('E:\ISEProjece\FirDesign\dataout.txt');
fpga_data = textscan(fid, '%d');
fclose(fid);

subplot(211);
% begin output is 0 ,because use 5-level pipeline in physical FIR
plot(fpga_data{1}(6:end));xlabel('The resule of physical FIR');

subplot(212);
plot(result_scale);xlabel('The resule of simulation in matlab');

fprintf('eror (sum of squared) between simulation and physical fir is : %d \n' , sumsqr(double(fpga_data{1}(6:end)) - result_scale'));
