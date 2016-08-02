clear all

%% dimension of the problem
N = 3;

%% define mesh
T = 2;
% T = 1000;
% T = 30;
% T = 5;
n = 100;
mesh = Mesh(T, n);

%% define the objective
xT = 0.5; %0.5;
nu = 0.00001;%1;% 0.5;
alpha = 1;% 0.5;
objective = Objective(N, xT, nu, alpha);

%% define dynamics
dynamics = Dynamics(N, objective);

%% define initial value
x0 = [0.3   0.6  0.9 ]';
X0 = [x0; 0];

%% define Runge Kutta method
A = [0 0 0; 0.5 0 0; -1 2 0];
b = [1.0/6.0    2.0/3.0    1.0/6.0];
c = [0  0.5  1];
s = 3;
rk = RungeKutta(mesh, dynamics, objective, A, b, s, X0, N);

%% test
% solu = zeros(n, s);
% % solu = ones(n , s);
% 
% [solx, soly] = rk.solve_forward_equation(solu);
% [solp, solkhi] = rk.solve_adjoint_equation(solu, solx, soly);
% 
% normsolu = normsolu(rk.g_u(solu), mesh)
% phi = objective.phi(solx(:, mesh.n+1))

%% run Minimization
solu = zeros(n, s);

eps = 1;% not used yet
sigma = 0.001;
limitLS = 10;
limitA = 10;
[solx, solu] = NCG(rk, objective, mesh, solu, eps, sigma, limitLS, limitA);

 
%% plot the state solutions with respect to time
sol = solx;
% sol = solp;

for i=1:N
    plot(mesh.t, sol(i, :));
    hold all
end

