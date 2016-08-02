function plotsolution(rk, solu)

[sol, soly] = rk.solve_forward_equation(solu);

N = rk.N;
mesh = rk.grid;

for i=1:N
    plot(mesh.t, sol(i, :));
    hold all
end

end

