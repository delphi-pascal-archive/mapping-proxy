unit StrTools;
interface
uses
  SysUtils, Classes;

function GetToken(aString, SepChar: String; TokenNum: integer):String;
function NumToken(aString, SepChar: String):integer;
function ReplaceSub(str, sub1, sub2: String): String;
function RemoveSub(str, subLeft, subRigth: String;remString: String;var removeCount:integer): String;
function ClearLeft(str,char:string):string; // abcd a=1 abcd >>> a=1 abcd
function ClearRigth(str,char:string):string;// abcd a=1 abc >>> abcd a=1
function GetTokenFromIndex(str,char:string;index:integer):string;// abcd token abcd >>> token
function GetTokenBeforeIndex(str:string;index:integer):string;//1234a567 >>>��� index=5 �������� =  567
implementation
//
function GetToken(aString, SepChar: String; TokenNum: integer):String;
{
���������: aString : ������ ������

SepChar : ������ �������� ������������ ����� ������� (�����������)
TokenNum: ����� ���������� ����� (���������))
result    : ������� ����� ��� ������ ������, ���� ���������� ���� ������ �������� 'TokenNum'
}
var

Token     : String;
StrLen    : integer;
TNum      : integer;
TEnd      : integer;

begin

StrLen := Length(aString);
TNum   := 1;
TEnd   := StrLen;
while ((TNum <= TokenNum) and (TEnd <> 0)) do
begin
TEnd := Pos(SepChar,aString);
if TEnd <> 0 then
begin
if TokenNum>1 then begin
Token := Copy(aString,Length(SepChar),TEnd-1);
Delete(aString,1,Length(SepChar)+TEnd-1);
Inc(TNum);
end else begin
Token := Copy(aString,1,TEnd-1);
Delete(aString,1,TEnd);
Inc(TNum);
end;
end
else
begin
Token := aString;
end;
end;
if TNum >= TokenNum then
begin
result := Token;
end
else
begin
result := '';
end;
end;

function NumToken(aString, SepChar: String):integer;
{
parameters: aString : ������ ������

SepChar : ������������ ������, ��������
������������ ����� ������� (�����������)
result    : ���������� ��������� ���� (��������)
}

var

RChar     : Char;
StrLen    : integer;
TNum      : integer;
TEnd      : integer;

begin

if SepChar = '#' then
begin
RChar := '*'
end
else
begin
RChar := '#'
end;
StrLen := Length(aString);
TNum   := 0;
TEnd   := StrLen;
while TEnd <> 0 do
begin
Inc(TNum);
TEnd := Pos(SepChar,aString);
if TEnd <> 0 then
begin
aString[TEnd] := RChar;
end;
end;
Result := TNum;
end;

function ReplaceSub(str, sub1, sub2: String): String;
{
str  - ������������ ������
sub1 - ������ ������� ����� ��������
sub2 - ������ �� ������� ����� �������� sub1
}
var
aPos: Integer;
rslt: String;
begin
aPos := Pos(sub1, str);
rslt := '';
while (aPos <> 0) do begin
rslt := rslt + Copy(str, 1, aPos - 1) + sub2;
Delete(str, 1, aPos + Length(sub1) - 1);
aPos := Pos(sub1, str);
end;
Result := rslt + str;
end; 
//

function ClearLeft(str,char:string):string;
{
str  - ������� ������
char - ������,
}
var
  i:integer;
begin
result:=str;
i:=Length(str);
while i>0 do begin
  if copy(str,i,1)=char then begin
  delete(str,1,i);
  result:=str;
  exit;
  end;
dec(i);
end;
end;

function ClearRigth(str,char:string):string;
{
str  - ������� ������
char - ������,
}
var
  i:integer;
begin
result:=str;
i:=0;
while i<Length(str) do begin
  if copy(str,i,1)=char then begin
  delete(str,i,Length(str)-i);
  result:=str;
  exit;
  end;
inc(i);
end;
end;

function GetTokenFromIndex(str,char:string;index:integer):string;
{
���������� ����� ����������� � char �� ��������
��� ������ ����� ����� ������ ���� �� ����� char
}
var
  i:integer;
  l,//����� ����� ����� �� �������
  r, //������ ����� ����� �� �������
  tmp:string;
begin
result:='';

//�������� ������ ����� ����� �� ������� ��������� �������
i:=index;
while i<Length(str)+1 do begin
 if copy(str,i,1)<>char then r:=r+copy(str,i,1) else break;
inc(i);
end;

//�������� ����� ����� ����� �� ������� ��������� �������
i:=index-1;
while i>0 do begin
  if copy(str,i,1)<>char then tmp:=tmp+copy(str,i,1) else break;
dec(i);
end;

//�������������  dcba >>> abcd
i:=Length(tmp);
while i>0 do begin
l:=l+tmp[i];
dec(i);
end;

result:=l+r;
end;

function GetTokenBeforeIndex(str:string;index:integer):string;
begin
result:=copy(str,index,Length(str)-index);
end;


function RemoveSub(str, subLeft, subRigth: String;remString: String;var removeCount:integer): String;
{
str ������� ������
subLeft ����� ������� ���������
subRigth ������ ������� ����������
remString ������ �� ������� ��������
removeCount - ���������� ���������� ���������/����������/�������� �����

������� �� ��� ��������� � ��� ������, ��������:
remString:='[rem]';
str:=text1 <a>link</a> text2
subLeft:='<a>'
subRigth:='</a>'
result='text1 [rem] text2'
}
var
  lIndex,rIndex,i,y:integer;
  str_:string;
begin
  lIndex:=0;
  rIndex:=0;

  i:=0;
  while i<length(str) do begin
   if copy(str,i,Length(subLeft))=subLeft then
    for y:=i to length(str) do
     if copy(str,y,length(subRigth))=subRigth then begin
      str:=ReplaceSub(str,copy(str,i,y-i+length(subRigth)),remString);
      inc(removeCount);
      break;
      end;
  inc(i);
  end;
  result:=str;
end;

end.
