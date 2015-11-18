x = [183 125 15 8 7 12]

%Circular
pie(x),legend('PP', 'PSOE','CiU','IU','PNV','Otros') %2D
pie3(x,[1 1 0 0 0 0]) %3D

%Barras
y = [10 2 3 5 18 20 15 ];

subplot(2,2,1),bar(x),title('Barras Verticales')
subplot(2,2,2),barh(x),title('Barras Horizontales')
subplot(2,2,3),bar3(x),title('Barras Verticales 3D')
subplot(2,2,4),bar3h(x),title('Barras Horizontales 3D')