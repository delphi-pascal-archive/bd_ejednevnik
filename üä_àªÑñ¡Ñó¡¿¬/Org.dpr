// Главный модуль программы Организатор.
// Чтобы его увидеть, выберите в меню
// Project команду View Source.
program org;

uses
  Forms,
  org_ in 'org_.pas' {Form1},
  SysUtils,Dialogs,
  DateUtils,  // для доступа к IncDay
  DBTables;   // для доступа к Session, AddStandardAlias

{$R *.res}

var
  Present: TDateTime;       // сегодня
  NextDay: TDateTime;       // следующий день
  Year, Month, Day : Word;  // год, месяц, день

  Query: TQuery; // запрос, обеспечивающий
                 // создание БД (таблицы)
begin
  Application.Initialize;
  Application.Title := 'Ежедневник';
  Application.CreateForm(TForm1, Form1);

 { Псевдоним для доступа к базе данных создается во
   время запуска программы и существует только во
   время работы программы.
   База данных находится в том же каталоге, что
   и выполняемый файл программы. Имя каталога,
   в котором находится выполняемый файл можно получить
   обратившись к функции ParamStr. }

 // создадим псевдоним
 with Session do
 begin
    ConfigMode := cmSession;
    AddStandardAlias('diary',   // псевдоним БД
                      ExtractFilePath(ParamStr(0)), // каталог
                     'PARADOX');
 end;

 // определим текущую дату
  Present:= Now; // Now - функция, возвращает текущую дату и время
  DecodeDate(Present, Year, Month, Day);

  case {dof} DayOfWeek(Present) of
    6:   NextDay := IncDay(Present,3);   // пятница
    7:   NextDay := IncDay(Present,2);   // суббта
    else NextDay := IncDay(Present,1)
  end;

  // запрос к базе данных: есть ли дела, запланированные
  // на сегодня и ближайшие дни
  Form1.Query1.SQL[3] :=
         '(Data >= '''+ FormatDateTime('dd/mm/yyyy',Present)+''')' +  'and'+
         '(Data <= '''+ FormatDateTime('dd/mm/yyyy',NextDay)+''')';

  try
    Form1.Query1.Open;  // выполнить запрос

  except
    on E:EDBEngineError do
        // Ошибка при выполнении запроса может
        // быть вызвана тем, что файла базы данных нет.
        // Предложить пользователю создать
        // файл базы данных.
        begin
            MessageDlg('Файл таблицы базы данных не найден .'+#13+
            'Таблица будет создана.',mtWarning,[mbYes],0);

            Query := TQuery.Create(Form1);
            with Query do
            begin
                // сформируем запрос, обеспечивающий
                // создание БД
                SQL.Add('CREATE TABLE diary (');
                SQL.Add('What CHAR(80),');
                SQL.Add('Data DATE);');

                ExecSQL;
            end;
            // таблица создана
            Form1.Query1.Open; // выполним запрос
        end;
  end;


  if Form1.Query1.RecordCount <> 0  // есть дела, запланированные на ближайшие дни
    then
        Form1.DataSource1.DataSet := Form1.Query1
    else
        begin
            Form1.DataSource1.DataSet := Form1.Table1;
            Form1.Table1.Open;
            ShowMessage('На сегодня и ближайшие дни' +
                        'ни каких дел не запланировано.');
        end;

  Application.Run;
end.

