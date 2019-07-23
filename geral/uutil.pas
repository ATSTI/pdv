unit uUtil;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

function EAN13(CodigoDeBarras: String): String;
function RemoveAcento(Str: string): string;
function strParaFloat(vlr_st: String): Double;

implementation

function EAN13(CodigoDeBarras: String): String;
var
  nX    : Integer;
  nPeso  : Integer;
  nSoma  : Double;
  nMaior  : Double;
  nDigito : Integer;
Begin
  nPeso := 3;
  nSoma := 0;

  For nX := 12 DownTo 1 do
  Begin
     nSoma := nSoma + StrToInt( CodigoDeBarras[ nX ] ) * nPeso;
     If nPeso = 3 Then
       nPeso := 1
     Else
       nPeso := 3;
  end;
  nMaior      := ( ( Trunc( nSoma / 10 ) + 1 ) * 10 );
  nDigito  := Trunc( nMaior ) - Trunc( nSoma );
  if (nDigito = 10) then
    nDigito := 0;
  result := IntToStr( nDigito );
end;

function RemoveAcento(Str: string): string;
const
ComAcento = 'àâêôûãõáéíóúçüÀÂÊÔÛÃÕÁÉÍÓÚÇÜ';
SemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU';
var
 x: Integer;
begin;
  for x := 1 to Length(Str) do
    if Pos(Str[x],ComAcento) <> 0 then
       Str[x] := SemAcento[Pos(Str[x], ComAcento)];
  Result := Str;
end;

function strParaFloat(vlr_st: String): Double;
var tam: Integer;
  vVlrStr: String;
  vVlr_decimais: String;
begin
  if (Length(vlr_st) > 6) then
  begin
    vVlr_decimais := Copy(vlr_st,pos(',',vlr_st)+1,Length(vlr_st));
    Vlr_st := Copy(vlr_st,0,pos(',',vlr_st)-1);
    if (Length(vlr_st) > 3) then
    begin
      vVlrStr := StringReplace(vlr_st, '.', '', [rfReplaceAll]);
      vlr_st := vVlrStr + ',' + vVlr_decimais;
    end
    else begin
      vlr_st := vlr_st + ',' + vVlr_decimais;
    end;
  end;
  result := StrToFloat(vlr_st);
end;

end.

