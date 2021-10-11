// ������� ������ ��������� �����������.
// ����� ��� �������, �������� � ����
// Project ������� View Source.
program org;

uses
  Forms,
  org_ in 'org_.pas' {Form1},
  SysUtils,Dialogs,
  DateUtils,  // ��� ������� � IncDay
  DBTables;   // ��� ������� � Session, AddStandardAlias

{$R *.res}

var
  Present: TDateTime;       // �������
  NextDay: TDateTime;       // ��������� ����
  Year, Month, Day : Word;  // ���, �����, ����

  Query: TQuery; // ������, ��������������
                 // �������� �� (�������)
begin
  Application.Initialize;
  Application.Title := '����������';
  Application.CreateForm(TForm1, Form1);

 { ��������� ��� ������� � ���� ������ ��������� ��
   ����� ������� ��������� � ���������� ������ ��
   ����� ������ ���������.
   ���� ������ ��������� � ��� �� ��������, ���
   � ����������� ���� ���������. ��� ��������,
   � ������� ��������� ����������� ���� ����� ��������
   ����������� � ������� ParamStr. }

 // �������� ���������
 with Session do
 begin
    ConfigMode := cmSession;
    AddStandardAlias('diary',   // ��������� ��
                      ExtractFilePath(ParamStr(0)), // �������
                     'PARADOX');
 end;

 // ��������� ������� ����
  Present:= Now; // Now - �������, ���������� ������� ���� � �����
  DecodeDate(Present, Year, Month, Day);

  case {dof} DayOfWeek(Present) of
    6:   NextDay := IncDay(Present,3);   // �������
    7:   NextDay := IncDay(Present,2);   // ������
    else NextDay := IncDay(Present,1)
  end;

  // ������ � ���� ������: ���� �� ����, ���������������
  // �� ������� � ��������� ���
  Form1.Query1.SQL[3] :=
         '(Data >= '''+ FormatDateTime('dd/mm/yyyy',Present)+''')' +  'and'+
         '(Data <= '''+ FormatDateTime('dd/mm/yyyy',NextDay)+''')';

  try
    Form1.Query1.Open;  // ��������� ������

  except
    on E:EDBEngineError do
        // ������ ��� ���������� ������� �����
        // ���� ������� ���, ��� ����� ���� ������ ���.
        // ���������� ������������ �������
        // ���� ���� ������.
        begin
            MessageDlg('���� ������� ���� ������ �� ������ .'+#13+
            '������� ����� �������.',mtWarning,[mbYes],0);

            Query := TQuery.Create(Form1);
            with Query do
            begin
                // ���������� ������, ��������������
                // �������� ��
                SQL.Add('CREATE TABLE diary (');
                SQL.Add('What CHAR(80),');
                SQL.Add('Data DATE);');

                ExecSQL;
            end;
            // ������� �������
            Form1.Query1.Open; // �������� ������
        end;
  end;


  if Form1.Query1.RecordCount <> 0  // ���� ����, ��������������� �� ��������� ���
    then
        Form1.DataSource1.DataSet := Form1.Query1
    else
        begin
            Form1.DataSource1.DataSet := Form1.Table1;
            Form1.Table1.Open;
            ShowMessage('�� ������� � ��������� ���' +
                        '�� ����� ��� �� �������������.');
        end;

  Application.Run;
end.

