% Define parameters
N0 = 500; % Initial population size
K = 2000;  % Carrying capacity
k0 = 0.15; % Initial k value
t0 = 0;   % Initial time
gamma = 0.5; % Gender impact factor

% Different R values
R_values = [0.6, 0.8, 1, 1.5, 2, 3];

% Time range
t = linspace(0, 100, 1000);

% Plot multiple graphs
figure;
hold on;

for i = 1:length(R_values)
    k = gamma * min(R_values(i), 1) / (1 + R_values(i));
    
    % Calculate N(t)
    Nt = K ./ (1 + ((K/N0 - 1) * exp(-(k - k0) * (t - t0))));
    
    % Plot
    plot(t, Nt, 'LineWidth', 2, 'DisplayName', ['R = ' num2str(R_values(i))]);
end

hold off;

% Set graph properties
title('Population Growth Over Time');
xlabel('Time');
ylabel('Population Size');
legend('show');
grid on;
