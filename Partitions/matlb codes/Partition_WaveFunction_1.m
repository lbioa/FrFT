%% Avishy's Partition wave function

clear; clc;
fs=100;   %sampling rate
dx=1/fs;   %sampling interval
X_limits=2;       % bound of signal in time  
x=-X_limits:dx:(X_limits); 
L=length(x);

Z=[1,2,3,4,5,6,7,8,9,10];

for k=1:length(Z)
    f(:,k)=cos(pi*Z(k)*x);
end
pulse=prod(f,2).*rectangularPulse(-1,1,x)';



rgb=[0.5,0,0.5];


[tfr, t, f] = tfrwv(pulse); % This function requires fftshift(real(tfr),1)
                            % and yeilds better results than wv() which is
                            % written almost the same.

wigner = fftshift(real(tfr),1);


a=0:0.01:4;
for k=1:length(a)
   
   alpha=a(k)*90;
   figure1 = figure;clf;
   
   projection1=abs( frft(pulse, a(k)) );
   projection2=abs( frft(pulse, a(k)+1) );
  
    % main plot
    axes1 = axes('Parent',figure1,...
    'Position',[0.0432010343518681 0.247745974955278 0.46931462326817 0.605921288014311]);
    direction = [0 0 1];
    h=mesh(wigner,'Parent',axes1,'edgecolor',rgb);
    hold(axes1,'on');
    zlim([ -10 10])
    xlim([0 401])
    ylim([0 401])
    view([-1.5 22]);
    rotate(h,direction,alpha)
%%%%%%% avishy add on's%%%%%%
camlight left; 
lighting gouraud
whitebg(gcf,'black');
f=gcf;
f.Color='black';
% view(180/35*k,50/35*k+20);

% % %%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    % upper projection
    axes2 = axes('Parent',figure1,...
    'Position',[0.606875355854998 0.631484794275492 0.334659090909091 0.218381037567084]);
    
    box(axes2,'on');
    hold(axes2,'on');
    plot(x,projection1,'Parent',axes2)
    ylim([-1 1.2])
    hold on;
    
for i=1:length(x)
    inten = projection1(i);
    if inten < 10^(-2)
        inten = 0.001;
    elseif  inten > 1
        inten=1;
    end
    plot([x(i),x(i)],[-0.1,-0.5],'color',[1,1,1]*inten);
    
end

% Create xlabel
xlabel('P');

% Create ylabel
ylabel('Intensity of P');

% Create title
title('Marginal of P');
    
    % lower projection
    axes3 = axes('Parent',figure1,...
    'Position',[0.607035490605421 0.275491949910555 0.334509394572029 0.218246869409661]);
    box(axes3,'on');
    
    hold(axes3,'on');
    plot(x,projection2,'Parent',axes3)
    ylim([-1 1.2])
    
for i=1:length(x)
    inten = projection2(i);
    if inten < 10^(-2)
        inten = 0.001;
    elseif  inten > 1
        inten=1;
    end
    plot([x(i),x(i)],[-0.1,-0.5],'color',[1,1,1]*inten);
    
end

% Create xlabel
xlabel('X');

% Create ylabel
ylabel('Intensity of X');

% Create title
title('Marginal of X')
    
    pause(0.05)
%%%%%%%%%%%%%%%%%%%%%%%%%%  for video purpuses  %%%%%%%%%%%%%%%%%%%%%%%%%%
    if k==1
        F(1:10) = getframe(gcf); % begin with a few constatnt frames
    elseif k == length(x)
        F(k+10:k+30) = getframe(gcf); % end with a few constatnt frames
    end
    F(k+10)=getframe(gcf);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    


    
    if k~=length(a) && k~=1
        close(figure1)
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%  for video purpuses  %%%%%%%%%%%%%%%%%%%%%%%%%%
video = VideoWriter('Partition_wigner');
video.FrameRate = 20;
open(video)
writeVideo(video,F);
close(video)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

