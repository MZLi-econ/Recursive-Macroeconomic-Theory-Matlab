% 定义协方差矩阵
covx = [0.0274 0.00104; 0.00104 0.00308];

% 计算协方差矩阵的行列式的平方根
cov_det_sqrt = (det(covx))^0.5;

% 计算a的值
a = 0.05 / cov_det_sqrt;

c = [1.07;1.02];
% 定义x的范围
x = 0.9:0.01:1.02; % 这个x的长度是 13

% 计算y1
y1 = a * x; % y1的长度也是 13

% 计算y2_calc，注意这里需要遍历b_values的每一行
y2 = sqrt(covx\([1;1] - y2.*c) * ([1;1] - y2.*c));

% 绘制y1
plot(x, y1, 'r-', 'LineWidth', 2);

% 由于y2_calc的长度是100，我们需要重新定义x的范围以匹配y2_calc的长度
x2 = 0.9:(1.02-0.9)/(length(y2_calc)-1):1.02; % 重新定义x2以匹配y2_calc的长度
hold on;
plot(x2, y2, 'b--', 'LineWidth', 2);

% 添加图形的标题和轴标签
title('Plot of y1 and y2 calculated from b');
xlabel('x');
ylabel('y');

% 添加图例
legend('y1 = a * x', 'y2 = sqrt(b''covx*b)');

% 打开网格
grid on;