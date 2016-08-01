classdef Dynamics
       
    properties
        N;
        
        v;
        w;
        
        gamma;
        beta;
      

        
                
                
        xmax;
        
        objective;
    end
    
    
    
    
    
    
    methods
        
        function obj = Dynamics(N, v, w, gamma, beta, xmax, objective)
            obj.N = N;
            obj.v = v;
            obj.w = w;
            obj.gamma = gamma;
            obj.beta = beta;
            obj.xmax = xmax;
            obj.objective = objective;
            
          
        end
        
       
        
        function res = f(obj, x, u)
            res = ones(obj.N, 1)';
            
            % include controll
            res(1) = res(1)+   u;
        end
        
        function res = F(obj, x, u)
            res = obj.f(x, u);
            res(obj.N+1) = 0.5 * obj.objective.nu * u^2; 
            res = res';
        end
        
        
        
              


           
        function res = Gxf(obj, x)
            res = zeros(obj.N, obj.N);
        end
        
        function res = GxF(obj, x)
            res = zeros(obj.N+1, obj.N+1);
            res(1:obj.N, 1:obj.N) = obj.Gxf(x);
        end
        
        
        
        
        
        function res = Guf(obj)
            res = zeros(obj.N, 1);
            res(1) = 1;            
        end
        
        function res = GuF(obj, u)
            res = zeros(obj.N+1, 1);
            res(1:obj.N) = obj.Guf();
            res(obj.N+1) = obj.objective.nu * u;
        end
        
    
           
        
        
    end
          
   
    
end

