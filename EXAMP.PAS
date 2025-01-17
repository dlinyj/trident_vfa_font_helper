program CreateWindow;

uses Crt;

const
  WindowWidth = 71; (* ��ਭ� �᭮����� ���� *)
  WindowHeight = 20; (* ���� �᭮����� ���� *)

procedure DisableCursor;
begin
  asm
    mov ah, 1
    mov ch, 20h  (* �⪫�砥� �����, ��⠭������� CH � 20h *)
    mov cl, 0
    int 10h
  end;
end;

procedure EnableCursor;
begin
  asm
    mov ah, 1
    mov ch, 6  (* ����砥� �����, ��⠭������� CH � 6 *)
    mov cl, 7
    int 10h
  end;
end;

procedure DrawAsciiTable(WindowX, WindowY: integer);
var
  i: integer; (* ���稪 ��� 横�� *)
  AsciiStart, AsciiEnd: integer; (* ��砫� � ����� ⠡���� ASCII *)
begin
  (* �뢮��� ⠡���� ASCII *)
  AsciiStart := 0;
  AsciiEnd := 255;
  TextBackground(Red);
  TextColor(White);

  (* �뢮��� ⠡���� ASCII *)
  for i := AsciiStart to AsciiEnd do
  begin
    GotoXY(WindowX + 4 + ((i - AsciiStart) mod 32) * 2, WindowY + 2 + (i - AsciiStart) div 32);
    Write(Chr(i), ' ');
  end;
end;

procedure DrawWindow;
var
  WindowX, WindowY: integer; (* ���न���� ���孥�� ������ 㣫� ���� *)
  ScreenWidth, ScreenHeight: integer; (* ��ਭ� � ���� ��࠭� *)
  i, j: integer; (* ���稪� ��� 横��� *)
begin
  (* ��⠭�������� ᨭ�� 䮭 � ���� ⥪�� *)
  TextBackground(Blue);
  TextColor(White);

  (* ��頥� ��࠭ *)
  ClrScr;

  (* ����砥� �ਭ� � ����� ��࠭� *)
  ScreenWidth := Lo(WindMax) + 1;
  ScreenHeight := Hi(WindMax) + 1;

  (* ����塞 ���न���� ����, �⮡� ��� �뫮 �� 業��� ��࠭� *)
  WindowX := (ScreenWidth - WindowWidth) div 2 + 1;
  WindowY := (ScreenHeight - WindowHeight) div 2 + 1;

  (* ���㥬 ⥭� *)
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

  (* ���㥬 ��᭮� ���� *)
  TextBackground(Red);
  for i := WindowY to WindowY + WindowHeight - 1 do
  begin
    GotoXY(WindowX, i);
    for j := 1 to WindowWidth do
      Write(' ');
  end;

  (* ���㥬 ����� ࠬ�� ����� ���� *)
  TextColor(White);
  GotoXY(WindowX + 1, WindowY + 1);
  Write('�');
  for i := 1 to WindowWidth - 4 do
    Write('�');
  Write('�');

  for i := 1 to WindowHeight - 4 do
  begin
    GotoXY(WindowX + 1, WindowY + 1 + i);
    Write('�');
    GotoXY(WindowX + WindowWidth - 2, WindowY + 1 + i);
    Write('�');
  end;

  GotoXY(WindowX + 1, WindowY + WindowHeight - 2);
  Write('�');
  for i := 1 to WindowWidth - 4 do
    Write('�');
  Write('�');

  (* �뢮��� ������� "���ଠ��" � �।��� ���孥� ��� ࠬ�� *)
  (* GotoXY(WindowX + (WindowWidth div 2) - 5, WindowY + 1); *)
  GotoXY(WindowX + (WindowWidth div 2) - 5, WindowY + 1);
  Write(' ���ଠ�� ');

  (* �뢮��� ������� "�ਢ�� ����!" �� ��� ��ப� ��� *)
  GotoXY(WindowX + (WindowWidth div 2) - 6, WindowY + (WindowHeight div 2) - 5);
  Write('�ਢ�� ����!');

  (* ������塞 ������ ��ப� ����� "�ਢ�� ����!" � "--==< dlinyj >==--" *)
  GotoXY(WindowX + (WindowWidth div 2) - 6, WindowY + (WindowHeight div 2) - 4);
  Write(' ');

  (* �뢮��� ������� "--==< dlinyj >==--" �� ��� ��ப� ��� *)
  TextBackground(LightGray);
  TextColor(Black);
  GotoXY(WindowX + (WindowWidth div 2) - 8, WindowY + (WindowHeight div 2) - 3);
  Write('--==< dlinyj >==--');

  (* �뢮��� ⠡���� ASCII *)
  DrawAsciiTable(WindowX, WindowY + 8);

  (* �⪫�砥� ����� *)
  DisableCursor;

  (* ���� ������ ������ *)
  ReadKey;

  (* ����砥� ����� ���⭮ *)
  EnableCursor;
end;

begin
  DrawWindow;
  (* ��頥� ��࠭ � �����頥� ��ਡ��� 梥� *)
  TextBackground(Black);
  TextColor(White);
  ClrScr;
end.