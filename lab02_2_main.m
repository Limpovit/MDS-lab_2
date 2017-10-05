function lab02_2_main
%=== Дисципліна: Основи обробки біомедичної інформації ===
%--- Лабораторна робота #2 ФІЛЬТРАЦІЯ БІОСИГНАЛІВ ФІЛЬТРАМИ З СІХ
%
% Використовуйте файли даних: 
% ecg117.dat - сигнал EКГ 
% ecg_2х60.dat - сигнал ЕКГ з мережевою перешкодою частотою 60 Гц
%----------------------------------------------------------

clear, clc, close all
disp('Лабораторна робота #2')
disp('ФІЛЬТРАЦІЯ БІОСИГНАЛІВ ФІЛЬТРАМИ З СІХ')
disp('Виконав: Лимар Віталій, група БМ-462 ІІДС')

%=== Завдання #1.1 ===
% Реалізація фільтру Хеннінга, обчислення АЧХ та ФЧХ
fs = 1000;
b = [1 2 1]/4;  % коефіцієнти різницевого рівняння 
a = 1;
n = 512;    % кількість точок, що розраховуються
[h,w] = freqz(b,a,n);
mag = abs(h); 
phase = angle(h)*180/pi;
figure()
subplot(2, 1, 1); plot(w/(2*pi)*fs,mag), grid on, title('АЧХ'),
xlabel('Frequency'), ylabel('Magnitude'),
subplot(2, 1, 2), plot(w/(2*pi) *fs,unwrap(phase)), grid on, title('ФЧХ'),
xlabel('Frequency'), ylabel('Phase'),

%=== Завдання #1.2 ===
% Обчислення нулів фільтру
disp('Нулі фільтра Хеннінга') 
x = roots(b);
disp(x);

%=== Завдання #1.3 ===
% Фільтрація ЕКГ, файл ecg117.dat
ecg117 = load('ecg117.dat');
fs = 1000;
ecg = ecg117(:, 1);		% сигнал ЕКГ
ecg = detrend(ecg);
ecgf = filter(b, a, ecg);
t = (0:length(ecg) - 1)/fs;
figure()
subplot(2, 1, 1), plot(t, ecg), title('Сигнал ЕКГ'), xlim([1 1.5]),ylabel('A, мкВ')
subplot(2, 1, 2), plot(t, ecgf), title('Фільтрований сигнал ЕКГ'), xlim([1 1.5])
xlabel('t, мс')
ylabel('A, мкВ')

%=== Завдання #2.1 ===
%Реалізація фільтру поліноміального згладжування
fs = 100;
bp = [-3 12 17 12 -3]/35;		% коефіцієнти різницевого рівняння
ap = 1;
n = 512; % кількість точок, що розраховуються
figure()
[h,w] = freqz(bp,ap,n);
mag = abs(h); 
phase = angle(h)*180/pi;
subplot(3, 1, 1); plot(w/(2*pi)*fs,mag), grid on, title('АЧХ'),
xlabel('Frequency'), ylabel('Magnitude'),
subplot(3, 1, 2), plot(w/(2*pi) *fs,unwrap(phase)), grid on, title('ФЧХ'),
xlabel('Frequency'), ylabel('Phase'),
% Обчислення нулів фільтру
x = roots(bp);
% Карта нулів та полюсів фільтру
subplot(3, 1, 3), zplane(x)

%=== Завдання #2.2 ===
%Фільтрація ЕКГ файл ecg117.dat з використанням фільтру 
%поліноміального згладжування
ecgf5 = filter(bp, ap, ecg);
figure()
subplot(2, 1, 1), plot(t, ecg), title('Сигнал ЕКГ'), xlim([1 1.5]),ylabel('A, мкВ')
subplot(2, 1, 2), plot(t, ecgf5), title('Фільтрований сигнал ЕКГ'), xlim([1 1.5])
xlabel('t, мс')
ylabel('A, мкВ')


%=== Завдання #2.3 ===
%Порівняння властивостей згладжування сигналу фільтром Хеннінга 
%і поліноміальним фільтром
figure()
plot(t, ecgf), title('Фільтр Хенінга та поліномінальний фільтр'), hold on
plot(t, ecgf5, 'k-'), title(''), xlim([1 1.25]), hold off,
xlabel('t, мс')
ylabel('A, мкВ')





