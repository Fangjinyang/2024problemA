function predatorPreyModel()
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
    tspan = [0 20];
    R = [0.6, 0.8, 1.0, 1.2, 1.4];

    % Plot results on the same graph
    figure;

    for i = 1:length(R)
        k = min(R(i), 1) / (R(i) + 1);

        % Update parameters
        alpha = 0.1;
        beta = 0.02;
        k1 = 0.5;

        % Solve the system of differential equations
        options = odeset('RelTol', 1e-6, 'AbsTol', 1e-6);
        [t, solution] = ode45(@(t, y) predatorPreyEquations(t, y, k, alpha, beta, k1), tspan, y0, options);

        % Plot the results
        plot(solution(:, 1), solution(:, 2), 'LineWidth', 2, 'DisplayName', sprintf('R = %.2f', R(i)));
        hold on;
    end

    hold off;
    xlabel('Prey Population (Nprey)');
    ylabel('Predator Population (Npred)');
    legend('Location', 'Best');
    grid on;

end
