clear;
pkg load control;

ms = 250;               
mu = 20; 
ks = 7000;
cs = 2600;        
kt = 105000; 
         
grav = 9.81;            
v = 60/3.6;                 
dt = 0.001;               
                        
Aqcar = [0     0     1   -1;...
         0     0     0    1;...
       -ks/ms  0  -cs/ms cs/ms;...
        ks/mu -kt/mu cs/mu -cs/mu];
Bqcar = [0 -1 0 0]'; 
Cqcar = [0 0 1 0]; 
Dqcar = 0;
qcar = ss(Aqcar,Bqcar,Cqcar,Dqcar);

x0 = [0 0 0 0]';                        
load road_x                             
load road_z                                                   
dx = road_x(2) - road_x(1);             
dt2 = dx/v;                             
z0dot = [0 diff(road_z)/dt];                 
tmax = 200/v;                           
t = 0:dt:tmax; x = v*t;                 
u = interp1(road_x,z0dot,x);    

y = lsim(qcar,u,t,x0);  
z2dotdot = [0 diff(y(:,1))'/dt2];                    
z0 = interp1(road_x,road_z,x); 
figure ;clf                       
plot(t,z2dotdot/grav,'g-');hold on
plot(t,z0)
plot(t,x/inf)
legend('sprung mass accel (g)','road elevation (m)')
    


