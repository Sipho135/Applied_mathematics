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

function binarySystemGIF(fileName, h, U, V, lapse)
    % Binary system animation
    for s = 1:12:865
        clf;
        hold on;
        plot(U(1,s), U(2,s), 'o', 'Color', [1 0 1], 'linewidth', 13);
        plot(V(1,s), V(2,s), 'o', 'Color', [0 0 1], 'linewidth', 13);
        line(U(1,1:s), U(2,1:s), 'Color', [1 0 1], 'linewidth', 1);
        line(V(1,1:s), V(2,1:s), 'Color', [0 0 1], 'linewidth', 1);
        ax = gca;
        ax.Clipping = 'off';
        axis off;
        title('Binary system', 'fontsize', 16, 'Color', [1 1 1]);
        view(3); camroll(70); zoom(1.8);
        drawnow;
        frame = getframe(h);
        im = frame2im(frame);
        [D, cm] = rgb2ind(im, 256);
        if s == 1
            imwrite(D, cm, fileName, 'gif', 'loopcount', Inf, 'delaytime', lapse);
        else
            imwrite(D, cm, fileName, 'gif', 'writemode', 'append', 'delaytime', lapse);
        end
    end
end

function deformationGIF(fileName, h, Psi, phase_dif, Y, Z, ~ , ~ , ~, lapse)
    % Deformation in spacetime after merger
    for k = 1:length(phase_dif)
        for n = -floor(0.5*31):floor(0.5*31)
            u = n + ceil(0.5*31);
            for p = -floor(0.5*31):floor(0.5*31)
                v = p + ceil(0.5*31);
                if strcmp('+', 'x')
                    Theta = angle(p+n*1i) + 0.25*pi;
                else
                    Theta = angle(p+n*1i);
                end
                Psi(u,v) = sin(norm([norm([n;p])*cos(Theta),norm([n;p])*sin(Theta)])+phase_dif(1,length(phase_dif)-k+1));
            end
        end
        clf;
        mesh(Psi, Y-16, Z-16, Psi), hold on;
        colormap([1 1 1]); alpha  0;
        for s = 1:12:865
            plot3(-0.4, 0, 0, 'o', 'Color', [1 0 0], 'linewidth', 22), hold on;
        end
        ax = gca;
        ax.Clipping = 'off';
        set(ax, 'Color', [0 0 0]);
        axis equal;
        title('Deformation in spacetime after merger', 'FontSize', 16, 'Color', [1 1 1]), hold on;
        view([60, 30]); camdolly(0, 0.05, 0); zoom(1.0);
        drawnow;
        [D, cm] = rgb2ind(frame2im(getframe(h)), 256);
        if k == 1
            imwrite(D, cm, fileName, 'gif', 'loopcount', Inf, 'delaytime', lapse);
        else
            imwrite(D, cm, fileName, 'gif', 'writemode', 'append', 'delaytime', lapse);
        end
    end
end
