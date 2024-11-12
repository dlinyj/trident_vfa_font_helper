program AsciiTable;

uses Crt;

const
  TableWidth = 16;
  TableHeight = 16;

  (* Константы для подписей столбцов *)
  ColumnLabels: array[0..15] of string = (
    '00', '01', '02', '03', '04', '05', '06', '07',
    '08', '09', '0A', '0B', '0C', '0D', '0E', '0F'
  );

  (* Константы для подписей строк *)
  RowLabels: array[0..15] of string = (
    '00', '10', '20', '30', '40', '50', '60', '70',
    '80', '90', 'A0', 'B0', 'C0', 'D0', 'E0', 'F0'
  );

procedure DrawAsciiTable;
var
  i, j: integer;
  f: Text;
  ch: char;
begin
  (* Открываем файл для записи *)
  Assign(f, 'ascii_table.txt');
  Rewrite(f);

  (* Выводим подписи для столбцов *)
  Write('   ');
  Write(f, '   ');
  for i := 0 to TableWidth - 1 do
  begin
    Write(ColumnLabels[i], ' ');
    Write(f, ColumnLabels[i], ' ');
  end;
  Writeln;
  Writeln(f);

  (* Выводим таблицу ASCII *)
  for i := 0 to TableHeight - 1 do
  begin
    (* Выводим подпись для строки *)
    Write(RowLabels[i], ' ');
    Write(f, RowLabels[i], ' ');

    (* Выводим символы таблицы *)
    for j := 0 to TableWidth - 1 do
    begin
      ch := Chr(i * TableWidth + j);
      if (ch = #0) or (ch = #7) or (ch = #8) or (ch = #9) or (ch = #10) or (ch = #13) then
        ch := ' ';
      Write(ch, '  ');
      Write(f, ch, '  ');
    end;
    Writeln;
    Writeln(f);
  end;

  (* Закрываем файл *)
  Close(f);
end;

begin
  (* Устанавливаем белый фон и чёрный текст *)
  TextBackground(White);
  TextColor(Black);

  (* Очищаем экран *)
  ClrScr;

  (* Рисуем таблицу ASCII *)
  DrawAsciiTable;

  (* Ждем нажатия клавиши *)
  ReadKey;

  (* Очищаем экран и возвращаем атрибуты цвета *)
  TextBackground(Black);
  TextColor(White);
  ClrScr;
end.