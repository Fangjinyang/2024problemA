% Lotka-Volterra model parameters
gamma = 0.3;        % Parameter gamma in the example
R_values = [0.28, 0.78, 1];  % Multiple R values

% Other model parameters
alpha = 0.02;       % Predation rate of predators on prey
zlamprey = 0.5;     % Death rate of lamprey
beta1 = 0.01;       % Reproduction rate of predators
beta2 = 0.05;
zpred = 0.5;        % Death rate of predators
kprey = 0.2;

% Time range
tspan = [0 100];    % Adjust the time range accordingly

% Initial conditions
y0 = [100; 40; 0.5];   % Initial quantities of prey, lamprey, and predators

% Plotting
figure;

for i = 1:length(R_values)
    % Calculate k based on the current R
    R = R_values(i);
    k = gamma * min(R, 1) / (1 + R);
    
    % Call the ode45 function to solve
    [t, y] = ode45(@(t, y) lotka_volterra(t, y, kprey, k, alpha, zlamprey, beta1, beta2, zpred), tspan, y0);

    % Plot the results for the current R value
    subplot(length(R_values), 1, i);
    plot(t, y(:, 1), 'LineWidth', 2, 'DisplayName', 'prey');
    hold on;
    plot(t, y(:, 2), 'LineWidth', 2, 'DisplayName', 'lamprey');
    plot(t, y(:, 3), 'LineWidth', 2, 'DisplayName', 'predator');
    xlabel('Time');
    ylabel('Population Quantity');
    title(['Lotka-Volterra, R = ' num2str(R)]);
    legend();
end

% Lotka-Volterra model function
function dydt = lotka_volterra(t, y, kprey, k, alpha, zlamprey, beta1, beta2, zpred)
    dydt = zeros(3, 1);
    dydt(1) = kprey * y(1) - alpha * y(1) * y(2);
    dydt(2) = (k - zlamprey + beta1 * y(1) - alpha * y(3)) * y(2);
    dydt(3) = beta2 * y(2) * y(3) - zpred * y(3);
end
