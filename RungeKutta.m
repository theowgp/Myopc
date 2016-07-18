classdef RungeKutta
        
    properties
        mesh;
        A;
        b;
        c;
        s;
        N;
    end
    
    methods
        
        
        function obj = RungeKutta(mesh, A, b, c, s, N)
            obj.mesh = mesh;
            obj.A = A;
            obj.b = b;
            obj.c = c;
            obj.s = s;
            obj.N = N;            
               

        end
        
     
        
        function solx = solve(obj, x0, f)
            solx = zeros(obj.N, obj.mesh.n+1);
            solx(:, 1) = x0;
            soly = zeros(obj.N, obj.mesh.n, obj.s);

            
            for k=1:obj.mesh.n
                solx(:, k+1) = solx(:, k);
                for i=1:obj.s
                   soly(:, k, i) = solx(:, k);
                   for j=1:obj.s
                       if i>j
%                            if soly(:, k, i) + obj.mesh.h*obj.A(i, j)*f(obj.fmesh(k, j), soly(:, k, j)) >= 0
                               soly(:, k, i) = soly(:, k, i) + obj.mesh.h*obj.A(i, j)*f(obj.fmesh(k, j), soly(:, k, j));
%                            else
%                                soly(:, k, i) = 0;
%                            end
                       end
                   end
%                    if solx(:, k+1) + obj.mesh.h*obj.b(i)*f(obj.fmesh(k, i), soly(:, k, i))  >= 0
                       solx(:, k+1) = solx(:, k+1) + obj.mesh.h*obj.b(i)*f(obj.fmesh(k, i), soly(:, k, i));
%                    else
%                        solx(:, k+1) = 0;
%                    end
                end
            end
            solx = solx';
        end
        
        
        
        
        
        
        function res = fmesh(obj, k, i)
            res = obj.mesh.t(k) + obj.c(i)*obj.mesh.h;
        end
        
          
    end
    
    
    
    
end

