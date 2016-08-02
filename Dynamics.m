classdef Dynamics
       
    properties
        N;
        
        v;
        w;
        
        vb;
        wb;

        
                
                
        xmax;
        
        objective;
    end
    
    
    
    
    
    
    methods
        
        function obj = Dynamics(N, v, w, vb, wb, xmax, objective)
            obj.N = N;
            obj.v = v;
            obj.w = w;
            obj.vb = vb;
            obj.wb = wb;
            obj.xmax = xmax;
            obj.objective = objective;
            
          
        end
        
       
        
        function res = f(obj, x, u)
            res = zeros(obj.N, 1);

            for i=1:obj.N
                temp1 = 1;
                temp2 = 1;
                for j=1:obj.N
                        temp1 = temp1*  x(j) ^obj.V(i, j, u);
                        temp2 = temp2*  x(j) ^obj.W(i, j, u);
                end
                
                res(i) = temp1 - temp2;
                res(i) = obj.cutoff(x(i)) * res(i);
            end
        end
        function res = F(obj, x, u)
            res = obj.f(x, u);
            res(obj.N+1) = 0.5 * obj.objective.nu * norm(u)^2; 
        end
        
        
        
        function res = cutoff(obj, x)
          res = x*(obj.xmax - x);
%           res = 1;
        end
        function res = dcutoff(obj, x)
          res = obj.xmax - 2*x;
%           res = 0;
        end
        


        function res = V(obj, i, j, u)
            res = u(i)*obj.v(i, j) + (1-u(i))*obj.vb(i, j);
        end
        function res = dV(obj, i, j, u)
            res = obj.v(i, j) - obj.vb(i, j);
        end
        
        function res = W(obj, i, j, u)
            res = u(i)*obj.w(i, j) + (1-u(i))*obj.wb(i, j);
        end
        function res = dW(obj, i, j, u)
            res = obj.w(i, j) - obj.wb(i, j);
        end
        
        
        
        
        
        
        
        function res = Gxf(obj, x, u)
            res = zeros(obj.N, obj.N);
            
            for i = 1:obj.N
                for j = 1:obj.N
                    temp1 = 1;
                    temp2 = 1;
                    for k=1:obj.N
                        if k~=j
                            temp1 = temp1*  x(k) ^obj.V(i, k, u);
                            temp2 = temp2*  x(k) ^obj.W(i, k, u);
                        end
                    end
                    if i~=j
                        res(i, j) = obj.V(i, j, u)*x(j)^(obj.V(i, j, u)-1)*temp1 - obj.W(i, j, u)*x(j)^(obj.W(i, j, u)-1)*temp2;
                        res(i, j) = obj.cutoff(x(i)) * res(i, j);
                    else
                        part1 = obj.V(i, i, u)*x(i)^(obj.V(i, i, u)-1)*temp1 - obj.W(i, i, u)*x(i)^(obj.W(i, i, u)-1)*temp2;
                        part1 = obj.cutoff(x(i)) * part1;
                        
                        part2 = temp1*  x(i) ^obj.V(i, i, u) - temp2*  x(i) ^obj.W(i, i, u);
                        part2 = obj.dcutoff(x(i)) * part2;
                        
                        res(i, j) = part1 + part2;
                    end
                end
            end
                    
        end
        function res = GxF(obj, x, u)
            res = zeros(obj.N+1, obj.N+1);
            res(1:obj.N, 1:obj.N) = obj.Gxf(x, u);
        end
        
        
        
        
        
        function res = Guf(obj, x, u)
            res = zeros(obj.N, obj.N);
            
            for i = 1:obj.N
                temp1 = 0;
                temp2 = 0;
                for l = 1:obj.N
                    temp3 = 1;
                    temp4 = 1;
                    for k=1:obj.N
                        if(k~=l)
                            temp3 = temp3*  x(k)^obj.V(i, k, u);
                            temp4 = temp4*  x(k)^obj.W(i, k, u);
                        end
                    end
                    temp1 = temp1+  log(x(l)) * x(l)^obj.V(i, l, u) * obj.dV(i, l, u) * temp3;
                    temp2 = temp2+  log(x(l)) * x(l)^obj.W(i, l, u) * obj.dW(i, l, u) * temp4;
                end
                res(i, i) = temp1 - temp2;
                res(i, i) = obj.cutoff(x(i)) * res(i, i);
            end
        end
        function res = GuF(obj, x, u)
            res = zeros(obj.N+1, obj.N+1);
            res(1:obj.N, 1:obj.N) = obj.Guf(x, u);
            res(obj.N+1, 1:obj.N) = obj.objective.nu * u(1:obj.N);%ignore the last control component since it is fictional and always has to be zero
        end
        
    
           
        
        
    end
          
   
    
end

