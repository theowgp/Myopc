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
            res = zeros(obj.N, 1);

            for i=1:obj.N
                temp1 = 1;
                temp2 = 1;
                for j=1:obj.N
%                         temp1 = temp1*    x(j) ^obj.v(i, j);
%                         temp2 = temp2*    x(j) ^obj.w(i, j);
                        temp1 = temp1*  x(j) ^(obj.gamma(i)*obj.v(i, j));
                        temp2 = temp2*  x(j) ^(obj.beta(i)*obj.w(i, j) );

                end
                res(i) =  temp1/(x(i)^(obj.gamma(i) - 1))  - temp2/(x(i)^(obj.beta(i) - 1));
                
                % include cutoff
                res(i) = obj.cutoff(x(i)) * res(i);
                
                % include cutoff
                if(i==1) 
                    res(i) = res(i)+   u;
                end
            end
        end
        function res = F(obj, x, u)
            res = obj.f(x, u);
            res(obj.N+1) = 0.5 * obj.objective.nu * u^2; 
        end
        
        
        
        function res = cutoff(obj, x)
          res = x*(obj.xmax - x);
%           res = 1;
        end
        function res = dcutoff(obj, x)
          res = obj.xmax - 2*x;
%           res = 0;
        end
        


           
        function res = Gxf(obj, x)
            res = zeros(obj.N, obj.N);
            
            for i = 1:obj.N
                for j = 1:obj.N
                    temp1 = 1;
                    temp2 = 1;
                    for k=1:obj.N
                        if(k~=j)
%                             temp1 = temp1*  x(k)^obj.v(i, k);
%                             temp2 = temp2*  x(k)^obj.w(i, k);
                            temp1 = temp1*  x(k) ^(obj.gamma(i)*obj.v(i, k));
                            temp2 = temp2*  x(k) ^(obj.beta(i)*obj.w(i, k) );
                        end
                    end

                    
                    if i~=j
                        res(i, j) = obj.gamma(i) * obj.v(i, j) * x(j)^(obj.gamma(i) * obj.v(i, j) - 1) * temp1/(x(i)^(obj.gamma(i) - 1))   -   obj.beta(i) * obj.w(i, j) * x(j)^(obj.beta(i) * obj.w(i, j) - 1) * temp2/(x(i)^(obj.beta(i) - 1)); 
                        % include the cutoff
                        res(i, j) = obj.cutoff(x(i)) * res(i, j);
                    else
                        temp3 = 1;
                        temp4 = 1;
                        for k=1:obj.N
                            temp3 = temp3*  x(k) ^(obj.gamma(i)*obj.v(i, k));
                            temp4 = temp4*  x(k) ^(obj.beta(i)*obj.w(i, k) );
                        end
                        part1 = obj.dcutoff(x(i)) * ( temp3/(x(i)^(obj.gamma(i) - 1))  -  temp4/(x(i)^(obj.beta(i) - 1)) );
                        
                        part2 = obj.cutoff(x(i)) * ( (obj.gamma(i)*obj.v(i, i) - obj.gamma(i) + 1) * x(i)^(obj.gamma(i)*obj.v(i, i) - obj.gamma(i)) * temp1  -  (obj.beta(i)*obj.w(i, i) - obj.beta(i) + 1) * x(i)^(obj.beta(i)*obj.w(i, i) - obj.beta(i)) * temp2  );
                        
                        res(i, j) = part1 + part2;
                    end
                end
            end
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

