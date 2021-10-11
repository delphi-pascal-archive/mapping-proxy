{
 VirEx (c) 19.03.2006

 Пример прокси на основе технологии мип мэппинга,
 с возможностью изменять как входящие так и исходящие данные
}
unit Main;

interface

uses
  windows, messages, graphics, controls, forms, dialogs, stdctrls,
  SysUtils, Classes, IdBaseComponent, IdComponent, IdTCPServer, IdMappedPortTCP,registry,
  ExtCtrls,IdThreadMgr, IdThreadMgrPool, ComCtrls,
  IdTCPConnection;


type
  TForm1 = class(TForm)
  Memo1: TMemo;
  IdMappedPortTCP1 : TIdMappedPortTCP;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Button3: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    StatusBar1: TStatusBar;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure IdMappedPortTCP1OutboundData(AThread: TIdMappedPortThread);
    procedure IdMappedPortTCP1Execute(AThread: TIdMappedPortThread);
  private
  public
  end;

var
  Form1: TForm1;
  in_,out_,all_:integer;//счетчики для информативности :)
  _1,_2,_3,_4,_5:integer;

implementation

uses
StrTools; //свой модуль для замены строк

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
//обнуляем счетчики
in_:=0;
out_:=0;
all_:=0;

_1:=0;
_2:=0;
_3:=0;
_4:=0;
_5:=0;

//создаём бинд (bind) - прослушиваемый порт для клиента прокси
//(можно сделать несколько) 
with IdMappedPortTCP1.Bindings.Add do begin
  IP:=Edit1.Text;
  Port:=strtoint(Edit2.text);
end;

//внешний адрес и порт
IdMappedPortTCP1.MappedHost:=Edit3.Text;
IdMappedPortTCP1.MappedPort:=StrToInt(Edit4.Text);

//включаем-с
IdMappedPortTCP1.Active:=true;

Button1.Enabled:=false;
Button2.Enabled:=true;

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
Memo1.Clear;
_1:=0;
_2:=0;
_3:=0;
_4:=0;
_5:=0;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
IdMappedPortTCP1.Active:=false; //сначало деактивируем
IdMappedPortTCP1.Bindings.Clear;//и затем только убираем бинды

Button1.Enabled:=true;
Button2.Enabled:=false;
end;

procedure TForm1.IdMappedPortTCP1OutboundData(
  AThread: TIdMappedPortThread);
begin
//===============
//приходящие данные
//===============

//переводим все ссылки на адрес прокси
//сработает если не сжато алгоритмом gzip
//AThread.NetData:=ReplaceSub(AThread.NetData,Edit3.Text,Edit1.Text);

//вырезаем ссылки
if CheckBox1.Checked then begin
AThread.NetData:=RemoveSub(AThread.NetData,'<a ','</a>','[link]',_1); //заменяем всю ссылку на надпись, можно и так: '<font color="red">[link]</font>'
AThread.NetData:=RemoveSub(AThread.NetData,'<A ','</A>','[link]',_1);
end;

//вырезаем картинки
if CheckBox2.Checked then begin
AThread.NetData:=RemoveSub(AThread.NetData,'<img ','>','[img]',_2);
AThread.NetData:=RemoveSub(AThread.NetData,'<IMG ','>','[img]',_2);
end;

//вырезаем скрипты и "нескрипты"
if CheckBox3.Checked then begin
AThread.NetData:=RemoveSub(AThread.NetData,'<script ','</script>','[script]',_3);
AThread.NetData:=RemoveSub(AThread.NetData,'<SCRIPT ','</SCRIPT>','[script]',_3);
AThread.NetData:=RemoveSub(AThread.NetData,'<noscript>','</noscript>','[noscript]',_3);
end;

//вырезаем объекты
if CheckBox4.Checked then begin
AThread.NetData:=RemoveSub(AThread.NetData,'<object ','</object>','[object]',_4);
AThread.NetData:=RemoveSub(AThread.NetData,'<OBJECT ','</OBJECT>','[object]',_4);
AThread.NetData:=RemoveSub(AThread.NetData,'<embed ','</embed>','[embed]',_4);
AThread.NetData:=RemoveSub(AThread.NetData,'<EMBED ','</EMBED>','[embed]',_4);
end;

//вырезаем "плавающие" фрэймы
if CheckBox5.Checked then begin
AThread.NetData:=RemoveSub(AThread.NetData,'<iframe ','>','[iframe]',_5);
AThread.NetData:=RemoveSub(AThread.NetData,'<IFRAME ','>','[iframe]',_5);
end;


memo1.Lines.Add('=== in ===');
memo1.Lines.Add(AThread.NetData);

inc(In_,length(AThread.NetData));
StatusBar1.Panels[0].Text:=inttostr(In_);
StatusBar1.Panels[2].Text:=inttostr(in_+Out_);

label1.Caption:=inttostr(_1);
label2.Caption:=inttostr(_2);
label3.Caption:=inttostr(_3);
label4.Caption:=inttostr(_4);
label5.Caption:=inttostr(_5);
end;

procedure TForm1.IdMappedPortTCP1Execute(AThread: TIdMappedPortThread);
begin
//===============
//уходящие данные
//===============
{
пример:
GET /favicon.ico HTTP/1.1
User-Agent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; ru) Opera 8.51
Host: 127.0.0.1
Accept: text/html, application/xml;q=0.9, application/xhtml+xml, image/png, image/jpeg, image/gif, image/x-xbitmap, */*;q=0.1
Accept-Language: ru,en;q=0.9
Accept-Charset: windows-1252, utf-8, utf-16, iso-8859-1;q=0.6, *;q=0.1
Accept-Encoding: deflate, gzip, x-gzip, identity, *;q=0
Referer: http://127.0.0.1/
Connection: Keep-Alive
}

{
чтобы сервак не обнаружил что браузер работает через прокси, заменяем
Host: 127.0.0.1
на
Host: хост_сервака

можно подменить и Referer с:
Referer: http://127.0.0.1/
на
Referer: http://сервака

winconsul.kladovka.net.ru
}

//AThread.NetData:=ReplaceSub(AThread.NetData,'HTTP/1.1','HTTP/1.0');

//меняем заголовок
AThread.NetData:=ReplaceSub(AThread.NetData,'Referer: http://'+Edit1.Text+'/','Referer: http://'+Edit3.Text+'/');
AThread.NetData:=ReplaceSub(AThread.NetData,'Host: '+Edit1.Text,'Host: '+Edit3.Text);

//насильно указываем чтобы сайт присылал нам сжатые gzip методом странички
//если сайт не поддерживает эту фичу то "придёт" обычная страничка
AThread.NetData:=ReplaceSub(AThread.NetData,'Accept-Encoding: deflate, gzip, x-gzip, identity, *;q=0','Accept-Encoding: gzip, x-gzip;');
AThread.NetData:=ReplaceSub(AThread.NetData,'TE: deflate, gzip, chunked, identity, trailers','TE: gzip');

//удаляем в заголовке запроса "картинки" :)
AThread.NetData:=ReplaceSub(AThread.NetData,'image/png, ','');
AThread.NetData:=ReplaceSub(AThread.NetData,'image/jpeg, ','');
AThread.NetData:=ReplaceSub(AThread.NetData,'image/gif, ','');
AThread.NetData:=ReplaceSub(AThread.NetData,'image/x-xbitmap, ','');

memo1.Lines.Add('=== out ===');
memo1.Lines.Add(AThread.NetData);

inc(Out_,length(AThread.NetData));
StatusBar1.Panels[1].Text:=inttostr(Out_);
StatusBar1.Panels[2].Text:=inttostr(in_+Out_);
end;





end.
