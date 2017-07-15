{******************************************}
{*             TXMLINI 1.082              *}
{*                                        *}
{* Specjalna klasa pozwalaj¹ca na         *}
{* wykorzystywanie plików XML w taki sam  *}
{* sposób i poprzez takie same funkcje    *}
{* jak pliki INI poprzez klasê TIniFile   *}
{*                                        *}
{* (C) by Ktos 2004-2005                  *}
{* mailto: marcin.ktos@gmail.com          *}
{* www: http://www.ktos.prv.pl            *}
{* www2: http://txmlini.sourceforge.net   *}
{* Udostêpnione na licencji GNU GPL       *}
{******************************************}

{******************************************}
{* Changelog:                             *}
{* -------------------------------------- *}
{* 19.09.04 11:52 v. 1.01 [Ktos]          *}
{* - modyfikacje przystosowawcze do .NET  *}
{* - zupe³na zmiana niektórych funkcji    *}
{*   takich jak ValueExist, ReadString    *}
{*   ReadInteger                          *}
{* - dodanie komentarzy w kodzie          *}
{* 19.09.04 15:16 v. 1.02 [Ktos]          *}
{* - zmiana nazwy modu³u na odpowiadaj¹c¹ *}
{*   mojej nowej koncepcji nazewnictwa    *}
{*   (wersja nie rozpowszechniana)        *}
{* - kilka kosmetycznych zmian            *}
{* 20.09.04 17:59 v. 1.03 [Ktos]          *}
{* - dodanie definicji (na razie) funkcji *}
{*   ReadDate, ReadDateTime, ReadFloat,   *}
{*   ReadTime, WriteDate, WriteDateTime,  *}
{*   WriteFloat, WriteTime.               *}
{* - modyfikacja funkcji SectionExist     *}
{* - zmienna Strings, a tak¿e funkcja     *}
{*   SectionIndex przeniesiona do sekcji  *}
{*   private klasy                        *}
{* - stworzenie listy TODO                *}
{* - wykonanie punktu (5) z listy TODO    *}
{* 21.09.04 17:00 v. 1.04 [Ktos]          *}
{* - wykonanie punktu (3) z TODO, punkt   *}
{*   (4) przesuniêty na póxniejszy termin *}
{* - poprawa dzia³ania SectionExist       *}
{* - wykonanie punktów (1) i (2) z TODO   *}
{* - znów brak wspó³pracy z .NET :(       *}
{* 24.09.04 18:09 v. 1.05 [Ktos]          *}
{* - poprawki funkcji ReadSection         *}
{* - poprawki funkcji ReasSections        *}
{* - zmiana parametrów konstruktora       *}
{* - stworzenie klasy wyj¹tku             *}
{* - dodanie funkcji ReadSectionValues    *}
{* 25.09.04 15:37 v.1.06 [Ktos]           *}
{* - dodanie funkcji *BinaryStream        *}
{* - pocz¹tek tworzenia dokumentacji      *}
{* 05.10.04 18:08 v.1.07 [Ktos]           *}
{* - poprawienie b³êdu, który w metodzie  *}
{*   ReadSections powodowa³ pokazywanie   *}
{*   nazw w postaci "<Sekcja>" zamiast po *}
{*   prostu "Sekcja".                     *}
{* - poprawi³em b³ad we FromEnctions      *}
{*   który powodowa³, ¿e nic siê nie po-  *}
{*   kazywa³o... Ale ja jestem g³upi!     *}
{* 13.10.04  20:23 v.1.08-dev1 [Ktos]     *}
{* - pocz¹tki przystosowywania do odczytu *}
{*   danych z plików zapisywanych przez   *}
{*   TXMLINI 2.x (z tagami description)   *}
{* 28.10.04 18:26 v.1.08-dev2 [Ktos]      *}
{* - prawid³owy odczyt stringów z plików  *}
{*   XML zapisanych sposobem TXMLINI 2.x  *}
{* 31.10.04 10:33 v.1.08-rc1 [Ktos]       *}
{* - prawid³owe dzia³anie ReadSections    *}
{*   dla plików TXMLINI 2.x               *}
{* - prawid³owe dzia³anie ReadSection dla *}
{*   plików TXMLINI 2.x oraz EraseSection *}
{* 01.11.04 09:43 v.1.08-rc2 [Ktos]       *}
{* - poprawa b³êdu #1057220:              *}
{*    poprawa funkcji DelSpaces (wiesza³a *}
{*    komputer na 100% pracy procesora)   *}
{* - poprawa funkcji ToEnctions (zwraca³a *}
{*   zawsze pusty wynik)                  *}
{* - dodanie feature requesta #1057618 w  *}
{*   zamian za standardowe dane wpisywane *}
{*   do pliku                             *}
{* 25.11.04 15:42 v.1.08 [Ktos]           *}
{* - poprawienie b³êdu #1069564           *}
{* - poprawienie b³êdu #1069989           *}
{* - modyfikacja Create -> dzia³a w taki  *}
{*   sposób jak w TXMLINi 2 (najpierw     *}
{*   sprawdza istnienie pliku, a potem go *}
{*   ewentualnie otwiera)                 *}
{* 12.12.04 14:10 v.1.081 [Ktos]          *}
{* - poprawienie b³êdu #1083841           *}
{* 28.03.05 18:56 v.1.082 [Ktos]          *}
{* - poprawienie b³êdu #1171959           *}
{******************************************}

{ Numerki poprawianych b³êdów czy dodawanych usprawnieñ w postaci #numer s¹ odpowiednikami numerków na
  Trackerach (Bug tracket i Feature request) projektu na jego stronie na sourceforge }

unit XMLINI;

interface
uses SysUtils, Classes, Controls;

const
  Version = '1.082';

type
  TXMLIni = class(TObject)
    public
      XMLFileName: string;
    private
      Strings: TStringList;
      ShowException: boolean;
      function SectionIndex(Section: string): integer;
      function DelSpaces(S: string): string;
      function ToEnctions(S: string): string;
      function FromEnctions(S: string): string;
    public
      constructor Create(FileName: string; Debug: boolean = FALSE); {$IFDEF CLR} override; {$ENDIF}
      destructor Destroy; override;

      function ReadString(Section, Name, Default: string): string;
      {DONE 5 -oKtos : (1) Przy zapisywaniu stringów dawaæ zamianê znaków specjalnych }
      procedure WriteString(Section, Name, Value: string);
      function ReadInteger(Section, Name: string; Default: longint): longint;
      procedure WriteInteger(Section, Name: string; Value: longint);
      function ReadBool(Section, Name: string; Default: boolean): boolean;
      procedure WriteBool(Section, Name: string; Value: boolean);
      {DONE 4 -oKtos : (2) Uzupe³niæ deklaracje dodanych metod }
      function ReadDate(Section, Name: string; Default: TDate): TDate;
      function ReadDateTime(Section, Name: string; Default: TDateTime): TDateTime;
      function ReadTime(Section, Name: string; Default: TTime): TTime;
      function ReadFloat(Section, Name: string; Default: Double): Double;
      procedure WriteDate(Section, Name: string; Value: TDate);
      procedure WriteDateTime(Section, Name: string; Value: TDateTime);
      procedure WriteTime(Section, Name: string; Value: TTime);
      procedure WriteFloat(Section, Name: string; Value: Double);
      procedure WriteBinaryStream(Section, Name: string; Value: TStream);
      function ReadBinaryStream(Section, Name: string; Value: TStream): integer;
      {DONE 5 -oKtos : (3) Usuwaæ spacje z nazw sekcji }
      procedure AddSection(Section: string);
      procedure ReadSection(Section: string; StringList: TStrings); virtual;
      procedure ReadSections(StringList: TStrings); virtual;
      procedure ReadSectionValues(Section: String; StringList: TStrings); virtual;
      procedure EraseSection(Section: string);
      procedure DeleteKey(Section, Name: string);
      procedure UpdateFile;
      function SectionExist(Section: string): boolean;
      function ValueExist(Section, Name: string): boolean;
  end;

  EXMLIniException = class(Exception) //klasa wyj¹tków XMLINI
  end;

implementation

{ TXMLIni }
{DONE 2 -oKtos : (4) Trzeba siê zastanowiæ nad wykorzystaniem wyj¹tków dla pokazania programiœcie
b³êdów w ewentualnym wykorzystaniu klasy. Prawdopodobnie bêdzie mo¿na to wy³¹czyæ (odpowiednia zmienna
 jako domyœlny parametr DEBUG (domyœlnie false) w konstruktorze klasy - dopiero w wersji 1.1 }

procedure TXMLIni.AddSection(Section: string);
begin
  //dodawanie sekcji (na koñcu pliku)
  Section := DelSpaces(Section);
  Strings.Insert(Strings.Count -1, '  <' + Section + '>');
  Strings.Insert(Strings.Count -1, '  </' + Section + '>');
end;

constructor TXMLIni.Create(FileName: string; Debug: boolean = FALSE);
begin
  {tutaj nast¹pi³o dodanie dla potrzeb Delphi 8 for .NET, w zwyk³ym ta funkcja
  dzia³a³a bez problemu, a tutaj ten konstruktor jest wymagany. ale, ze z tym
  funkcjonuje i w starszych Delphi to nie ma potrzeby stosowac symboli kompilacji
  warunkowej}
  inherited Create;
  XMLFileName := FileName; //zapisywanie nazwy pliku XML
  Strings := TStringList.Create; //tworzenie podstawowego obiektu na ktorym sie pracuje
  ShowException := Debug;
  if FileExists(FileName) then
  begin
    Strings.LoadFromFile(XMLFileName); //ladowanie ewentualnych danych z tego pliku
  end else
  begin
    //jesli wyj¹tek (brak pliku) to dodaj dane do pliku
    //uwaga! Program wspó³pracuje tylko z kodowaniem Windows-1250!
    Strings.Add('<?xml version="1.0" encoding="Windows-1250" ?>');
    Strings.Add('<!-- Generator: TXMLINI 1.x -->');
    Strings.Add('<xmlini>');
    Strings.Add('</xmlini>');
    Strings.SaveToFile(XMLFileName);
    if ShowException then raise EXMLIniException.Create('File not exist. TXMLINI has created a new one.');
  end;
end;

procedure TXMLIni.DeleteKey(Section, Name: string);
var i: integer;
begin
  //kasowanie klucza z danej sekcji
  for i := Strings.IndexOf('  </' + Section + '>') downto Strings.IndexOf('  <' + Section + '>') do
    if Pos('<' + Name + '>', Strings.Strings[i]) = 5 then Strings.Delete(i);
end;

function TXMLIni.DelSpaces(S: string): string;
begin
  while Pos(' ', s) > 0 do
    Delete(S, Pos(' ', s), 1);
  Result := s;
end;

destructor TXMLIni.Destroy;
begin
  //destuktor najpierw saveuje plik, a potem sobie usuwa sam siebie
  Strings.SaveToFile(XMLFileName);
  Strings.Free;
end;

procedure TXMLIni.EraseSection(Section: string);
var i: integer;
begin
  //kasowanie sekcji
  for i := SectionIndex('/' + Section) downto SectionIndex(Section) do
    Strings.Delete(i);
end;

function TXMLIni.FromEnctions(S: string): string;
begin
  //zamiana z encji na normalne znaczki
  s := StringReplace(s, '&amp;', '&', [rfReplaceAll]);
  s := StringReplace(s, '&quot;', '"', [rfReplaceAll]);
  s := StringReplace(s, '&lt;', '<', [rfReplaceAll]);
  s := StringReplace(s, '&gt;', '>', [rfReplaceAll]);
  Result := s;
  { poprawienie b³êdu, ¿e funkcje FromEnctions i ToEnctions by³y zamienione. Podziêkowania dla Grzegorza Sawicza }
end;

function TXMLIni.ReadBinaryStream(Section, Name: string;
  Value: TStream): integer;
var
  Text: string;
  Stream: TMemoryStream;
  Pos: Integer;
begin
  Text := ReadString(Section, Name, '');
  if Text <> '' then
  begin
    if Value is TMemoryStream then
      Stream := TMemoryStream(Value)
    else Stream := TMemoryStream.Create;
    try
      Pos := Stream.Position;
      Stream.SetSize(Stream.Size + Length(Text) div 2);
      HexToBin(PChar(Text), PChar(Integer(Stream.Memory) + Stream.Position), Length(Text) div 2);
      Stream.Position := Pos;
      if Value <> Stream then Value.CopyFrom(Stream, Length(Text) div 2);
      Result := Stream.Size - Pos;
    finally
      if Value <> Stream then Stream.Free;
    end;
  end else Result := 0;
end;

function TXMLIni.ReadBool(Section, Name: string; Default: boolean): boolean;
begin
  //proste rzutowanie typów i mamy zwrot wartosci z integera na boolean
  try
    Result := Boolean(ReadInteger(Section, Name, Integer(Default)));
  except //w wazie wyjatku daj wartosc domyslna
    Result := Default;
    if ShowException then raise EXMLIniException.Create('Error when reading value. Default set as Result');
  end;
end;

function TXMLIni.ReadDate(Section, Name: string; Default: TDate): TDate;
begin
  try
    Result := StrToDate(ReadString(Section, Name, DateToStr(Default)));
  except //w wazie wyjatku daj wartosc domyslna
    Result := Default;
    if ShowException then raise EXMLIniException.Create('Error when reading value. Default set as Result');
  end;
end;

function TXMLIni.ReadDateTime(Section, Name: string;
  Default: TDateTime): TDateTime;
begin
  try
    Result := StrToDateTime(ReadString(Section, Name, DateTimeToStr(Default)));
  except //w wazie wyjatku daj wartosc domyslna
    Result := Default;
    if ShowException then raise EXMLIniException.Create('Error when reading value. Default set as Result');
  end;
end;

function TXMLIni.ReadFloat(Section, Name: string; Default: Double): Double;
begin
  try
    Result := StrToFloat(ReadString(Section, Name, FloatToStr(Default)));
  except //w wazie wyjatku daj wartosc domyslna
    Result := Default;
    if ShowException then raise EXMLIniException.Create('Error when reading value. Default set as Result');
  end;
end;

function TXMLIni.ReadInteger(Section, Name: string; Default: longint): longint;
begin
  //zamiana ze stringa na integera
  try
    Result := StrToInt(ReadString(Section, Name, IntToStr(Default)));
  except //w wazie wyjatku daj wartosc domyslna
    Result := Default;
    if ShowException then raise EXMLIniException.Create('Error when reading value. Default set as Result');
  end;
end;

procedure TXMLIni.ReadSection(Section: string; StringList: TStrings);
var i: integer;
    t: string;
begin
  //zczytywanie wszystkich wartosci z danej sekcji
  for i := SectionIndex('/' + Section) downto SectionIndex(Section) do
    if Pos('<', Strings.Strings[i]) = 5 then
    begin
      t := Copy(Strings.Strings[i], 6, Pos('>', Strings.Strings[i]) -6);
      if Pos(' ', t) > 0 then
        StringList.Add(Copy(t, 0, Pos(' ', t)  - 1))
      else
        StringList.Add(t);
    end;
end;

procedure TXMLIni.ReadSections(StringList: TStrings);
var i: integer;
    t: string;
begin
  //spisywanie wszystkich sekcji w pliku
  for i := 0 to Strings.Count -1 do
  begin
    t := Copy(Strings.Strings[i], 3, Length(Strings.Strings[i]) -3);
    if (Pos('<', t) = 1) and (Pos('/', t) = 0) then
    begin
      Delete(t, 1, 1);
      if Pos(' ', t) > 0 then
        StringList.Add(Copy(t, 0, Pos(' ', t) -1))
      else
        StringList.Add(t);
    end;
  end;
end;

procedure TXMLIni.ReadSectionValues(Section: String; StringList: TStrings);
var i: integer;
begin
  for i := SectionIndex(Section) + 1 to SectionIndex('/' + Section) -1 do
    StringList.Add(Copy(Strings.Strings[i], Pos('>', Strings.Strings[i]) + 1, Pos('</', Strings.Strings[i]) - Pos('>', Strings.Strings[i]) -1));
end;

function TXMLIni.ReadString(Section, Name, Default: string): string;
var i: integer;
begin
  //odczytywanie stringa
  {DONE 5 -oKtos : Tutaj coœ trzeba poprawiæ bo zwraca pusty string }
  Result := Default;
  for i := SectionIndex(Section) to SectionIndex('/' + Section) -1 do
    if (Pos('<' + Name, Strings.Strings[i]) = 5) and
    ((Strings.Strings[i][6+ Length(Name)] = ' ') or
    (Strings.Strings[i][6+ Length(Name)] = '>')) then
      Result := Copy(Strings.Strings[i], Pos('>', Strings.Strings[i]) + 1, Pos('</', Strings.Strings[i]) -Pos('>', Strings.Strings[i]) - 1);
  Result := FromEnctions(Result);
end;

function TXMLIni.ReadTime(Section, Name: string; Default: TTime): TTime;
begin
  try
    Result := StrToTime(ReadString(Section, Name, TimeToStr(Default)));
  except //w wazie wyjatku daj wartosc domyslna
    Result := Default;
  end;
end;

function TXMLIni.SectionExist(Section: string): boolean;
begin
  //sprawdzanie istnienia sekcji
  Result := False;
  if SectionIndex(Section) > -1 then Result := True;
end;

function TXMLIni.SectionIndex(Section: string): integer;
var i, z: integer;
begin
  //pobieranie indeksu danej sekcji (jesli nie ma to zwraca -1)
  Result := -1;
  for i := 0 to Strings.Count -1 do
  begin
    z := Pos('<', Strings.Strings[i]);
    if z = 3 then
    begin
      if (Copy(Strings.Strings[i], z + 1, Length(Section) + 1) = Section + ' ')
        or (Copy(Strings.Strings[i], z + 1, Length(Section) + 1) = Section + '>') then
      begin
        Result := i;
        Exit;
      end;
    end;
  end;

end;

function TXMLIni.ToEnctions(S: string): string;
begin
  //zamiana z normalnych znaczków na encje
  s := StringReplace(s, '&', '&amp;', [rfReplaceAll]);
  s := StringReplace(s, '"', '&quot;', [rfReplaceAll]);
  s := StringReplace(s, '<', '&lt;', [rfReplaceAll]);
  s := StringReplace(s, '>', '&gt;', [rfReplaceAll]);
  Result := s;
end;

procedure TXMLIni.UpdateFile;
begin
  //save i load tuz po sobie aby uaktualnic dane na wszelki wypadek
  Strings.SaveToFile(XMLFileName);
  Strings.LoadFromFile(XMLFileName);
end;

function TXMLIni.ValueExist(Section, Name: string): boolean;
var tmp: TStringList;
begin
  //sprawdzanie istnienia danego klucza (wartoscu)
  //Ktos: modyfikacja funkcji, tak ¿e nareszcie nie wyszukuje poza zadan¹ sekcj¹
  //Ktos: ponowna modyfikacja bo siê okaza³o ¿e poprzednia wersja dzia³a³a do niczego...
  Result := False;
  if SectionIndex(Section) > -1 then
  begin
    tmp := TStringList.Create;
    ReadSection(Section, tmp);
    if Tmp.IndexOf(Name) > -1 then Result := True;
    Tmp.Free;
  end;
end;

procedure TXMLIni.WriteBinaryStream(Section, Name: string; Value: TStream);
var
  Text: string;
  Stream: TMemoryStream;
begin
  SetLength(Text, (Value.Size - Value.Position) * 2);
  if Length(Text) > 0 then
  begin
    if Value is TMemoryStream then
      Stream := TMemoryStream(Value)
    else Stream := TMemoryStream.Create;
    try
      if Stream <> Value then
      begin
        Stream.CopyFrom(Value, Value.Size - Value.Position);
        Stream.Position := 0;
      end;
      BinToHex(PChar(Integer(Stream.Memory) + Stream.Position), PChar(Text),
        Stream.Size - Stream.Position);
    finally
      if Value <> Stream then Stream.Free;
    end;
  end;
  WriteString(Section, Name, Text);
end;

procedure TXMLIni.WriteBool(Section, Name: string; Value: boolean);
begin
  //zapis poprzez rzutowanie na integer
  WriteInteger(Section, Name, Integer(Value));
end;

procedure TXMLIni.WriteDate(Section, Name: string; Value: TDate);
begin
  WriteString(Section, Name, DateToStr(Value));
end;

procedure TXMLIni.WriteDateTime(Section, Name: string; Value: TDateTime);
begin
  WriteString(Section, Name, DateTimeToStr(Value));
end;

procedure TXMLIni.WriteFloat(Section, Name: string; Value: Double);
begin
  WriteString(Section, Name, FloatToStr(Value));
end;

procedure TXMLIni.WriteInteger(Section, Name: string; Value: Integer);
begin
  //zapis poprzez zamiane na stringa
  WriteString(Section, Name, IntToStr(Value));
end;

procedure TXMLIni.WriteString(Section, Name, Value: string);
begin
  //zapis stringa do danego klucza
  if ValueExist(Section, Name) then DeleteKey(Section, Name);
  {DONE 5 -oKtos : (5) Trzeba pamiêtaæ o dodawaniu sekcji, gdyby akurat nie istnia³a! }
  if not SectionExist(Section) then AddSection(Section);
  Name := DelSpaces(Name);
  Value := ToEnctions(Value);
  Strings.Insert(SectionIndex(Section) +1, '    ' + '<' + Name + '>' + Value + '</' + Name + '>');
end;

procedure TXMLIni.WriteTime(Section, Name: string; Value: TTime);
begin
  WriteString(Section, Name, TimeToStr(Value));
end;

end.
