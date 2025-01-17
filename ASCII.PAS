program AsciiTable;

uses Crt;

const
  TableWidth = 16;
  TableHeight = 16;

  (* ����⠭�� ��� �����ᥩ �⮫�殢 *)
  ColumnLabels: array[0..15] of string = (
    '00', '01', '02', '03', '04', '05', '06', '07',
    '08', '09', '0A', '0B', '0C', '0D', '0E', '0F'
  );

  (* ����⠭�� ��� �����ᥩ ��ப *)
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
  (* ���뢠�� 䠩� ��� ����� *)
  Assign(f, 'ascii_table.txt');
  Rewrite(f);

  (* �뢮��� ������ ��� �⮫�殢 *)
  Write('   ');
  Write(f, '   ');
  for i := 0 to TableWidth - 1 do
  begin
    Write(ColumnLabels[i], ' ');
    Write(f, ColumnLabels[i], ' ');
  end;
  Writeln;
  Writeln(f);

  (* �뢮��� ⠡���� ASCII *)
  for i := 0 to TableHeight - 1 do
  begin
    (* �뢮��� ������� ��� ��ப� *)
    Write(RowLabels[i], ' ');
    Write(f, RowLabels[i], ' ');

    (* �뢮��� ᨬ���� ⠡���� *)
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

  (* ����뢠�� 䠩� *)
  Close(f);
end;

begin
  (* ��⠭�������� ���� 䮭 � ���� ⥪�� *)
  TextBackground(White);
  TextColor(Black);

  (* ��頥� ��࠭ *)
  ClrScr;

  (* ���㥬 ⠡���� ASCII *)
  DrawAsciiTable;

  (* ���� ������ ������ *)
  ReadKey;

  (* ��頥� ��࠭ � �����頥� ��ਡ��� 梥� *)
  TextBackground(Black);
  TextColor(White);
  ClrScr;
end.