function deformationGIF(fileName, h, Psi, phase_dif, Y, Z, ~, ~, ~, lapse)
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
