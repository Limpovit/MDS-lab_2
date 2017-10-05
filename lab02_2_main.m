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

%=== Завдання #3.1 ===
% Дослідження властивостей простого режекторного фільтру
br = [1 0.618 1];   % коефіцієнти різницевого рівняння 
ar = 1;
n =  512;	% кількість точок, що розраховуються
fs = 200;
figure()
[h, f] = freqz(br, ar, n, fs);
mag = abs(h); 
phase = angle(h)*180/pi;
subplot(3, 1, 1); plot(f, mag), grid on, title('АЧХ'),
xlabel('Frequency'), ylabel('Magnitude'),
subplot(3, 1, 2), plot(f, unwrap(phase)), grid on, title('ФЧХ'),
xlabel('Frequency'), ylabel('Phase'),
% Обчислення нулів фільтру
x = roots(br);
% Карта нулів та полюсів фільтру
subplot(3, 1, 3), zplane(x)

%=== Завдання #3.2 ===
% Фільтрація сигналу ЕКГ (файл ecg2х60.dat) режекторним фільтром
fs = 250;
ecg2x60 = load('ecg2x60.dat');
ecg = ecg2x60;	% сигнал ЕКГ
ecg = detrend(ecg);
ecgf = filter(br, ar, ecg);
t = (0:length(ecg) - 1)/fs;	
figure()
plot(t, ecg), title('Початковий та відфільтрований сигнали'), hold on
plot(t, ecgf, 'k-'), xlim([0 1]),  hold off,
xlabel('t, мс')
ylabel('A, мкВ')

%=== Завдання #4.1 ===
% Дослідження властивостей диференціаторів
% N = 1
fs = 1000;
bd1 = [1 -1];		% коефіцієнти різницевого рівняння 
ad1 = 1;
n = 512	;	 % кількість точок, що розраховуються
figure()
[h,w] = freqz(bd1,ad1,n);
mag = abs(h); 
phase = angle(h)*180/pi;
subplot(2, 1, 1); plot(w/(2*pi)*fs,mag), grid on, title('АЧХ'),
xlabel('Frequency'), ylabel('Magnitude'),
subplot(2, 1, 2), plot(w/(2*pi) *fs,unwrap(phase)), grid on, title('ФЧХ'),
xlabel('Frequency'), ylabel('Phase'),

% N = 2
bd2 = [1 -1]/2;   	% коефіцієнти різницевого рівняння 
ad2 = 1;
n = 512 ;	  % кількість точок, що розраховуються
figure()
[h,w] = freqz(bd2,ad2,n);
mag = abs(h); 
phase = angle(h)*180/pi;
subplot(2, 1, 1); plot(w/(2*pi)*fs,mag), grid on, title('АЧХ'),
xlabel('Frequency'), ylabel('Magnitude'),
subplot(2, 1, 2), plot(w/(2*pi) *fs,unwrap(phase)), grid on, title('ФЧХ'),
xlabel('Frequency'), ylabel('Phase'),


% Побудова передавальних функцій
H1 = filt(bd1, ad1)
H2 = filt(bd2, ad2)





