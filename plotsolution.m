function plotsolution(rk, solu)

[solx, soly] = rk.solve_forward_equation(solu);

N = rk.N;
mesh = rk.grid;

for i=1:N
    plot(mesh.t, solx(i, :));
    hold all
end

end

