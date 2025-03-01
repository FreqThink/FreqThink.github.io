% 求切比雪夫低通原型滤波器元件值代码
% 设定参数
fp = 2.4e9; % 通带截止频率
fs = 4.7e9; % 阻带截止频率
Rp = 0.01; % 通带最大衰减
Rs = 25; % 阻带最小衰减
Z0 = 50; % 输入输出阻抗
% 将频率转换为归一化的弧度频率
wp = 2*pi*fp;
ws = 2*pi*fs;
% 计算参数epsilon的值
epsilon = 10^(Rp/10)-1;
% 计算阶数n
n=ceil(acosh(sqrt((10^(Rs/10)-1)/epsilon))/acosh(ws/wp));%ceil函数进行向上取整
% acosh函数是反cosh函数（反双曲余弦），sqrt函数进行开根号
% 计算g_k,g_(n+1)
% 计算参数beta，gamma
beta = log(coth(Rp/17.37)); % coth()：反双曲余切
gamma = sinh(beta/(2*n));
bk = zeros(1,n); % 初始化bk向量
Qk = zeros(1,n); % 初始化Qk向量
g_k = zeros(1,n); % 初始化g_k向量
% 根据公式计算bk(1)，Qk(1)，g_k(1)
bk(1) = gamma^2+(sin(pi/n))^2;
Qk(1) = sin(pi/(2*n)); % 根据公式赋值
g_k(1) = (2*Qk(1))/gamma;
% 根据公式计算bk(k)，Qk(k)，g_k(k),k=2,3,4...n
for k = 2:n
    bk(k) = gamma^2+sin(k*pi/n)^2;
    Qk(k) = sin((2*k-1)*(pi/(2*n)));
    g_k(k) = (4*Qk(k-1)*Qk(k))/(bk(k-1)*g_k(k-1)); % 根据公式赋值
end
% 判断n是否为奇数
if mod(n, 2) == 1 % 如果是奇数，g_(n+1)等于1
    g_(n+1) = 1;
else % 如果是偶数，g_(n+1)等于th(beta/4)的平方
    g_(n+1) = coth(beta/4)^2;  % coth()：反双曲余切
end
% 显示n, g_k ,g_n的值
disp('n = ')
disp(n);
disp('g_k(1) = ')
disp(g_k(1))
disp('g_k = ')
disp(g_k)
disp('g_(n+1) = ')
disp(g_(n+1))
% 求实际低通滤波器元件值的代码,n为6阶。使用电容输入式。
% 计算C1, C3, C5
C1 = g_k(1)/(wp*Z0); % 根据公式计算
C3 = g_k(3)/(wp*Z0); % 根据公式计算
C5 = g_k(5)/(wp*Z0); % 根据公式计算
% 计算L2, L4, L6
L2 = (g_k(2)*Z0)/wp; % 根据公式计算
L4 = (g_k(4)*Z0)/wp; % 根据公式计算
L6 = (g_k(6)*Z0)/wp; % 根据公式计算
% 显示实际元件值
disp(['C1 = ' num2str(C1) ' F']);
disp(['C3 = ' num2str(C3) ' F']);
disp(['C5 = ' num2str(C5) ' F']);
disp(['L2 = ' num2str(L2) ' H']);
disp(['L4 = ' num2str(L4) ' H']);
disp(['L6 = ' num2str(L6) ' H']);