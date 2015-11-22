N = [10 50 100 500 800 1000 1500]; 
CPU = [0.000004 0.000339 0.003024 0.367524 2.199383 2.921176 14.698782; 0.000006 0.000490 0.003671 0.362220 2.199110 3.184122 14.342276; 0.000005 0.000828 0.003433 0.363154 1.455170 3.090197 14.757960; 0.000009 0.000827 0.003813 0.365044 2.193791 2.916863 15.048220];
CPU = mean(CPU);
GPU = [0.000062 0.000080 0.000134 0.003069 0.009425 0.019922 0.065490; 0.000061 0.000081 0.000127 0.003071 0.009434 0.019958 0.065575; 0.000063 0.000080 0.000128 0.003072 0.009429 0.020026 0.065537; 0.000063 0.000079 0.000126 0.003065 0.009416 0.019956 0.065630]; 
GPU = mean(GPU);

SpeedUp = CPU./GPU; 

subplot(2, 2, 1);
plot(N, CPU);
title('N vs CPU');
xlabel ('Tamaño del Array N*N');
ylabel ('Tiempo (Sec)');
grid;
subplot(2, 2, 2);
plot(N, GPU);
title('N vs GPUs');
xlabel ('Tamaño del Array N*N');
ylabel ('Tiempo (Sec)');
grid;

subplot(2, 2, 3);
plot(N, CPU, N, GPU);
legend('CPU', 'GPU');
title('CPU vs GPU');
xlabel ('Tamaño del Array N*N');
ylabel ('Tiempo (Sec)');
grid;

subplot(2, 2, 4);
bar(N, SpeedUp);
title('Speed Up');
xlabel ('Tamaño del Array N*N');
ylabel ('CPU/GPU');