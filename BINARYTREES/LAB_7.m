% term_char_multiple_pf.m
% Terminal voltage vs. current for multiple power factors (lagging & leading)

% Parameters
I = linspace(0, 60, 21);  % Line current range (A)
ea = 277;                  % Internal generated voltage (V)
xs = 1;                    % Synchronous reactance (ohm)
k = sqrt(3);               % Conversion factor for line voltage
power_factors = [0.2, 0.4, 0.6, 0.8];  % Power factors to analyze

% Create figure
figure;
hold on;
grid on;

% Line styles and colors for plotting
line_styles = {'-', '--', ':', '-.'};
colors = ['k', 'b', 'r', 'g'];

% Calculate and plot for each power factor
for i = 1:length(power_factors)
    pf = power_factors(i);
    theta = acos(pf);
    
    % Lagging power factor (positive theta)
    v_lag = sqrt((ea - xs*I*sin(theta)).^2 + (xs*I*cos(theta)).^2) * k;
    
    % Leading power factor (negative theta)
    v_lead = sqrt((ea - xs*I*sin(-theta)).^2 + (xs*I*cos(-theta)).^2) * k;
    
    % Plot lagging and leading cases
    plot(I, v_lag, [colors(i) line_styles{i}], 'LineWidth', 1.5, ...
        'DisplayName', sprintf('Lagging pf=%.1f', pf));
    plot(I, v_lead, [colors(i) line_styles{i}], 'LineWidth', 1.5, ...
        'DisplayName', sprintf('Leading pf=%.1f', pf), 'HandleVisibility', 'off');
end

;

% Formatting
xlabel('Line Current (A)');
ylabel('Terminal Voltage (V)');
title('Terminal Characteristics of Synchronous Generator');
legend('Location', 'southwest');
axis([0 60 300 550]);  % Adjusted y-axis range to better show all curves
hold off;
