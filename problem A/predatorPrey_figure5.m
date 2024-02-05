function main()
    % Call the predatorPreyModel function with different values of R
    predatorPreyModel(0.29);
    predatorPreyModel(0.78);
    predatorPreyModel(1);
end

function predatorPreyModel(R)
    % Define the system of differential equations
    function dydt = predatorPreyEquations(t, y, k, alpha, beta, k1)
        Nprey = y(1);
        Npred = y(2);

        dydt = [
            k * Nprey - alpha * Nprey * Npred;
            beta * Nprey * Npred - k1 * Npred;
        ];
    end

    % Initial conditions
    N0 = 25;        % Initial prey population
    Npred0 = 2;     % Initial predator population
    y0 = [N0; Npred0];

    % Time range
    tspan = [0 30];
    
    % Parameters
    k = min(R, 1) / (R + 1);
    alpha = 0.1;
    beta = 0.02;
    k1 = 0.5;

    % Solve the system of differential equations
    options = odeset('RelTol', 1e-6, 'AbsTol', 1e-6);
    [t, solution] = ode45(@(t, y) predatorPreyEquations(t, y, k, alpha, beta, k1), tspan, y0, options);
    c = N0^k1 * exp(-beta * N0) * Npred0^k * exp(-alpha * Npred0);

    % Plot the results
    figure;
    plot(t, solution(:, 1), 'LineWidth', 2, 'DisplayName', 'Prey (Nprey)');
    hold on;
    plot(t, solution(:, 2), 'LineWidth', 2, 'DisplayName', 'Predator (Npred)');
    hold off;
    xlabel('Time');
    ylabel('Population');
    title('Predator-Prey Model');
    legend('Location', 'Best');
    grid on;

    % Display the value of R and equilibrium constant c
    fprintf('R = %.2f\n', R);
    fprintf('Equilibrium constant c = %.4f\n\n', c);
end
