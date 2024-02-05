% Define parameters
N0 = 500; % Initial population size
K = 2000;  % Carrying capacity
k0 = 0.15; % Initial k value
t0 = 0;   % Initial time
gamma = 0.5; % Gender impact factor

% Different R values
R_values = [0.6, 0.8, 1, 1.5, 2];

% Time range
t = linspace(0, 100, 1000);
y1 = 1;
y0 = 6;

% Plot N Element growth
figure;
hold on;

for i = 1:length(R_values)
    k = gamma * min(R_values(i), 1) / (1 + R_values(i));
    
    % Calculate N(t)
    Nt = K ./ (1 + ((K/N0 - 1) * exp(-(k - k0) * (t - t0))));
    Wp = (y1/y0) * Nt / 80 * 0.15;
    
    % Plot
    plot(t, Wp, 'LineWidth', 2, 'DisplayName', ['R = ' num2str(R_values(i))]);
end

hold off;

% Set graph properties
title('N Element Growth Over Time');
xlabel('Time');
ylabel('The Size of N Element (g)');
legend('show');
grid on;

% Plot P Element growth
figure;
hold on;

for i = 1:length(R_values)
    k = gamma * min(R_values(i), 1) / (1 + R_values(i));
    
    % Calculate N(t)
    Nt = K ./ (1 + ((K/N0 - 1) * exp(-(k - k0) * (t - t0))));
    Wn = (y1/y0) * Nt / 80 * 0.93;
    
    % Plot
    plot(t, Wn, 'LineWidth', 2, 'DisplayName', ['R = ' num2str(R_values(i))]);
end

hold off;

% Set graph properties
title('P Element Growth Over Time');
xlabel('Time');
ylabel('The Size of P Element (g)');
legend('show');
grid on;

% Plot Hg Element growth
figure;
hold on;

for i = 1:length(R_values)
    k = gamma * min(R_values(i), 1) / (1 + R_values(i));
   
    % Calculate N(t)
    Nt = K ./ (1 + ((K/N0 - 1) * exp(-(k - k0) * (t - t0))));
    Whg = (y1/y0) * Nt / 80 * 0.012;
    
    % Plot
    plot(t, Whg, 'LineWidth', 2, 'DisplayName', ['R = ' num2str(R_values(i))]);
end

hold off;

% Set graph properties
title('Hg Element Growth Over Time');
xlabel('Time');
ylabel('The Size of Hg Element (ng)');
legend('show');
grid on;
