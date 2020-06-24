{
This unit has been produced by ws_helper.
  Input unit name : "user_service_intf".
  This unit name  : "user_service_intf".
  Date            : "30/10/2018 08:54:24".
}
unit user_service_intf;
{$IFDEF FPC}
  {$mode objfpc} {$H+}
{$ENDIF}
{$DEFINE WST_RECORD_RTTI}
interface

uses SysUtils, Classes, TypInfo, base_service_intf, service_intf;

const
  sNAME_SPACE = 'urn:UserService';
  sUNIT_NAME = 'user_service_intf';

type

  TUserArray = class;
  TUser = class;
  TNote = class;

  TUserCategory = ( 
    Normal
    ,Admin
  );

  TUser = class(TBaseComplexRemotable)
  private
    FCategory : TUserCategory;
    FUserName : UnicodeString;
    FeMail : UnicodeString;
    FPreferences : UnicodeString;
    FNote : TNote;
  public
    constructor Create();override;
    procedure FreeObjectProperties();override;
  published
    property Category : TUserCategory read FCategory write FCategory;
    property UserName : UnicodeString read FUserName write FUserName;
    property eMail : UnicodeString read FeMail write FeMail;
    property Preferences : UnicodeString read FPreferences write FPreferences;
    property Note : TNote read FNote write FNote;
  end;

  TNote = class(TBaseComplexRemotable)
  private
    FHeader : UnicodeString;
    FAuthor : UnicodeString;
    FDate : UnicodeString;
  published
    property Header : UnicodeString read FHeader write FHeader;
    property Author : UnicodeString read FAuthor write FAuthor;
    property Date : UnicodeString read FDate write FDate;
  end;

  TUserArray = class(TObjectCollectionRemotable)
  private
    function GetItem(AIndex: Integer): TUser;
  public
    class function GetItemClass():TBaseRemotableClass;override;
    function Add(): TUser; {$IFDEF USE_INLINE}inline;{$ENDIF}
    function AddAt(const APosition : Integer) : TUser; {$IFDEF USE_INLINE}inline;{$ENDIF}
    property Item[AIndex:Integer] : TUser Read GetItem;Default;
  end;

  UserService = interface(IInvokable)
    ['{529B0F0D-8880-47B9-9A27-D324F028C0F0}']
    function GetList():TUserArray;
    procedure Add(
      const  AUser : TUser
    );
    procedure Update(
      const  AUser : TUser
    );
    function Find(
      const  AName : UnicodeString
    ):TUser;
    function Delete(
      const  AName : UnicodeString
    ):boolean;
  end;

  procedure Register_user_service_intf_ServiceMetadata();

Implementation
uses metadata_repository, record_rtti, wst_types;

{ TUser }

constructor TUser.Create();
begin
  inherited Create();
  FNote := TNote.Create();
end;

procedure TUser.FreeObjectProperties();
begin
  if Assigned(FNote) then
    FreeAndNil(FNote);
  inherited FreeObjectProperties();
end;

{ TUserArray }

function TUserArray.GetItem(AIndex: Integer): TUser;
begin
  Result := TUser(Inherited GetItem(AIndex));
end;

class function TUserArray.GetItemClass(): TBaseRemotableClass;
begin
  Result:= TUser;
end;

function TUserArray.Add() : TUser;
begin
  Result := TUser(inherited Add());
end;

function TUserArray.AddAt(const APosition : Integer) : TUser;
begin
  Result := TUser(inherited AddAt(APosition));
end;


procedure Register_user_service_intf_ServiceMetadata();
var
  mm : IModuleMetadataMngr;
begin
  mm := GetModuleMetadataMngr();
  mm.SetRepositoryNameSpace(sUNIT_NAME, sNAME_SPACE);
  mm.SetServiceCustomData(
    sUNIT_NAME,
    'UserService',
    'TRANSPORT_Address',
    'http://127.0.0.1:8000/services/UserService'
  );
  mm.SetServiceCustomData(
    sUNIT_NAME,
    'UserService',
    'FORMAT_Style',
    'rpc'
  );
  mm.SetOperationCustomData(
    sUNIT_NAME,
    'UserService',
    'GetList',
    '_E_N_',
    'GetList'
  );
  mm.SetOperationCustomData(
    sUNIT_NAME,
    'UserService',
    'GetList',
    'TRANSPORT_soapAction',
    'urn:UserService/UserServiceGetList'
  );
  mm.SetOperationCustomData(
    sUNIT_NAME,
    'UserService',
    'GetList',
    'FORMAT_Input_EncodingStyle',
    'literal'
  );
  mm.SetOperationCustomData(
    sUNIT_NAME,
    'UserService',
    'GetList',
    'FORMAT_OutputEncodingStyle',
    'literal'
  );
  mm.SetOperationCustomData(
    sUNIT_NAME,
    'UserService',
    'Add',
    '_E_N_',
    'Add'
  );
  mm.SetOperationCustomData(
    sUNIT_NAME,
    'UserService',
    'Add',
    'TRANSPORT_soapAction',
    'urn:UserService/UserServiceAdd'
  );
  mm.SetOperationCustomData(
    sUNIT_NAME,
    'UserService',
    'Add',
    'FORMAT_Input_EncodingStyle',
    'literal'
  );
  mm.SetOperationCustomData(
    sUNIT_NAME,
    'UserService',
    'Add',
    'FORMAT_OutputEncodingStyle',
    'literal'
  );
  mm.SetOperationCustomData(
    sUNIT_NAME,
    'UserService',
    'Update',
    '_E_N_',
    'Update'
  );
  mm.SetOperationCustomData(
    sUNIT_NAME,
    'UserService',
    'Update',
    'TRANSPORT_soapAction',
    'urn:UserService/UserServiceUpdate'
  );
  mm.SetOperationCustomData(
    sUNIT_NAME,
    'UserService',
    'Update',
    'FORMAT_Input_EncodingStyle',
    'literal'
  );
  mm.SetOperationCustomData(
    sUNIT_NAME,
    'UserService',
    'Update',
    'FORMAT_OutputEncodingStyle',
    'literal'
  );
  mm.SetOperationCustomData(
    sUNIT_NAME,
    'UserService',
    'Find',
    '_E_N_',
    'Find'
  );
  mm.SetOperationCustomData(
    sUNIT_NAME,
    'UserService',
    'Find',
    'TRANSPORT_soapAction',
    'urn:UserService/UserServiceFind'
  );
  mm.SetOperationCustomData(
    sUNIT_NAME,
    'UserService',
    'Find',
    'FORMAT_Input_EncodingStyle',
    'literal'
  );
  mm.SetOperationCustomData(
    sUNIT_NAME,
    'UserService',
    'Find',
    'FORMAT_OutputEncodingStyle',
    'literal'
  );
  mm.SetOperationCustomData(
    sUNIT_NAME,
    'UserService',
    'Delete',
    '_E_N_',
    'Delete'
  );
  mm.SetOperationCustomData(
    sUNIT_NAME,
    'UserService',
    'Delete',
    'TRANSPORT_soapAction',
    'urn:UserService/UserServiceDelete'
  );
  mm.SetOperationCustomData(
    sUNIT_NAME,
    'UserService',
    'Delete',
    'FORMAT_Input_EncodingStyle',
    'literal'
  );
  mm.SetOperationCustomData(
    sUNIT_NAME,
    'UserService',
    'Delete',
    'FORMAT_OutputEncodingStyle',
    'literal'
  );
end;


var
  typeRegistryInstance : TTypeRegistry = nil;
initialization
  typeRegistryInstance := GetTypeRegistry();

  typeRegistryInstance.Register(sNAME_SPACE,TypeInfo(TUserCategory),'TUserCategory');
  typeRegistryInstance.Register(sNAME_SPACE,TypeInfo(TUser),'TUser');
  typeRegistryInstance.Register(sNAME_SPACE,TypeInfo(TNote),'TNote');
  typeRegistryInstance.Register(sNAME_SPACE,TypeInfo(TUserArray),'TUserArray');



End.
