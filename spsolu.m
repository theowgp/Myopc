function res = spsolu(u, v, mesh)
[n, s] = size(u);

temp = 0;
for k=1:n
    temp = temp+    u(k, 1) * v(k, 1);
end

res = mesh.h * temp;
end
