% Lotka-Volterra model parameters
gamma = 0.3;
R_values = [0.28, 0.78, 1];

% Other model parameters
alpha = 0.02;
zlamprey = 0.5;
beta1 = 0.01;
beta2 = 0.05;
zpred = 0.5;
kprey = 0.2;

% Time range
tspan = [0 100];

% Initial conditions
y0 = [100; 40; 6];

% Create a 3D plot
figure;

for i = 1:length(R_values)
    % Calculate k based on the current R
    R = R_values(i);
    k = gamma * min(R, 1) / (1 + R);
    
    % Call the ode45 function to solve
    [t, y] = ode45(@(t, y) lotka_volterra(t, y, kprey, k, alpha, zlamprey, beta1, beta2, zpred), tspan, y0);

    % Plot the 3D dynamics of the populations
    subplot(length(R_values), 1, i);
    plot3(y(:,1), y(:,2), y(:,3), 'LineWidth', 2);
    xlabel('Prey');
    ylabel('Lamprey');
    zlabel('Predator');
    title(['Population Dynamics, R = ' num2str(R)]);
    grid on;
end

% Lotka-Volterra model function
function dydt = lotka_volterra(~, y, kprey, k, alpha, zlamprey, beta1, beta2, zpred)
    dydt = zeros(3, 1);
    dydt(1) = kprey * y(1) - alpha * y(1) * y(2);
    dydt(2) = (k - zlamprey + beta1 * y(1) - alpha * y(3)) * y(2);
    dydt(3) = beta2 * y(2) * y(3) - zpred * y(3);
end
