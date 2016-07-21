function res = normsolu(u, mesh)
% [N, n, s] = size(u);

% temp = 0;
% for i=1:N
%     for k=1:n
%         temp = temp+    u(i, k, 1)^2;
%     end
% end
% res = sqrt(mesh.h*temp);


res = sqrt(spsolu(u, u, mesh));
end

