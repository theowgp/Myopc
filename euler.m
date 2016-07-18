function res = euler(x0, mesh, f)

%initialize result
N = length(x0);
res = zeros(mesh.n + 1, N);

% set initial value
res(1, :) = x0;

for k=1:mesh.n
%     if res(k, :) + mesh.h*f(mesh.t(k), res(k, :))'  >= 0
        res(k+1, :) = res(k, :) + mesh.h*f(mesh.t(k), res(k, :))';
%     else
%         res(k+1, :) = 0;
%     end
        
end





end

