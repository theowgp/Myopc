function res = normu(u)
[N, n, s] = size(u);

temp = 0;
for i=1:N
    for k=1:n
        temp = temp+    u(i, k, 1)^2;
    end
end
res = sqrt(temp);
end

