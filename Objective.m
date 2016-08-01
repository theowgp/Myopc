classdef Objective
    
    
    properties
        N;
        
        xT;
        
        
        
        
        %params
        alpha;
        
        nu;
        
    end
    
    methods
        function obj = Objective(N, xT, nu, alpha)
            obj.N = N;
            obj.xT = xT;
            obj.nu = nu;
            obj.alpha = alpha;
        end
        
        
        function res = phi(obj, x)
            res = 0.5 * obj.alpha * (x(1) - obj.xT)^2 + x(obj.N+1);
        end
        
        function res = Gxphi(obj, x)
            res = zeros(obj.N+1, 1);
            res(1) = obj.alpha * (x(1) - obj.xT);
            res(obj.N+1) = 1;
        end
    end
    
end

