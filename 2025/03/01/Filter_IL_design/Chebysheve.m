clc;clear;close all

%% 输入参数：
% ---通带波纹
L_Ar = 0.5;
% ---阻带最小衰减
L_As = 40;
omega_s = 2;

%% 以下参数不需要做修改
% ---计算滤波器阶数
n = ceil(acosh(sqrt((10^(0.1*L_As)-1)/(10^(0.1*L_Ar)-1)))/(acosh(omega_s)));

% ---计算元件值
beta = log(coth(L_Ar/17.37));
gamma = sinh(beta/(2*n));

g = zeros(n+1,1);
g0 = 1;
g(1) = 2/gamma*sin(pi/(2*n));

for i = 2:n
    g(i) = 1/g(i-1)*4*sin((2*i-1)*pi/ ...
        (2*n))*sin((2*i-3)*pi/(2*n))/(gamma^2+(sin((i-1)*pi/n))^2);
end

if mod(n,2)==1
    g(end) = 1;
else
    g(end) = (coth(beta/4))^2;
end

%% 输出
disp(['滤波器阶数：',num2str(n)])
disp(['低通滤波器元件值:'])
disp(['g0','=',num2str(g0)])
for i = 1:n+1
    disp(['g',num2str(i),'=',num2str(g(i))])
end

%% 画图
% ---切比雪夫函数计算
omega1 = (0:0.01:1)';
omega2 = (1.01:0.01:3)';
omega = [omega1;omega2];
T1 = cos(n*acos(omega1));
T2 = cosh(n*acosh(omega2));
T = [T1;T2];
% ---计算k
k = sqrt(10^(L_Ar/10)-1);
% ---计算S21
S21 = 1./(1+k^2.*T.^2);
% ---插损损耗画图
figure(1)
S21_dB = 10*log10(S21);
plot(omega,S21_dB,LineWidth=2)
xlabel('\omega')
ylabel('S21 (dB)')
ylim([-50 0])
set(gca,LineWidth=2,Fontsize=20)