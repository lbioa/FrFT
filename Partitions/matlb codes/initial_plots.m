clear; clc;
fs=1000;   %sampling rate
dx=1/fs;   %sampling interval
X_limits=2;       % bound of signal in time  
x=-X_limits:dx:(X_limits); 
L=length(x);

% Z=[2,3,6,8,10];
Z=1:11;
for k=1:length(Z)
    f(:,k)=cos(pi*Z(k)*x);
end
pulse=prod(f,2).*rectangularPulse(-1,1,x)';
clear f;

%%
% figure(2)
[tfr, t, f] = tfrwv(pulse);
mesh(fftshift(abs(tfr),1))
xlabel('x')
ylabel('p')
zlim([ -5 5])
xlim([0 401])
ylim([0 401])
view([-1.5 22]);

%%%%%%% avishy add on's%%%%%%
% camlight left; 
% lighting gouraud
% whitebg(gcf,'black');
% f=gcf;
% f.Color='black';
% % %%%%%%%%%%%%%%%%%%%%%%%%%

%% The FFT
% the normalization here is the same as in the matlab website 
% and is apparently the approriate way to do so
figure(1)
Y=fft(pulse);
P2 = (1/L)*abs(Y);
f = fs*(-(L/2+1):((L/2)+1))/L;
plot(f,fftshift(P2))
xlabel('p/h');
ylabel('\psi (p)');
grid on
%%%%%%%%% half grid is more accurate - like in matlabs example
figure(1)
Y=fft(pulse);
P2 = (1/L)*abs(Y);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = fs*(0:(L/2))/L;
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')
grid on


%% plot diffent wave functions
Z=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21];
pulse=prod(f,2);%.*rectangularPulse(-1,1,x)';
for j=1:length(Z)
    for k=1:j
        f(:,k)=cos(pi*Z(k)*x);
    end
    pulse=prod(f,2);
    plot(x,pulse);
    xlabel('x');
    ylabel('\psi_*(X)')
    str=num2str(j);
    title(['\psi of S_{',str,'}'])
    pause;
    clear f;
end
    
