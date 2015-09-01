{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }

{ Direitos Autorais Reservados (c) 2004 Daniel Simoes de Almeida               }

{ Colaboradores nesse arquivo:                                                 }

{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }

{  Esta biblioteca � software livre; voc� pode redistribu�-la e/ou modific�-la }
{ sob os termos da Licen�a P�blica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a vers�o 2.1 da Licen�a, ou (a seu crit�rio) }
{ qualquer vers�o posterior.                                                   }

{  Esta biblioteca � distribu�da na expectativa de que seja �til, por�m, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia impl�cita de COMERCIABILIDADE OU      }
{ ADEQUA��O A UMA FINALIDADE ESPEC�FICA. Consulte a Licen�a P�blica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICEN�A.TXT ou LICENSE.TXT)              }

{  Voc� deve ter recebido uma c�pia da Licen�a P�blica Geral Menor do GNU junto}
{ com esta biblioteca; se n�o, escreva para a Free Software Foundation, Inc.,  }
{ no endere�o 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voc� tamb�m pode obter uma copia da licen�a em:                              }
{ http://www.opensource.org/licenses/gpl-license.php                           }

{ Daniel Sim�es de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Pra�a Anita Costa, 34 - Tatu� - SP - 18270-410                  }

{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 25/08/2013:  Daniel Sim�es de Almeida
|*   Inicio do desenvolvimento
******************************************************************************}

{$I ACBr.inc}

unit ACBrEscElgin;

interface

uses
  Classes, SysUtils,
  ACBrPosPrinter, ACBrEscBematech, ACBrConsts;

type

  { TACBrEscElgin }

  TACBrEscElgin = class(TACBrEscBematech)
  private
  public
    constructor Create(AOwner: TACBrPosPrinter);

    function ComandoQrCode(ACodigo: AnsiString): AnsiString; override;
  end;


implementation

Uses
  ACBrUtil;

{ TACBrEscElgin }

constructor TACBrEscElgin.Create(AOwner: TACBrPosPrinter);
begin
  inherited Create(AOwner);

  fpModeloStr := 'EscElgin';
end;

function TACBrEscElgin.ComandoQrCode(ACodigo: AnsiString): AnsiString;
var
  Quality: AnsiChar;
begin
  with fpPosPrinter.ConfigQRCode do
  begin
    Result := GS + 'o' + #0 +             // Set parameters of QRCODE barcode
              AnsiChr(LarguraModulo) +    // Basic element width
              #0 +                        // Language mode: 0:Chinese 1:Japanese
              AnsiChr(Tipo) ;             // Symbol type: 1:Original type 2:Enhanced type(Recommended)

    case ErrorLevel of
      1: Quality := 'M';
      2: Quality := 'Q';
      3: Quality := 'H';
    else
      Quality := 'L';
    end;

    Result := Result +
              GS  + 'k' + // Bar Code
              #11 +       // Type = QRCode. Number of Characters: 4-928
              Quality +
              'A,' +      // Data input mode Range: A-automatic (Recommended). M-manual
              ACodigo +
              #0;
  end;
end;

end.
