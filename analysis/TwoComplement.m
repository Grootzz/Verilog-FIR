% transforminteger number (including positive and negaitive) to Two complement

WIDTH = 16;

signal_trans2c = dec2bin(signal_scale + 2^WIDTH * (signal_scale<0) , WIDTH);

signal_trans2c = signal_trans2c';
fdata = fopen('databin.mem' , 'wb');

for index = 1:length(signal_scale)
    for i = 1:WIDTH 
        fprintf( fdata ,'%s' , signal_trans2c((index-1) * WIDTH + i));
    end
    fprintf(fdata , '\r\n'); % entering a enter and new a line
end
fclose(fdata);