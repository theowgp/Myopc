function [solx, solu] = NCG(rk, objective, mesh, solu, eps, sigma, limitLS, limitA)


g =  rk.g_u(solu);
drct = - g;



kLS = 0;
while  kLS<limitLS
    [step, kA] = DetermineStepSize(rk, objective, mesh, solu, g, drct, sigma, limitA);
%     solu = Project(solu, step, drct);
    solu = solu + step * drct;
    gnext = rk.g_u(solu);
    beta = ComputeBetaK(g, gnext, drct, mesh);
    drct = - gnext + beta*drct;
    g = gnext;
    
    
    
    kLS = kLS+1;
    
    
    
    Gradient = normsolu(g, mesh);
    
    [solx, soly] = rk.solve_forward_equation(solu);
    Phi = objective.phi(solx(:, mesh.n+1));
    
    disp([kLS, kA, Phi, Gradient]); % , s, normsolu(solu, N, d, grid), normsolu(drct, N, d, grid)]);
    
end



end
