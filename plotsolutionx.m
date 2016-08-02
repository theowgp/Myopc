function plotsolutionx(sol, mesh, N)

for i=1:N
    plot(mesh.t, sol(i, :), '--');
    hold all
end

end