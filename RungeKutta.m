classdef RungeKutta
        
    properties
        grid;
        
        N;
        
        A;
        b;
        s;
        
        dynamics;
        objective;
        
        
        X0;
     
    end
    
    methods
                
        function obj = RungeKutta(grid, dynamics, objective, A, b, s, X0, N)
            obj.grid = grid;
            obj.A = A;
            obj.b = b;
            obj.s = s;
            obj.N = N;            
            obj.dynamics = dynamics;
            obj.objective = objective;
            obj.X0 = X0;
        end
        
        
        
        
        function [solx, soly] = solve_forward_equation(obj, solu)
            solx = zeros(obj.N+1, obj.grid.n+1);
            solx(:, 1) = obj.X0;
            soly = zeros(obj.N+1, obj.grid.n, obj.s);

            
            for k=1:obj.grid.n
                solx(:, k+1) = solx(:, k);
                for i=1:obj.s
                   soly(:, k, i) = solx(:, k);
                   for j=1:obj.s
                       if i>j
                           soly(:, k, i) = soly(:, k, i) + obj.grid.h * obj.A(i, j) * obj.dynamics.F(soly(:, k, j), solu(k, j));
                       end
                   end
                   solx(:, k+1) = solx(:, k+1) + obj.grid.h*obj.b(i) * obj.dynamics.F(soly(:, k, i), solu(k, i));
                end
            end
        end
        
        
        
        
        
        
        function [solp, solkhi] = solve_adjoint_equation(obj, solu, solx, soly)
            solp = zeros(obj.N+1, obj.grid.n+1);
            solp(:, obj.grid.n+1) = -obj.objective.Gxphi(solx(:, obj.grid.n+1));
            solkhi = zeros(obj.N+1, obj.grid.n, obj.s);

           for k=obj.grid.n:-1:1
                solp(:, k) = solp(:, k+1);
%                 for i=1:obj.s
                for i=obj.s:-1:1    
                   solkhi(:, k, i) = solp(:, k+1);
                   for j=1:obj.s
%                        if i>j
                       if j>i
                           solkhi(:, k, i) = solkhi(:, k, i) + obj.grid.h * obj.A(j, i) * obj.b(j)/obj.b(i) * (solkhi(:, k, j)' * obj.dynamics.GxF(soly(:, k, j)))';
                       end
                   end
                   solp(:, k) = solp(:, k) + obj.grid.h * obj.b(i) * (solkhi(:, k, i)' *  obj.dynamics.GxF(soly(:, k, i)))';
                end
            end
        end
        
        
        
        
        
                                                                                            
        
        
        function res = g_u(obj, solu)
           [solx, soly] = obj.solve_forward_equation(solu);
           [solp, solkhi] = obj.solve_adjoint_equation(solu, solx, soly);
            
           res = zeros(obj.grid.n, obj.s);
           for k=1:obj.grid.n
               for i=1:obj.s
                   res(k, i) = -obj.grid.h*obj.b(i) * solkhi(:, k, i)' * obj.dynamics.GuF(solu(k, i));
               end
           end
        end
        
        
        
        
        
        
        
        
%         function res = fmesh(obj, k, i)
%             res = obj.mesh.t(k) + obj.c(i)*obj.mesh.h;
%         end
        
    end
    
end

