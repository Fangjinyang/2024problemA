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
y0 = [100; 40; 0.5];   

% Open output file
output_file = fopen('sensitivity_analysis_results.txt', 'w');

for i = 1:length(R_values)
    % Calculate k based on current R
    R = R_values(i);
    k = gamma * min(R, 1) / (1 + R);
    
    % Call ode45 function for solving the system
    [t, y] = ode45(@(t, y) lotka_volterra(t, y, kprey, k, alpha, zlamprey, beta1, beta2, zpred), tspan, y0);
    
    % Jacobian matrix function handle
    Jacobian = @(t, y) [
        kprey - alpha * y(2), -alpha * y(1), 0;
        beta1 * y(2), (k - zlamprey - alpha * y(3)), -alpha * y(2);
        0, beta2 * y(3), -zpred - beta2 * y(2)
    ];

    % Calculate Jacobian matrix at specific time and state
    J = Jacobian(0, y0);

    % Find eigenvalues
    eigenvalues = eig(J);

    % Output eigenvalues to file
    fprintf(output_file, 'Lotka-Volterra, R = %f Jacobian matrix eigenvalues:\n', R);
    fprintf(output_file, '%f\n', eigenvalues);

    % Calculate parameter sensitivity
    sensitivity_matrix = zeros(3, 6);
    for p = 1:6
        % Small change in parameter
        delta = 1e-6;
        params_p = [gamma, alpha, zlamprey, beta1, beta2, zpred];
        params_p(p) = params_p(p) + delta;

        % Calculate new Jacobian matrix
        Jacobian_p = lotka_volterra_jacobian(t, y0, kprey, k, params_p);
        
        % Calculate parameter sensitivity
        sensitivity_matrix(:, p) = (eig(Jacobian_p) - eigenvalues) / delta;
    end

    % Output parameter sensitivity matrix to file
    fprintf(output_file, 'Lotka-Volterra, R = %f parameter sensitivity matrix:\n', R);
    fprintf(output_file, '%f\t%f\t%f\t%f\t%f\t%f\n', sensitivity_matrix');

    fprintf(output_file, '\n');  % Add a blank line to separate results for different R values
end

% Close the output file
fclose(output_file);

% Lotka-Volterra model function
function dydt = lotka_volterra(t, y, kprey, k, alpha, zlamprey, beta1, beta2, zpred)
    dydt = zeros(3, 1);
    dydt(1) = kprey * y(1) - alpha * y(1) * y(2);
    dydt(2) = (k - zlamprey + beta1 * y(1) - alpha * y(3)) * y(2);
    dydt(3) = beta2 * y(2) * y(3) - zpred * y(3);
end

% Function to calculate Jacobian matrix
function J = lotka_volterra_jacobian(t, y, kprey, k, params)
    gamma = params(1);
    alpha = params(2);
    zlamprey = params(3);
    beta1 = params(4);
    beta2 = params(5);
    zpred = params(6);

    J = [
        kprey - alpha * y(2), -alpha * y(1), 0;
        beta1 * y(2), (k - zlamprey - alpha * y(3)), -alpha * y(2);
        0, beta2 * y(3), -zpred - beta2 * y(2)
    ];
end
