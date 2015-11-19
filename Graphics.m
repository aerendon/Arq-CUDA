x = [183 125 15 8 7 12]

%Circular
pie(x),legend('PP', 'PSOE','CiU','IU','PNV','Otros') %2D
pie3(x,[1 1 0 0 0 0]) %3D

%Barras
y = [10 2 3 5 18 20 15 ];

subplot(3,3,1),bar(y),title('Barras Verticales')
subplot(3,3,2),barh(y),title('Barras Horizontales')
subplot(3,3,3),bar3(y),title('Barras Verticales 3D')
subplot(3,3,4),bar3h(y),title('Barras Horizontales 3D')