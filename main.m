clear all

%% dimension of the problem
N = 3;

%% define mesh
% T = 10;% best time control for a bad matrix is 8 or 9, above complex values are reached
T = 100;
% T = 30;
% T = 5;
n = 1000;
mesh = Mesh(T, n);

%% define the objective
xT = 0.1;
nu = 0.00001;%1;% 0.5;
alpha = 1;% 0.5;
objective = Objective(N, xT, nu, alpha);

%% define dynamics
% bad matrices
% v = [1/2 0 1/2; 1/2 1/2 0; 0 1/2 1/2]; 
% w = [1/2 1/2 0; 1/2 0 1/2; 1/2 0 1/2]; 

% good matrices
% v = [1/7 1/4 17/28; 1/6  1/8 34/48; 1/5 1/3 7/15];
% w = [1/9 1/3 15/27; 1/11 1/7 59/77; 1/8 1/5 27/40];

% one positive one negative and a zero real eigenvalues
v = [0  1/3   2/3; 1/3  0  2/3; 1/3  2/3  0]; 
w = [0 1/2 1/2; 1/2 0 1/2; 1/2 1/2 0];

gamma = ones(N, 1);
beta = ones(N, 1);

xmax = 1;

dynamics = Dynamics(N, v, w, gamma, beta, xmax, objective);

%% define initial value
x0 = [0.3   0.6  0.9 ]';
X0 = [x0; 0];

%% define Runge Kutta method
A = [0 0 0; 0.5 0 0; -1 2 0];
b = [1.0/6.0    2.0/3.0    1.0/6.0];
c = [0  0.5  1];
s = 3;
rk = RungeKutta(mesh, dynamics, objective, A, b, s, X0, N);

%% initial guess
solu = zeros(n, s);

%% plot solution for the initial guess
plotsolution(rk, solu);

%% run Minimization
eps = 1;% not used yet
sigma = 0.001;
limitLS = 5;
limitA = 10;
[solx, solu] = NCG(rk, objective, mesh, solu, eps, sigma, limitLS, limitA);
  
%% plot the final solutions with respect to time

plotsolutionx(solx, mesh, N)





%%% test
% %% plot the state solutions with respect to each other  (3D)
% figure
% plot3(sol(:, 1), sol(:, 2), sol(:, 3), 'LineWidth', 2);   
% plot3(sol(:, 1), sol(:, 2), sol(:, 3)); 
% plot(sol(:, 1), sol(:, 2), 'LineWidth', 2); 

% %% test
% % display( 'dynamics at the final time:')
% % mytest = dynamics.f(0, sol(:, rk.mesh.n+1))
% % display( 'state at the final time:')
% % sol(:, rk.mesh.n+1)
% % display( 'det(v-w):')
% % det(v-w)
% % display( 'det(v):')
% % det(v)
% % display( 'det(w):')
% % det(w)
% % display( 'v-w:')
% % v-w                    
% 
% 
% 
% 
% % display( 'eig(v-w):')
% % [S, L] = eig(v-w)
% 
% 
% % a = [1; -0.5; -0.5];
% % test(dynamics, 20, 0.01, a);
% 
% 
% % testfi;

