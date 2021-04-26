function [] = Gravitational_effect_animation()
% Display parameters
lapse = 0.001;
%sample_step = 12;
Psi = zeros(31,31);
dt = 1;
h = figure;
set(h,'Position',get(0,'screensize'));
set(gcf,'Color',[0 0 0]);
phase_dif = 2*pi:- pi/12: pi/12;
Amplitude = 12; 
%__________________________________________________________________________
Theta = logspace(0,log10(12*pi),865);
Radius = 12*pi+1-Theta;
U = [log(Radius).*cos(Theta);
    log(Radius).*sin(Theta)];
% Rotation matrix x axis
Rm = @(Theta)[cos(Theta),-sin(Theta);
              sin(Theta),cos(Theta)];
V = Rm(pi)*U;
[Y,Z] = meshgrid(1:31,1:31);
% Display settings
for s = 1:12:865
    hold on;
    plot(U(1,s),U(2,s),'o','Color',[1 0 1],'linewidth',13);
    plot(V(1,s),V(2,s),'o','Color',[0 0 1],'linewidth',13);
    line(U(1,1:s),U(2,1:s),'Color',[1 0 1],'linewidth',1);
    line(V(1,1:s),V(2,1:s),'Color',[0 0 1],'linewidth',1);
    ax = gca; ax.Clipping = 'off';axis off;
    title('Binary system','fontsize',16,'Color',[1 1 1]);
    view(3);camroll(70);zoom(1.8);
    dt =dt+ 1;
    drawnow;
    frame = getframe(h);
    im = frame2im(frame);
    [D,cm] = rgb2ind(im,256);
    % Write to the .gif file
    if s == 1
        imwrite(D,cm,'Binary_system','gif', 'loopcount',Inf,'delaytime',lapse);
    else
        imwrite(D,cm,'Binary_system','gif','writemode','append','delaytime',lapse);
    end
    clf;
end
%merged system
hold on;
ax = gca;
ax.Clipping = 'off';
line(U(1,1:length(Theta)),U(2,1:length(Theta)),'Color',[1 0 1],'linewidth',1);
line(V(1,1:length(Theta)),V(2,1:length(Theta)),'Color',[0 0 1],'linewidth',1);
plot(U(1,s),U(2,s),'o','Color',[1 0 0],'linewidth',26);axis off;
title('Binary system','fontsize',16,'Color',[1 1 1]);
view(3);camroll(50);
[D,cm] = rgb2ind(frame2im(getframe(h)),256);
imwrite(D,cm,'Binary_system','gif','writemode','append','delaytime',2*lapse);
for k = 1:length(phase_dif)    
    for n = -floor(0.5*31):floor(0.5*31)
        u = n + ceil(0.5*31);
        for p = -floor(0.5*31):floor(0.5*31)
            v = p + ceil(0.5*31);
            if strcmp('+','x')
                Theta = angle(p+n*1i) +0.25*pi;
            else
                Theta = angle(p+n*1i);
            end  
            Psi(u,v) =sin(norm([norm([n;p])*cos(Theta),norm([n;p])*sin(Theta)])+phase_dif(1,length(phase_dif)-k+1));  
        end
    end
    mesh(Psi,Y-16,Z-16,Psi), hold on;colormap([1 1 1]);alpha  0;
    %Binary system
    for s = 1:12:865
        plot3(-0.4,0,0,'o','Color',[1 0 0],'linewidth',22), hold on;
    end
    % Features & other settings   
    ax = gca;
    ax.Clipping = 'off';
    set(ax,'Color',[0 0 0]);    
    axis equal;
    title('Deformation in spacetime after merger','FontSize',16,'Color',[1 1 1]), hold on;
    view([60,30]); camdolly(0, 0.05, 0); zoom(1.0);
    drawnow;
    [D,cm] = rgb2ind(frame2im( getframe(h)),256);
    % Write to the .gif file
    if k == 1
        imwrite(D,cm,'Gravitational_effect_animation','gif', 'loopcount',Inf,'delaytime',lapse);
    else
        imwrite(D,cm,'Gravitational_effect_animation','gif','writemode','append','delaytime',lapse);
    end
    clf;
end
end