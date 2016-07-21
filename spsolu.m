function res = spsolu(u, v, mesh)
[N, n, s] = size(u);

temp = 0;
for i=1:N
    for k=1:n
        temp = temp+    u(i, k, 1) * v(i, k, 1);
    end
end

res = mesh.h * temp;
end
