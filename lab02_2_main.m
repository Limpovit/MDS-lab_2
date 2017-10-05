function lab02_2_main
%=== ���������: ������ ������� ��������� ���������� ===
%--- ����������� ������ #2 Բ�����ֲ� ��������˲� Բ������� � Ѳ�
%
% �������������� ����� �����: 
% ecg117.dat - ������ E�� 
% ecg_2�60.dat - ������ ��� � ��������� ���������� �������� 60 ��
%----------------------------------------------------------

clear, clc, close all
disp('����������� ������ #2')
disp('Բ�����ֲ� ��������˲� Բ������� � Ѳ�')
disp('�������: ����� ³����, ����� ��-462 ����')

%=== �������� #1.1 ===
% ��������� ������� �������, ���������� ��� �� ���
fs = 1000;
b = [1 2 1]/4;  % ����������� ���������� ������� 
a = 1;
n = 512;    % ������� �����, �� ��������������
[h,w] = freqz(b,a,n);
mag = abs(h); 
phase = angle(h)*180/pi;
figure()
subplot(2, 1, 1); plot(w/(2*pi)*fs,mag), grid on, title('���'),
xlabel('Frequency'), ylabel('Magnitude'),
subplot(2, 1, 2), plot(w/(2*pi) *fs,unwrap(phase)), grid on, title('���'),
xlabel('Frequency'), ylabel('Phase'),

%=== �������� #1.2 ===
% ���������� ���� �������
disp('��� ������� �������') 
x = roots(b);
disp(x);

%=== �������� #1.3 ===
% Գ�������� ���, ���� ecg117.dat
ecg117 = load('ecg117.dat');
fs = 1000;
ecg = ecg117(:, 1);		% ������ ���
ecg = detrend(ecg);
ecgf = filter(b, a, ecg);
t = (0:length(ecg) - 1)/fs;
figure()
subplot(2, 1, 1), plot(t, ecg), title('������ ���'), xlim([1 1.5]),ylabel('A, ���')
subplot(2, 1, 2), plot(t, ecgf), title('Գ���������� ������ ���'), xlim([1 1.5])
xlabel('t, ��')
ylabel('A, ���')

%=== �������� #2.1 ===
%��������� ������� ������������� ������������
fs = 100;
bp = [-3 12 17 12 -3]/35;		% ����������� ���������� �������
ap = 1;
n = 512; % ������� �����, �� ��������������
figure()
[h,w] = freqz(bp,ap,n);
mag = abs(h); 
phase = angle(h)*180/pi;
subplot(3, 1, 1); plot(w/(2*pi)*fs,mag), grid on, title('���'),
xlabel('Frequency'), ylabel('Magnitude'),
subplot(3, 1, 2), plot(w/(2*pi) *fs,unwrap(phase)), grid on, title('���'),
xlabel('Frequency'), ylabel('Phase'),
% ���������� ���� �������
x = roots(bp);
% ����� ���� �� ������ �������
subplot(3, 1, 3), zplane(x)

%=== �������� #2.2 ===
%Գ�������� ��� ���� ecg117.dat � ������������� ������� 
%������������� ������������
ecgf5 = filter(bp, ap, ecg);
figure()
subplot(2, 1, 1), plot(t, ecg), title('������ ���'), xlim([1 1.5]),ylabel('A, ���')
subplot(2, 1, 2), plot(t, ecgf5), title('Գ���������� ������ ���'), xlim([1 1.5])
xlabel('t, ��')
ylabel('A, ���')


%=== �������� #2.3 ===
%��������� ������������ ������������ ������� �������� ������� 
%� ������������ ��������
figure()
plot(t, ecgf), title('Գ���� ������ �� ������������� ������'), hold on
plot(t, ecgf5, 'k-'), title(''), xlim([1 1.25]), hold off,
xlabel('t, ��')
ylabel('A, ���')





