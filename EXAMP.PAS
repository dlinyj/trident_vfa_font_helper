program CreateWindow;

uses Crt;

const
  WindowWidth = 71; (* Ширина основного окна *)
  WindowHeight = 20; (* Высота основного окна *)

procedure DisableCursor;
begin
  asm
    mov ah, 1
    mov ch, 20h  (* Отключаем курсор, устанавливая CH в 20h *)
    mov cl, 0
    int 10h
  end;
end;

procedure EnableCursor;
begin
  asm
    mov ah, 1
    mov ch, 6  (* Включаем курсор, устанавливая CH в 6 *)
    mov cl, 7
    int 10h
  end;
end;

procedure DrawAsciiTable(WindowX, WindowY: integer);
var
  i: integer; (* Счетчик для цикла *)
  AsciiStart, AsciiEnd: integer; (* Начало и конец таблицы ASCII *)
begin
  (* Выводим таблицу ASCII *)
  AsciiStart := 0;
  AsciiEnd := 255;
  TextBackground(Red);
  TextColor(White);

  (* Выводим таблицу ASCII *)
  for i := AsciiStart to AsciiEnd do
  begin
    GotoXY(WindowX + 4 + ((i - AsciiStart) mod 32) * 2, WindowY + 2 + (i - AsciiStart) div 32);
    Write(Chr(i), ' ');
  end;
end;

procedure DrawWindow;
var
  WindowX, WindowY: integer; (* Координаты верхнего левого угла окна *)
  ScreenWidth, ScreenHeight: integer; (* Ширина и высота экрана *)
  i, j: integer; (* Счетчики для циклов *)
begin
  (* Устанавливаем синий фон и белый текст *)
  TextBackground(Blue);
  TextColor(White);

  (* Очищаем экран *)
  ClrScr;

  (* Получаем ширину и высоту экрана *)
  ScreenWidth := Lo(WindMax) + 1;
  ScreenHeight := Hi(WindMax) + 1;

  (* Вычисляем координаты окна, чтобы оно было по центру экрана *)
  WindowX := (ScreenWidth - WindowWidth) div 2 + 1;
  WindowY := (ScreenHeight - WindowHeight) div 2 + 1;

  (* Рисуем тень *)
  TextBackground(Black);
  for i := WindowY + 1 to WindowY + WindowHeight do
  begin
    GotoXY(WindowX + WindowWidth, i);
    Write(' ');
  end;
  for i := WindowX + 1 to WindowX + WindowWidth do
  begin
    GotoXY(i, WindowY + WindowHeight);
    Write(' ');
  end;

  (* Рисуем красное окно *)
  TextBackground(Red);
  for i := WindowY to WindowY + WindowHeight - 1 do
  begin
    GotoXY(WindowX, i);
    for j := 1 to WindowWidth do
      Write(' ');
  end;

  (* Рисуем белую рамку внутри окна *)
  TextColor(White);
  GotoXY(WindowX + 1, WindowY + 1);
  Write('╔');
  for i := 1 to WindowWidth - 4 do
    Write('═');
  Write('╗');

  for i := 1 to WindowHeight - 4 do
  begin
    GotoXY(WindowX + 1, WindowY + 1 + i);
    Write('║');
    GotoXY(WindowX + WindowWidth - 2, WindowY + 1 + i);
    Write('║');
  end;

  GotoXY(WindowX + 1, WindowY + WindowHeight - 2);
  Write('╚');
  for i := 1 to WindowWidth - 4 do
    Write('═');
  Write('╝');

  (* Выводим надпись "Информация" в середине верхней части рамки *)
  (* GotoXY(WindowX + (WindowWidth div 2) - 5, WindowY + 1); *)
  GotoXY(WindowX + (WindowWidth div 2) - 5, WindowY + 1);
  Write(' Информация ');

  (* Выводим надпись "Привет Хабр!" на две строки выше *)
  GotoXY(WindowX + (WindowWidth div 2) - 6, WindowY + (WindowHeight div 2) - 5);
  Write('Привет Хабр!');

  (* Добавляем пустую строку между "Привет Хабр!" и "--==< dlinyj >==--" *)
  GotoXY(WindowX + (WindowWidth div 2) - 6, WindowY + (WindowHeight div 2) - 4);
  Write(' ');

  (* Выводим надпись "--==< dlinyj >==--" на две строки выше *)
  TextBackground(LightGray);
  TextColor(Black);
  GotoXY(WindowX + (WindowWidth div 2) - 8, WindowY + (WindowHeight div 2) - 3);
  Write('--==< dlinyj >==--');

  (* Выводим таблицу ASCII *)
  DrawAsciiTable(WindowX, WindowY + 8);

  (* Отключаем курсор *)
  DisableCursor;

  (* Ждем нажатия клавиши *)
  ReadKey;

  (* Включаем курсор обратно *)
  EnableCursor;
end;

begin
  DrawWindow;
  (* Очищаем экран и возвращаем атрибуты цвета *)
  TextBackground(Black);
  TextColor(White);
  ClrScr;
end.