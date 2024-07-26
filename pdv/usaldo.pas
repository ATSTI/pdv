unit usaldo;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons;

type

  { Tfsaldo }

  Tfsaldo = class(TForm)
    btnSomar: TButton;
    Edit1: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    Edit16: TEdit;
    Edit17: TEdit;
    Edit18: TEdit;
    Edit19: TEdit;
    Edit2: TEdit;
    Edit20: TEdit;
    Edit21: TEdit;
    Edit22: TEdit;
    Edit23: TEdit;
    Edit24: TEdit;
    Edit25: TEdit;
    Edit26: TEdit;
    Edit27: TEdit;
    Edit28: TEdit;
    Edit29: TEdit;
    Edit3: TEdit;
    Edit30: TEdit;
    Edit31: TEdit;
    Edit32: TEdit;
    Edit33: TEdit;
    Edit34: TEdit;
    Edit35: TEdit;
    Edit36: TEdit;
    Edit37: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure btnSomarClick(Sender: TObject);
    procedure Edit10Change(Sender: TObject);
    procedure Edit11Change(Sender: TObject);
    procedure Edit13Change(Sender: TObject);
    procedure Edit14Change(Sender: TObject);
    procedure Edit16Change(Sender: TObject);
    procedure Edit17Change(Sender: TObject);
    procedure Edit19Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit20Change(Sender: TObject);
    procedure Edit22Change(Sender: TObject);
    procedure Edit23Change(Sender: TObject);
    procedure Edit25Change(Sender: TObject);
    procedure Edit26Change(Sender: TObject);
    procedure Edit28Change(Sender: TObject);
    procedure Edit29Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit32Change(Sender: TObject);
    procedure Edit33Change(Sender: TObject);
    procedure Edit35Change(Sender: TObject);
    procedure Edit36Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure Edit7Change(Sender: TObject);
    procedure Edit8Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);


  private

  public

  end;

var
  fsaldo: Tfsaldo;

implementation

{$R *.lfm}

{ Tfsaldo }





procedure Tfsaldo.Edit2Change(Sender: TObject);
begin
  Edit3.Text := FloatToStr( StrToFloat(Edit1.Text) *  StrToFloat(Edit2.Text) );
  btnSomar.Click;
end;

procedure Tfsaldo.Edit32Change(Sender: TObject);
begin
   if(Edit34.Text <> '0') then
   begin
     Edit34.Text := '0';
     Edit23.Text := '0';
   end;
end;

procedure Tfsaldo.Edit33Change(Sender: TObject);
begin
  Edit34.Text := FloatToStr( StrToFloat(Edit32.Text) *  StrToFloat(Edit33.Text) );
  btnSomar.Click;
end;

procedure Tfsaldo.Edit35Change(Sender: TObject);
begin
   if(Edit37.Text <> '0') then
   begin
     Edit37.Text := '0';
     Edit36.Text := '0';
   end;
end;

procedure Tfsaldo.Edit36Change(Sender: TObject);
begin
  Edit37.Text := FloatToStr( StrToFloat(Edit35.Text) *  StrToFloat(Edit36.Text) );
  btnSomar.Click;
end;

procedure Tfsaldo.Edit4Change(Sender: TObject);
begin
   if(Edit6.Text <> '0') then
   begin
     Edit5.Text := '0';
     Edit6.Text := '0';
   end;
end;


procedure Tfsaldo.Edit11Change(Sender: TObject);
begin
  Edit12.Text := FloatToStr( StrToFloat(Edit10.Text) *  StrToFloat(Edit11.Text) );
  btnSomar.Click;
end;

procedure Tfsaldo.Edit13Change(Sender: TObject);
begin
   if(Edit15.Text <> '0') then
   begin
     Edit15.Text := '0';
     Edit14.Text := '0';
   end;
end;


procedure Tfsaldo.btnSomarClick(Sender: TObject);
begin
     Edit31.Text := FloatToStr( StrToFloat(Edit3.Text) +  StrToFloat(Edit6.Text) +
                              StrToFloat(Edit9.Text) +  StrToFloat(Edit12.Text)+
                              StrToFloat(Edit15.Text) + StrToFloat(Edit18.Text) +
                              StrToFloat(Edit21.Text) + StrToFloat(Edit24.Text) +
                              StrToFloat(Edit27.Text) + StrToFloat(Edit30.Text) +
                              StrToFloat(Edit34.Text) + StrToFloat(Edit37.Text)
                              );
end;

procedure Tfsaldo.Edit10Change(Sender: TObject);
begin
   if(Edit12.Text <> '0') then
   begin
     Edit12.Text := '0';
     Edit11.Text := '0';
   end;
end;

procedure Tfsaldo.Edit14Change(Sender: TObject);
begin
  Edit15.Text := FloatToStr( StrToFloat(Edit13.Text) *  StrToFloat(Edit14.Text) );
  btnSomar.Click;
end;

procedure Tfsaldo.Edit16Change(Sender: TObject);
begin
   if(Edit18.Text <> '0') then
   begin
     Edit18.Text := '0';
     Edit17.Text := '0';
   end;
end;

procedure Tfsaldo.Edit17Change(Sender: TObject);
begin
   Edit18.Text := FloatToStr( StrToFloat(Edit16.Text) *  StrToFloat(Edit17.Text) );
   btnSomar.Click;
end;

procedure Tfsaldo.Edit19Change(Sender: TObject);
begin
   if(Edit21.Text <> '0') then
   begin
     Edit21.Text := '0';
     Edit20.Text := '0';
   end;
end;

procedure Tfsaldo.Edit1Change(Sender: TObject);
begin
   if(Edit3.Text <> '0') then
   begin
     Edit3.Text := '0';
     Edit2.Text := '0';
   end;
end;

procedure Tfsaldo.Edit20Change(Sender: TObject);
begin
   Edit21.Text := FloatToStr( StrToFloat(Edit19.Text) *  StrToFloat(Edit20.Text) );
   btnSomar.Click;
end;

procedure Tfsaldo.Edit22Change(Sender: TObject);
begin
   if(Edit24.Text <> '0') then
   begin
     Edit24.Text := '0';
     Edit23.Text := '0';
   end;
end;

procedure Tfsaldo.Edit23Change(Sender: TObject);
begin
   Edit24.Text := FloatToStr( StrToFloat(Edit22.Text) *  StrToFloat(Edit23.Text) );
   btnSomar.Click;
end;

procedure Tfsaldo.Edit25Change(Sender: TObject);
begin
   if(Edit27.Text <> '0') then
   begin
     Edit27.Text := '0';
     Edit26.Text := '0';
   end;
end;

procedure Tfsaldo.Edit26Change(Sender: TObject);
begin
  Edit27.Text := FloatToStr( StrToFloat(Edit25.Text) *  StrToFloat(Edit26.Text) );
  btnSomar.Click;
end;

procedure Tfsaldo.Edit28Change(Sender: TObject);
begin
   if(Edit30.Text <> '0') then
   begin
     Edit30.Text := '0';
     Edit29.Text := '0';
   end;
end;

procedure Tfsaldo.Edit29Change(Sender: TObject);
begin
  Edit30.Text := FloatToStr( StrToFloat(Edit28.Text) *  StrToFloat(Edit29.Text) );
  btnSomar.Click;
end;

procedure Tfsaldo.Edit5Change(Sender: TObject);
begin
  Edit6.Text := FloatToStr( StrToFloat(Edit4.Text) *  StrToFloat(Edit5.Text) );
  btnSomar.Click;
end;

procedure Tfsaldo.Edit7Change(Sender: TObject);
begin
   if(Edit9.Text <> '0') then
   begin
     Edit9.Text := '0';
     Edit8.Text := '0';
   end;
end;

procedure Tfsaldo.Edit8Change(Sender: TObject);
begin
  Edit9.Text := FloatToStr( StrToFloat(Edit7.Text) *  StrToFloat(Edit8.Text) );
  btnSomar.Click;
end;

procedure Tfsaldo.FormCreate(Sender: TObject);
begin
  KeyPreview:=true;
end;

procedure Tfsaldo.FormKeyPress(Sender: TObject; var Key: char);
begin
      if key=#13 then begin
                          SelectNext(ActiveControl as TWinControl,True,True);
                          key:=#0;
                    end;
end;

end.

