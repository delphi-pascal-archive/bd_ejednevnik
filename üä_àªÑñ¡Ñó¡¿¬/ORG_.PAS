{
 ����� ����� ������� ��������� �������� ������ � ����
 ������, ��� ���� ����� ��������, ���� �� ����, ���������������
 �� �������. ���� ���-�� ��������, �� �� ������ ����������
 ���� ����������.
 ������ � ���� ������ � ������ ������ ��������� ��������� �������
 ��������� ����������.
 ����� �� �������, �������� �� ���� Project ������� View Source.
}
unit org_;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, DBTables, StdCtrls, DBCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Table1: TTable;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Query1: TQuery;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Label2: TLabel;
    DBNavigator1: TDBNavigator;
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

  stDay : array[1..7] of string[11] = ('�����������','�����������','�������',
                                       '�����','�������','�������','�������');
  stMonth : array[1..12] of string[8] = ('������','�������','�����',
                                          '������','���','����','����',
                                          '�������','��������','�������',
                                          '������','�������');

implementation

{$R *.dfm}

uses DateUtils;

// ����������� ���� � ���� ������
procedure TForm1.FormActivate(Sender: TObject);
var
  Present: TDateTime;
  Year, Month, Day : Word;
 begin
  Present:= Now; // Now - �������, ���������� ������� ���� � �����
  DecodeDate(Present, Year, Month, Day);
  Label1.Caption := '������� ' + IntToStr(Day)+' '
    + StMonth[Month] + ' '+ IntToStr(Year)+' ����, '+stDay[DayOfWeek(Present)]+'.';
  Form1.Label2.Caption := '������� � �� ��������� ���:';

end;

// ������ �� ������ �������
procedure TForm1.Button2Click(Sender: TObject);
var
    st : string; // �������� �������
begin
    Form1.Label2.Caption := '�������';
    st:= FormatDateTime('dd/mm/yyyy',Now);
    Form1.Query1.SQL[3] := '(Data = '''+st+''')';
    Form1.Query1.Open;
    if form1.Query1.RecordCount <> 0 then
        form1.DataSource1.DataSet := Form1.Query1
    else begin
        ShowMessage('�� ������� �� ����� ��� �� �������������.');
        //form1.DataSource1.DataSet := Table1;
    end;
end;

// ������
procedure TForm1.Button3Click(Sender: TObject);
var
  Present,              // �������
  Tomorrow: TDateTime;  // ������

 begin
  Form1.Label2.Caption := '������';
  Present:= Now; // Now - �������, ���������� ������� ���� � �����
  Tomorrow := IncDay(Present);  // ������

  Form1.Query1.SQL[3] :=
         '(Data = '''+ FormatDateTime('dd/mm/yyyy',Tomorrow)+''')';
  Form1.Query1.Open;
  if form1.Query1.RecordCount <> 0 then
        form1.DataSource1.DataSet := Form1.Query1
    else
        ShowMessage('�� ������ �� ����� ��� �� �������������.');
end;

// �� ���� ������
procedure TForm1.Button4Click(Sender: TObject);
var
  Present: TDateTime;
  EndOfWeek: TDateTime;

 begin
  Form1.Label2.Caption := '�� ���� ������';
  Present:= Now; // Now - �������, ���������� ������� ���� � �����
  EndOfWeek := StartOfAWeek(YearOf(Present),WeekOf(Present)+1);

  Form1.Query1.SQL[3] :=
         '(Data >= '''+ FormatDateTime('dd/mm/yyyy',Present)+''')' +  'and'+
         '(Data <  '''+ FormatDateTime('dd/mm/yyyy',EndOfWeek)+''')';
  Form1.Query1.Open;
  if form1.Query1.RecordCount <> 0 then
        form1.DataSource1.DataSet := Form1.Query1
    else
        ShowMessage('�� ��� ������ �� ����� ��� �� �������������.');
end;

// �� ��������� ������
procedure TForm1.Button1Click(Sender: TObject);
var
  Present: TDateTime;
  d1, d2: TDateTime;

 begin
  Form1.Label2.Caption := '�� ��������� ������';
  Present:= Now; // Now - �������, ���������� ������� ���� � �����
  d1 := StartOfAWeek(YearOf(Present),WeekOf(Present)+1);
  d2 := StartOfAWeek(YearOf(Present),WeekOf(Present)+2);
  Form1.Query1.SQL[3] :=
         '(Data >= '''+ FormatDateTime('dd/mm/yyyy',d1)+''')' +  'and'+
         '(Data <  '''+ FormatDateTime('dd/mm/yyyy',d2)+''')';
  Form1.Query1.Open;
  if form1.Query1.RecordCount <> 0 then
        form1.DataSource1.DataSet := Form1.Query1
    else
        ShowMessage('�� ��������� ������ �� ����� ��� �� �������������.');
end;

// �������� ��� ������
procedure TForm1.Button5Click(Sender: TObject);
begin
        Form1.Label2.Caption := '���, ��� �������� �������';
        DataSource1.DataSet := Table1;
        Table1.Active := True;
      
end;


end.
