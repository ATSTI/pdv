unit uUtil;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

function EAN13(CodigoDeBarras: String): String;
function RemoveAcento(Str: string): string;

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

end.

