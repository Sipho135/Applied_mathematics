function [] = Gravitational_effect_animation()
    % Display parameters
    lapse = 0.01;
    phase_dif = 2*pi:-pi/12:pi/12;

    % Preallocate Psi
    Psi = zeros(31,31);

    % Constants and calculations outside loops
    Theta = logspace(0, log10(12*pi), 865);
    Radius = 12*pi + 1 - Theta;
    U = [log(Radius) .* cos(Theta); log(Radius) .* sin(Theta)];
    Rm = @(Theta)[cos(Theta), -sin(Theta); sin(Theta), cos(Theta)];
    V = Rm(pi) * U;
    [Y, Z] = meshgrid(1:31, 1:31);

    % GIF setup
    h = figure;
    set(h, 'Position', get(0, 'screensize'));
    set(gcf, 'Color', [0 0 0]);
    ax = gca;
    ax.Clipping = 'off';
    
    % Binary system animation
    binarySystemGIF('Binary_system', h, U, V, lapse);

    % Deformation in spacetime after merger
    deformationGIF('Gravitational_effect_animation', h, Psi, phase_dif, Y, Z, U, V, Rm, lapse);
end
