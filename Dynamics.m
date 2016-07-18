classdef Dynamics
       
    properties
        N;
        
        v;
        w;
        
        v1;
        w1;

        
        omegav;
        deltav;
        
        omegaw;
        deltaw;
        
        lambda;
        
        xmax;
    end
    
    
    
    
    
    
    methods
        
        function obj = Dynamics(N, v, w, v1, w1, lambda, xmax)
            obj.N = N;
            obj.v = v;
            obj.w = w;
            obj.v1 = v1;
            obj.w1 = w1;
            obj.lambda = lambda;
            obj.xmax = xmax;
            
%             %only for 3 dim case
%             obj.omegav = 2;
%             obj.omegaw = 2;
%             
%             %only for 3 dim case
%             obj.deltav = obj.calculatedelta(v);
%             obj.deltaw = obj.calculatedelta(w);
        end
        
        %only for 3 dim case
%         function res = calculatedelta(obj, u)
%             if(obj.N~=3)
%                 display('Only 3dim case!!!!');
%             else
%                 temp = zeros(1, obj.N);
%                 for i = 1:obj.N
%                     temp(i) = min([ abs(1-u(i,1)), u(i, 2), u(i, 1), abs(1-u(i, 2))]);
%                 end
%                 res = min(temp);
%             end
%         end
        
        function res = f(obj, t, x)
        
        res = zeros(obj.N, 1);
        
        for i=1:obj.N
            temp1 = 1;
            temp2 = 1;
            for j=1:obj.N
%                 if(j~=i)
%                     temp1 = temp1* (x(j)/x(i)) ^obj.v(i, j);
%                     temp2 = temp2* (x(j)/x(i)) ^obj.w(i, j);
%                     temp1 = temp1* (abs(x(j)/x(i))) ^obj.v(i, j);
%                     temp2 = temp2* (abs(x(j)/x(i))) ^obj.w(i, j);
                    temp1 = temp1* x(j) ^obj.v(i, j);
                    temp2 = temp2* x(j) ^obj.w(i, j);
                      % only for 3 dim case
%                     temp1 = temp1* x(j) ^obj.V(i, j, t);
%                     temp2 = temp2* x(j) ^obj.W(i, j, t);
%                     temp1 = temp1* abs(x(j)) ^obj.v(i, j);
%                     temp2 = temp2* abs(x(j)) ^obj.w(i, j);
                    
%                 end
            end
%             res(i) = obj.mu(i, t) * x(i) * obj.phi(x(i)) * (temp1 - temp2);
            res(i) = obj.mu(i, t) * obj.phi(x(i)) * (temp1 - temp2);

%             %Marco new system
%             tempm = 0;
%             for j=1:obj.N
%                 tempm = tempm + (obj.w(i, j) - obj.v(i, j))*log(x(j));
%             end
%             res(i) = -tempm*temp1;
%             
        end
        
%         % ACHTUNG here i solve linearized system insted of the system
%         % itself
        res = obj.lf(x);
        end
        
        
        function res = lf(obj, x)
            delta = obj.v - obj.w;
            res = delta * x;
        end

 
        
        
        
        
        
        function res = phi(obj, x)

%         res = sqrt(1 - x^2);
%         res = sqrt(abs(1 - x^2));
%           res = sqrt(x*(obj.xmax - x));
          res = 1;
%           res = x*(obj.xmax - x);

        end
        

%         % only for 3 dim case
%         function res = V(obj, i, j, t)
%             res = obj.v(i, j);
%             
%             if j == 1
%                 res = res + obj.deltav*sin(obj.omegav*t);
%             end
%             if j == 2
%                 res = res - obj.deltav*sin(obj.omegav*t);
%             end
%         end
%         % only for 3 dim case
%         function res = W(obj, i, j, t)
%             res = obj.w(i, j);
%             
%             if j == 1
%                 res = res + obj.deltaw*sin(obj.omegaw*t);
%             end
%             if j == 2
%                 res = res - obj.deltaw*sin(obj.omegaw*t);
%             end
%         end
        
        
        function res = V(obj, i, j, t)
            res = obj.lambda(t)*obj.v(i, j) + (1-obj.lambda(t))*obj.v1(i, j);
%             res = obj.lambda(t)*obj.v1(i, j) + (1-obj.lambda(t))*obj.v(i, j);
            
            
        end
        function res = W(obj, i, j, t)
            res = obj.lambda(t)*obj.w(i, j) + (1-obj.lambda(t))*obj.w1(i, j);
%             res = obj.lambda(t)*obj.w1(i, j) + (1-obj.lambda(t))*obj.w(i, j);
        end
        
        
               
        
        
    end
    
    
    
    
    
   
    
    
    methods(Static)
        
        
        
        
                
        
        function res = mu(i, t)

        res = 1;

        end

        
        
        
        
        
    end
    
end

