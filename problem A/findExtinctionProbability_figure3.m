function plot_fixed_point_vs_R()

    % Initial value
    x0 = 0; 
    
    % Tolerance for convergence
    tolerance = 1e-8;
    
    % Maximum number of iterations
    max_iterations = 1000;

    % Define the range of R values
    R_values = linspace(0.1, 2, 100);

    % Store the fixed points' results
    fixed_points = zeros(size(R_values));

    % Iterate to calculate fixed points
    for i = 1:length(R_values)
        R = R_values(i);

        % Reset the initial value
        x0 = 0;

        % Iterate to calculate the fixed point
        for iteration = 1:max_iterations
            % Calculate the next value
            x_next = f(x0, R);

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
    title('Extinction Probability vs R');

    % Define the function
    function result = f(x, R)
        alpha = 0.39; %  alpha value
        y1 = 1;      %  y1 value
        y0 = 6;      % y0 value
        s = 0.1266;  %  s value
        m = 100000;   %  m value

        result = alpha + (1 - 2 * y1 / y0 * min(R, 1) / (1 + R)) * (1 - alpha) * x ...
                 + 2 * y1 / y0 * min(R, 1) / (1 + R) * (1 - alpha) * x^(s * m / (2 * (1 - alpha)));
    end

end
