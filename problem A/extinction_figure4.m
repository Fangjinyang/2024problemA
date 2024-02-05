function plot_fixed_point_vs_R()

    % Tolerance for convergence
    tolerance = 1e-8;
    
    % Maximum number of iterations
    max_iterations = 1000;

    % Define the range of R values
    R_values = linspace(0.1, 2, 100);

    % Store the fixed points' results
    fixed_points = zeros(size(R_values));

    % Define the range of alpha_coefficient values
    alpha_coefficients = [0.1, 0.2, 0.3, 0.4];

    % Plot graphs for different alpha_coefficient values
    for alpha_coefficient = alpha_coefficients
        % Iterate to calculate fixed points
        for i = 1:length(R_values)
            R = R_values(i);

            % Initial value
            x0 = 0; 

            % Iterate to calculate the fixed point
            for iteration = 1:max_iterations
                % Calculate the next value
                x_next = f(x0, R, alpha_coefficient);

                % Check if the tolerance is met
                if abs(x_next - x0) < tolerance
                    fixed_points(i) = x_next;
                    break;
                end

                % Update the value
                x0 = x_next;
            end
        end

        % Plot the graph
        figure;
        plot(R_values, fixed_points, 'o-', 'LineWidth', 2);
        xlabel('R');
        ylabel('Extinction Probability (x)');
        title(['Extinction Probability vs R for \eta = ', num2str(alpha_coefficient)]);
    end

    % Define the function
    function result = f(x, R, alpha_coefficient)
        % alpha as a function of R
        alpha = alpha_function(R, alpha_coefficient);
        y1 = 1;      % Your y1 value
        y0 = 6;      % Your y0 value
        s = 0.01266;  % Your s value
        m = 100000;   % Your m value

        result = alpha + (1 - 2 * y1 / y0 * min(R, 1) / (1 + R)) * (1 - alpha) * x ...
                 + 2 * y1 / y0 * min(R, 1) / (1 + R) * (1 - alpha) * x^(s * m / (2 * (1 - alpha)));
    end

    % Define alpha as a function of R
    function alpha = alpha_function(R, alpha_coefficient)
        % Define the relationship between alpha and R based on your specific case
        alpha = alpha_coefficient * R + 0.1;
    end

end
