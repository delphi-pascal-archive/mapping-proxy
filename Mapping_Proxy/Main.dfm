�
 TFORM1 0y  TPF0TForm1Form1Left� TopxWidthHeight�CaptionMapping ProxyColor	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrder	PositionpoScreenCenterPixelsPerInchx
TextHeight TMemoMemo1LeftTop Width�HeightvAlignalClientLines.Strings6VirEx (c) 19.03.2006 http:// winconsul.kladovka.net.ru _   Демонстрация "мап мэппинга" - переназначения портов.c   listening - хост и порт, который следует указать в браузере.2   destinanion - внешний хост и порт.f   ниже будет указаны приходящие "in" и исходящие "out" пакеты v   которые можно легко изменить в обработчиках событий компонента 7   IdMappedPortTCP (что и сделано в коде). g   Если сервер передаёт страничку кусками ("Transfer-Encoding: chunked")n   либо в сжатом виде то опции по очистке линков, картинок и т.п.>   (clear links, etc) будут работать неверно. 
ScrollBarsssBothTabOrder   TPanelPanel1Left TopvWidth�Height[AlignalBottomTabOrder TButtonButton1LeftTopWidthyHeightCaptionStartTabOrder OnClickButton1Click  TButtonButton2Left� TopWidthyHeightCaptionStopEnabledTabOrderOnClickButton2Click  TButtonButton3LeftTopWidthaHeightCaptionClearTabOrderOnClickButton3Click  
TStatusBar
StatusBar1LeftTop?Width�HeightBiDiModebdLeftToRightBorderWidthPanelsTextinWidth2 TextoutWidth2 TextallWidth2  ParentBiDiModeParentShowHintShowHint	   TPanelPanel2Left Top WidthHeightvAlignalLeftTabOrder TLabelLabel1Left
Top� WidthHeightCaption---  TLabelLabel2Left
Top� WidthHeightCaption---  TLabelLabel3Left
Top
WidthHeightCaption---  TLabelLabel4Left
Top'WidthHeightCaption---  TLabelLabel5Left
TopEWidthHeightCaption---  	TGroupBox	GroupBox1Left
Top
Width� HeightOCaption Listening TabOrder  TEditEdit1Left
TopWidth� HeightTabOrder Text	127.0.0.1  TEditEdit2Left� TopWidth)HeightTabOrderText80   	TGroupBox	GroupBox2Left
TopdWidth� HeightMCaption Destination TabOrder TEditEdit3Left
TopWidth� HeightTabOrder Textdelphisources.ru  TEditEdit4Left� TopWidth)HeightTabOrderText80   	TCheckBox	CheckBox1Left'Top� Width� HeightCaptionclear linksTabOrder  	TCheckBox	CheckBox2Left'Top� Width� HeightCaptionclear imagesTabOrder  	TCheckBox	CheckBox3Left'Top
Width� HeightCaptionclear scriptsTabOrder  	TCheckBox	CheckBox4Left'Top'Width� HeightCaption#clear objects (ActiveX, Flash, etc)TabOrder  	TCheckBox	CheckBox5Left'TopEWidth� HeightCaptionclear iframesTabOrder   TIdMappedPortTCPIdMappedPortTCP1Bindings CommandHandlers DefaultPortPGreeting.NumericCode MaxConnectionReply.NumericCode 	OnExecuteIdMappedPortTCP1ExecuteReplyExceptionCode 
ReplyTexts ReplyUnknownCommand.NumericCode 
MappedPort OnOutboundDataIdMappedPortTCP1OutboundDataLeft� Top�    