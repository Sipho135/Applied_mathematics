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
