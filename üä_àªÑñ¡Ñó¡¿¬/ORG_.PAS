{
 Сразу после запуска программа посылает запрос к базе
 данных, для того чтобы выяснить, есть ли дела, запланированные
 на сегодня. Если что-то намечено, то на экране появляется
 окно Ежедневник.
 Запрос к базе данных в начале работы программы формирует главная
 процедура приложения.
 Чтобы ее увидеть, выберите из меню Project команду View Source.
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

  stDay : array[1..7] of string[11] = ('воскресенье','понедельник','вторник',
                                       'среда','четверг','пятница','суббота');
  stMonth : array[1..12] of string[8] = ('января','февраля','марта',
                                          'апреля','мая','июня','июля',
                                          'августа','сентября','октября',
                                          'ноября','декабря');

implementation

{$R *.dfm}

uses DateUtils;

// сегодняшняя дата и день недели
procedure TForm1.FormActivate(Sender: TObject);
var
  Present: TDateTime;
  Year, Month, Day : Word;
 begin
  Present:= Now; // Now - функция, возвращает текущую дату и время
  DecodeDate(Present, Year, Month, Day);
  Label1.Caption := 'Сегодня ' + IntToStr(Day)+' '
    + StMonth[Month] + ' '+ IntToStr(Year)+' года, '+stDay[DayOfWeek(Present)]+'.';
  Form1.Label2.Caption := 'Сегодня и на ближайшие дни:';

end;

// щелчок на кнопке Сегодня
procedure TForm1.Button2Click(Sender: TObject);
var
    st : string; // критерий запроса
begin
    Form1.Label2.Caption := 'Сегодня';
    st:= FormatDateTime('dd/mm/yyyy',Now);
    Form1.Query1.SQL[3] := '(Data = '''+st+''')';
    Form1.Query1.Open;
    if form1.Query1.RecordCount <> 0 then
        form1.DataSource1.DataSet := Form1.Query1
    else begin
        ShowMessage('На сегодня ни каких дел не запланировано.');
        //form1.DataSource1.DataSet := Table1;
    end;
end;

// завтра
procedure TForm1.Button3Click(Sender: TObject);
var
  Present,              // сегодня
  Tomorrow: TDateTime;  // завтра

 begin
  Form1.Label2.Caption := 'Завтра';
  Present:= Now; // Now - функция, возвращает текущую дату и время
  Tomorrow := IncDay(Present);  // завтра

  Form1.Query1.SQL[3] :=
         '(Data = '''+ FormatDateTime('dd/mm/yyyy',Tomorrow)+''')';
  Form1.Query1.Open;
  if form1.Query1.RecordCount <> 0 then
        form1.DataSource1.DataSet := Form1.Query1
    else
        ShowMessage('На завтра ни каких дел не запланировано.');
end;

// на этой неделе
procedure TForm1.Button4Click(Sender: TObject);
var
  Present: TDateTime;
  EndOfWeek: TDateTime;

 begin
  Form1.Label2.Caption := 'На этой неделе';
  Present:= Now; // Now - функция, возвращает текущую дату и время
  EndOfWeek := StartOfAWeek(YearOf(Present),WeekOf(Present)+1);

  Form1.Query1.SQL[3] :=
         '(Data >= '''+ FormatDateTime('dd/mm/yyyy',Present)+''')' +  'and'+
         '(Data <  '''+ FormatDateTime('dd/mm/yyyy',EndOfWeek)+''')';
  Form1.Query1.Open;
  if form1.Query1.RecordCount <> 0 then
        form1.DataSource1.DataSet := Form1.Query1
    else
        ShowMessage('На эту неделю ни каких дел не запланировано.');
end;

// на следующей неделе
procedure TForm1.Button1Click(Sender: TObject);
var
  Present: TDateTime;
  d1, d2: TDateTime;

 begin
  Form1.Label2.Caption := 'На следующей неделе';
  Present:= Now; // Now - функция, возвращает текущую дату и время
  d1 := StartOfAWeek(YearOf(Present),WeekOf(Present)+1);
  d2 := StartOfAWeek(YearOf(Present),WeekOf(Present)+2);
  Form1.Query1.SQL[3] :=
         '(Data >= '''+ FormatDateTime('dd/mm/yyyy',d1)+''')' +  'and'+
         '(Data <  '''+ FormatDateTime('dd/mm/yyyy',d2)+''')';
  Form1.Query1.Open;
  if form1.Query1.RecordCount <> 0 then
        form1.DataSource1.DataSet := Form1.Query1
    else
        ShowMessage('На следующую неделю ни каких дел не запланировано.');
end;

// показать все записи
procedure TForm1.Button5Click(Sender: TObject);
begin
        Form1.Label2.Caption := 'Все, что намечено сделать';
        DataSource1.DataSet := Table1;
        Table1.Active := True;
      
end;


end.
