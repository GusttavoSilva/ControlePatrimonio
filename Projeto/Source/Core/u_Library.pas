unit u_Library;

interface

uses
  System.SysUtils, System.MaskUtils, StrUtils, FMX.Edit,
  FMX.Dialogs, Classes, FMX.Controls,  Windows, System.UITypes,
  FMX.Layouts, FMX.ListBox, FMX.NumberBox, FMX.DateTimeCtrls, FMX.SearchBox, FireDAC.Comp.Client, uDmDados,
  Form_Mensagem, FMX.Types, FMX.Memo,
  System.Variants, FMX.ListView, FMX.Forms, FMX.StdCtrls ,FMX.Objects;

type
  TStatus = (upInsert, upUpdate, upDelete, upView);

const
  Caractere: array [1 .. 106] of Char = ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
    'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '!', '#', '$',
    '%', '&', '/', '(', ')', '=', '?', '>', '^', '@', '£', '§', '{', '[', ']', '}', '´', '<', '~', '+', '*', '`', '''',
    'ª', 'º', '¢', '-', '_', ',', '.', ';', ':', '|', '\', '¹', '²', '³', '¬', '°', '¨', ' ', 'a', 'b', 'c', 'd', 'e',
    'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z');

const
  Subst: array [1 .. 106] of string = ('!9@8', '@7!7', '#4$5', '$5%4', '%8$8', '^1%1', '&3^5', '*7&6', '(6*6', ')3(3',
    '-2)8', '=1-7', '+0-9', '/0@1', '\9$7', '!3@2', '@3&6', '#1*4', '$2#4', '%6(8', '^9!5', '&4=4', '*3@4', '(8*4',
    ')4!7', '-0^5', '=1@9', '+2!0', '/8%2', '\7@5', '!3@7', '@4!8', '#7&4', '$6$3', '%2&7', '^1*3', '&1@0', '*3$9',
    '#3^1', '!4-2', '&6(5', '!5@8', ')7!8', '4&1-', 'a2$1', '*9z6', '@7c3', '1%^5', '0&*6', '$5^6', '!18)', '(38)',
    '@30&', '#69]', '[70]', '{26}', '-93#', 'l52h', 'h71i', 'w80&', '%50%', '#401', '@87-', 'b46x', 'r55^', '!2*2',
    'o08y', '&89)', '%03%', '\59q', 't85*', '^29-', '@02%', '#99)', '#255', '@23~', '~91t', '6%4n', '~5a1', '0=+0',
    'Za*a', '%yB-', 'Xc#C', 'wl#d', 'V*@e', '&UF)', '!tG$', '-sh@', '%rij', '%QJ)', '%pk&', '@oL*', '!nm=', '!MN*',
    '@lO-', '$kpy', 'Ojq;', ':Ir-', 'h:;s', 'Gx%T', 'f}{U', 'E#tv', 'd1W+', '&cxk', 'pby$', 'aZ');

Function formacpfcnpj(numtexto: String): String;
Function formatelefone(numtexto: String): String;
function DataHoje: String;
function Criptografa(Palavra: string): string;
function DesCriptografa(Palavra: String): string;
function DiaSemana(Data: TDateTime): String;
function ExtensoMes(n: Integer): String;
function StatusExtenso(n: Integer): String;
function ConservacaoExtenso(n: Integer): String;
function CorExtenso(n: Integer): String;
function PrimeiroNome(Nome: String): String;
function valorPorExtenso(vlr: real): string;
function IIf(Expressao: Variant; ParteTRUE, ParteFALSE: Variant): Variant;
procedure Exibir_Mensagem(icone, tipo_mensagem, titulo, texto_msg, texto_btn1, texto_btn2: string;
  cor_btn1, cor_btn2: Cardinal);
procedure FormOpen(Alay_center: TLayout; aForm: TComponentClass);
function FormEstaCriado(AClass: TClass): Boolean;
procedure LimpaCampos(Form: TForm);
procedure DesabilitaCampo(Form: TForm);
procedure HabilitaCampos(Form: TForm);
function FormataValor(const pValor: Extended; const pDecimais: Word): string;
procedure ListViewSearch(AList: TListView);
function RemoveAcento(const pText: string): string;
procedure FechaForms;
function FormataDoc(fDoc: String): String;

var
  codRegistro, CodBusca, CodUsuario: Integer;
  NomeUsuario: String;
  Acao: TStatus;
  FActiveForm: TForm;
  sbList: TSearchBox;

implementation


function FormataDoc(fDoc: String): String;
Var
  vTam, xx: Integer;
  vDoc:     String;
begin
  vTam   := Length(fDoc);
  For xx := 1 To vTam Do
    If (copy(fDoc, xx, 1) <> '.') And (copy(fDoc, xx, 1) <> '-') And (copy(fDoc, xx, 1) <> '/') Then
      vDoc := vDoc + copy(fDoc, xx, 1);
  fDoc     := vDoc;
  vTam     := Length(fDoc);
  vDoc     := '';
  vDoc     := '';
  For xx   := 1 To vTam Do
  begin
    vDoc := vDoc + copy(fDoc, xx, 1);
    If vTam = 11 Then
    begin
      If (xx in [3, 6]) Then
        vDoc := vDoc + '.';
      If xx = 9 Then
        vDoc := vDoc + '-';
    end;
    If vTam = 14 Then
    begin
      If (xx in [2, 5]) Then
        vDoc := vDoc + '.';
      If xx = 8 Then
        vDoc := vDoc + '/';
      If xx = 12 Then
        vDoc := vDoc + '-';
    end;
  end;
  Result := vDoc;
end;

function RemoveAcento(const pText: string): string;
const
  ComAcento = 'àâêôûãõáéíóúçüñýÀÂÊÔÛÃÕÁÉÍÓÚÇÜÑÝ';
  SemAcento = 'aaeouaoaeioucunyAAEOUAOAEIOUCUNY';
var
  x: Cardinal;
  Text: string;
begin;
  Text := pText;
  for x := 1 to Length(Text) do
    try
      if (pos(Text[x], ComAcento) <> 0) then
        Text[x] := SemAcento[pos(Text[x], ComAcento)];
    except
      on E: Exception do
        raise Exception.Create('Erro no processo!');
    end;

  result := Text;
end;

function FormataValor(const pValor: Extended; const pDecimais: Word): string;
var
  LDecimalSeparator: Char;
  LFormat: string;
begin
  result := '';
  if pValor <> 0 then
  begin
    LDecimalSeparator := FormatSettings.DecimalSeparator;
    FormatSettings.DecimalSeparator := ',';
    LFormat := ',0.' + StringOfChar('0', pDecimais);
    result := FormatFloat(LFormat, pValor, FormatSettings);
    FormatSettings.DecimalSeparator := LDecimalSeparator;
  end
  else
    result := '0,00';
end;

procedure FechaForms;
var
  n: Integer;
begin
  //
  for n := 0 to Application.ComponentCount - 1 do
    if Application.Components[n] is TForm then
      if not(TForm(Application.Components[n]) = Application.MainForm) then
        if TForm(Application.Components[n]).Name <> 'FrmPrincipal' then
          TForm(Application.Components[n]).close;
end;

procedure FormOpen(Alay_center: TLayout; aForm: TComponentClass);
var
  i: Integer;

begin
  if Acao <> upView then
  begin
    Exibir_Mensagem('ERRO', 'ALERTA', 'Erro', 'Não é possivel sair da tela em modo de edição.' + sLineBreak +
      'Para sair, primeiro cancele ou salve as alterações!', 'OK', '', $FFDF5447, $FFDF5447);
    Frm_Mensagem.Show;
    abort;
  end
  else
  begin

    if (FActiveForm = nil) or (Assigned(FActiveForm) and (FActiveForm.ClassName <> aForm.ClassName)) then
    begin
      FechaForms;
      for i := Alay_center.ControlsCount - 1 downto 0 do
        Alay_center.RemoveObject(Alay_center.Controls[i]);

      FActiveForm.Free;
      FActiveForm := nil;

      if (not FormEstaCriado(aForm)) then
      begin
        Application.CreateForm(aForm, FActiveForm);

        Alay_center.AddObject(TLayout(FActiveForm.FindComponent('lay_Principal')));
      end;
    end;
  end;
end;

function FormEstaCriado(AClass: TClass): Boolean;
var
  i: Integer;
begin
  result := false;
  for i := 0 to Screen.FormCount - 1 do
  begin
    if Screen.Forms[i] is AClass then
    begin
      result := True;
      Break;
    end;
  end;
end;

{
  icone: ALERTA, PERGUNTA, ERRO ou SUCESSO
  tipo_mensagem: ALERTA ou PERGUNTA
  cor: exemplo... $FFA0A0A0
}
procedure Exibir_Mensagem(icone, tipo_mensagem, titulo, texto_msg, texto_btn1, texto_btn2: string;
  cor_btn1, cor_btn2: Cardinal);
begin
  if NOT Assigned(Frm_Mensagem) then
    Application.CreateForm(TFrm_Mensagem, Frm_Mensagem);

  with Frm_Mensagem do
  begin
    Transparency := True;

    // Icone...
    if icone = 'ALERTA' then
      img_icone.Bitmap := img_alerta.Bitmap
    else if icone = 'PERGUNTA' then
      img_icone.Bitmap := img_pergunta.Bitmap
    else if icone = 'ERRO' then
      img_icone.Bitmap := img_erro.Bitmap
    else
      img_icone.Bitmap := img_sucesso.Bitmap;

    // Tipo mensagem...
    rect_btn2.Visible := false;
    if tipo_mensagem = 'PERGUNTA' then
    begin
      rect_btn1.Width := 102;
      rect_btn2.Width := 102;
      rect_btn1.Align := TAlignLayout.Left;
      rect_btn2.Align := TAlignLayout.Right;

      rect_btn2.Visible := True;
    end
    else
    begin
      rect_btn1.Width := 160;
      rect_btn1.Align := TAlignLayout.Center;
    end;

    // Textos da Mensagem...
    lbl_titulo.Text := titulo;
    lbl_msg.Text := texto_msg;

    // Textos Botoes...
    lbl_btn1.Text := texto_btn1;
    lbl_btn2.Text := texto_btn2;

    // Cor Botoes...
    rect_btn1.Fill.Color := cor_btn1;
    rect_btn2.Fill.Color := cor_btn2;
  end;
end;

procedure LimpaCampos(Form: TForm);
var
  cont: Integer;
begin
  for cont := 0 To Form.ComponentCount - 1 Do
  begin
    If Form.Components[cont] Is TEdit Then
      TEdit(Form.Components[cont]).Text := '';

    If Form.Components[cont] Is TComboBox Then
      TComboBox(Form.Components[cont]).ItemIndex := 0;

    If Form.Components[cont] Is TCheckBox Then
      TCheckBox(Form.Components[cont]).IsChecked := false;

    If Form.Components[cont] Is TNumberBox Then
      TNumberBox(Form.Components[cont]).Text := EmptyStr;

    If Form.Components[cont] Is TMemo Then
      TMemo(Form.Components[cont]).Lines.Clear;

  end;

end;

procedure HabilitaCampos(Form: TForm);
var
  cont: Integer;
begin
  for cont := 0 To Form.ComponentCount - 1 Do
  begin
    If Form.Components[cont] Is TEdit Then
      TEdit(Form.Components[cont]).Enabled := True;

    If Form.Components[cont] Is TCheckBox Then
      TCheckBox(Form.Components[cont]).Enabled := True;

    If Form.Components[cont] Is TNumberBox Then
      TNumberBox(Form.Components[cont]).Enabled := True;

    If Form.Components[cont] Is TDateEdit Then
      TDateEdit(Form.Components[cont]).Enabled := True;

    If Form.Components[cont] Is TComboBox Then
      TComboBox(Form.Components[cont]).Enabled := True;

    If Form.Components[cont] Is TMemo Then
      TMemo(Form.Components[cont]).Enabled := True;

    If Form.Components[cont] Is TImage Then
      TImage(Form.Components[cont]).Enabled := True;

  end;

end;

procedure DesabilitaCampo(Form: TForm);
var
  cont: Integer;
begin
  for cont := 0 To Form.ComponentCount - 1 Do
  begin
    If Form.Components[cont] Is TEdit Then
      TEdit(Form.Components[cont]).Enabled := false;

    If Form.Components[cont] Is TCheckBox Then
      TCheckBox(Form.Components[cont]).Enabled := false;

    If Form.Components[cont] Is TNumberBox Then
      TNumberBox(Form.Components[cont]).Enabled := false;

    If Form.Components[cont] Is TDateEdit Then
      TDateEdit(Form.Components[cont]).Enabled := false;

    If Form.Components[cont] Is TComboBox Then
      TComboBox(Form.Components[cont]).Enabled := false;

    If Form.Components[cont] Is TMemo Then
      TMemo(Form.Components[cont]).Enabled := false;

    If Form.Components[cont] Is TImage Then
      if TImage(Form.Components[cont]).Name <> 'img_Fechar' then
        TImage(Form.Components[cont]).Enabled := false;

  end;
end;

function valorPorExtenso(vlr: real): string;
const
  unidade: array [1 .. 19] of string = ('um', 'dois', 'três', 'quatro', 'cinco', 'seis', 'sete', 'oito', 'nove', 'dez',
    'onze', 'doze', 'treze', 'quatorze', 'quinze', 'dezesseis', 'dezessete', 'dezoito', 'dezenove');
  centena: array [1 .. 9] of string = ('cento', 'duzentos', 'trezentos', 'quatrocentos', 'quinhentos', 'seiscentos',
    'setecentos', 'oitocentos', 'novecentos');
  dezena: array [2 .. 9] of string = ('vinte', 'trinta', 'quarenta', 'cinquenta', 'sessenta', 'setenta', 'oitenta',
    'noventa');
  qualificaS: array [0 .. 4] of string = ('', 'mil', 'milhão', 'bilhão', 'trilhão');
  qualificaP: array [0 .. 4] of string = ('', 'mil', 'milhões', 'bilhões', 'trilhões');
var
  inteiro: Int64;
  resto: real;
  vlrS, s, saux, vlrP, centavos: string;
  n, unid, dez, cent, tam, i: Integer;
  umReal, tem: Boolean;
begin
  if (vlr = 0) then
  begin
    valorPorExtenso := 'zero';
    exit;
  end;

  inteiro := trunc(vlr); // parte inteira do valor
  resto := vlr - inteiro; // parte fracionária do valor
  vlrS := inttostr(inteiro);
  if (Length(vlrS) > 15) then
  begin
    valorPorExtenso := 'Erro: valor superior a 999 trilhões.';
    exit;
  end;

  s := '';
  centavos := inttostr(round(resto * 100));

  // definindo o extenso da parte inteira do valor
  i := 0;
  umReal := false;
  tem := false;
  while (vlrS <> '0') do
  begin
    tam := Length(vlrS);
    // retira do valor a 1a. parte, 2a. parte, por exemplo, para 123456789:
    // 1a. parte = 789 (centena)
    // 2a. parte = 456 (mil)
    // 3a. parte = 123 (milhões)
    if (tam > 3) then
    begin
      vlrP := copy(vlrS, tam - 2, tam);
      vlrS := copy(vlrS, 1, tam - 3);
    end
    else
    begin // última parte do valor
      vlrP := vlrS;
      vlrS := '0';
    end;
    if (vlrP <> '000') then
    begin
      saux := '';
      if (vlrP = '100') then
        saux := 'cem'
      else
      begin
        n := strtoint(vlrP); // para n = 371, tem-se:
        cent := n div 100; // cent = 3 (centena trezentos)
        dez := (n mod 100) div 10; // dez  = 7 (dezena setenta)
        unid := (n mod 100) mod 10; // unid = 1 (unidade um)
        if (cent <> 0) then
          saux := centena[cent];
        if ((dez <> 0) or (unid <> 0)) then
        begin
          if ((n mod 100) <= 19) then
          begin
            if (Length(saux) <> 0) then
              saux := saux + ' e ' + unidade[n mod 100]
            else
              saux := unidade[n mod 100];
          end
          else
          begin
            if (Length(saux) <> 0) then
              saux := saux + ' e ' + dezena[dez]
            else
              saux := dezena[dez];
            if (unid <> 0) then
              if (Length(saux) <> 0) then
                saux := saux + ' e ' + unidade[unid]
              else
                saux := unidade[unid];
          end;
        end;
      end;
      if ((vlrP = '1') or (vlrP = '001')) then
      begin
        if (i = 0) // 1a. parte do valor (um real)
        then
          umReal := True
        else
          saux := saux + ' ' + qualificaS[i];
      end
      else if (i <> 0) then
        saux := saux + ' ' + qualificaP[i];
      if (Length(s) <> 0) then
        s := saux + ', ' + s
      else
        s := saux;
    end;
    if (((i = 0) or (i = 1)) and (Length(s) <> 0)) then
      tem := True; // tem centena ou mil no valor
    i := i + 1; // próximo qualificador: 1- mil, 2- milhão, 3- bilhão, ...
  end;

  if (Length(s) <> 0) then
  begin
    if (umReal) then
      s := s + ' real'
    else if (tem) then
      s := s + ' reais'
    else
      s := s + ' de reais';
  end;
  // definindo o extenso dos centavos do valor
  if (centavos <> '0') // valor com centavos
  then
  begin
    if (Length(s) <> 0) // se não é valor somente com centavos
    then
      s := s + ' e ';
    if (centavos = '1') then
      s := s + 'um centavo'
    else
    begin
      n := strtoint(centavos);
      if (n <= 19) then
        s := s + unidade[n]
      else
      begin // para n = 37, tem-se:
        unid := n mod 10; // unid = 37 % 10 = 7 (unidade sete)
        dez := n div 10; // dez  = 37 / 10 = 3 (dezena trinta)
        s := s + dezena[dez];
        if (unid <> 0) then
          s := s + ' e ' + unidade[unid];
      end;
      s := s + ' centavos';
    end;
  end;
  valorPorExtenso := s;
end;

function Criptografa(Palavra: string): string;
Var
  vet: Integer; // vetor
  ct: Integer; // vetor da constante
  aux: string; // variável auxiliar
begin
  result := '';
  ct := 0;
  vet := 0;
  aux := '';
  // palavra := uppercase(palavra);
  for vet := 1 to Length(Palavra) do
  begin
    for ct := 1 to 106 do
    begin
      if (Palavra[vet] = Caractere[ct]) then
      begin
        aux := aux + Subst[ct];
      end;
    end;
  end;
  result := aux;
end;

function DesCriptografa(Palavra: String): string;
Var
  iVetor: Integer;
  iContador: Integer;
  iContAux: Integer;
  sAuxiliar: string;
begin
  result := '';
  iContador := 0;
  iContAux := 0;
  iVetor := 0;
  sAuxiliar := '';
  for iVetor := 1 to Length(Palavra) do
  begin
    for iContador := 1 to 106 do
    begin
      if (copy(Palavra, iContAux + 1, 4) = Subst[iContador]) then
      begin
        sAuxiliar := sAuxiliar + Caractere[iContador];
      end;
    end;
    inc(iContAux, 4);
  end;
  result := sAuxiliar;
end;

Function formacpfcnpj(numtexto: String): String;
begin
  if Length(numtexto) = 11 then
  begin
    Delete(numtexto, ansipos('.', numtexto), 1); // Remove ponto .
    Delete(numtexto, ansipos('.', numtexto), 1);
    Delete(numtexto, ansipos('-', numtexto), 1); // Remove traço -
    Delete(numtexto, ansipos('/', numtexto), 1); // Remove barra /
    result := FormatmaskText('000\.000\.000\-00;0;', numtexto);
  end
  else if Length(numtexto) = 14 then
  begin
    Delete(numtexto, ansipos('.', numtexto), 1); // Remove ponto .
    Delete(numtexto, ansipos('.', numtexto), 1);
    Delete(numtexto, ansipos('-', numtexto), 1); // Remove traço -
    Delete(numtexto, ansipos('/', numtexto), 1); // Remove barra /
    result := FormatmaskText('00\.000\.000\/0000\-00;0;', numtexto);
  end

end;

// Formata número telefone fixo
Function formatelefone(numtexto: String): String;
begin
  if Length(numtexto) = 11 then
  begin
    Delete(numtexto, ansipos('-', numtexto), 1); // Remove traço -
    Delete(numtexto, ansipos('-', numtexto), 1);
    Delete(numtexto, ansipos('(', numtexto), 1); // Remove parenteses  (
    Delete(numtexto, ansipos(')', numtexto), 1); // Remove parenteses  )
    result := FormatmaskText('\(00\)00000\-0000;0;', numtexto);
  end
  else if Length(numtexto) = 10 then
  begin
    Delete(numtexto, ansipos('-', numtexto), 1); // Remove traço -
    Delete(numtexto, ansipos('-', numtexto), 1);
    Delete(numtexto, ansipos('(', numtexto), 1); // Remove parenteses  (
    Delete(numtexto, ansipos(')', numtexto), 1); // Remove parenteses  )
    result := FormatmaskText('\(00\)0000\-0000;0;', numtexto);
  end;
  // Formata os numero
end;

function DataHoje;
begin
  result := FormatDateTime('dd/mm/yyyy', Date);
end;

procedure ListViewSearch(AList: TListView);
var
  i: Integer;
begin

  AList.SearchVisible := True;
  for i := 0 to AList.Controls.Count - 1 do
    if AList.Controls[i].ClassType = TSearchBox then
    begin
      sbList := TSearchBox(AList.Controls[i]);
      Break;
    end;
  sbList.Height := 40;
  sbList.TextPrompt := 'Digite o que deseja encontrar';
  sbList.SetFocus;
end;

function DiaSemana(Data: TDateTime): String;
{ Retorna dia da semana }
var
  NoDia: Integer;
  DiaDaSemana: array [1 .. 7] of String[13];
begin
  { Dias da Semana }
  DiaDaSemana[1] := 'Domingo';
  DiaDaSemana[2] := 'Segunda-feira';
  DiaDaSemana[3] := 'Terça-feira';
  DiaDaSemana[4] := 'Quarta-feira';
  DiaDaSemana[5] := 'Quinta-feira';
  DiaDaSemana[6] := 'Sexta-feira';
  DiaDaSemana[7] := 'Sábado';
  NoDia := DayOfWeek(Data);
  DiaSemana := DiaDaSemana[NoDia];
end;

function ExtensoMes(n: Integer): String;
begin
  Case n Of
    01:
      result := 'Janeiro';
    02:
      result := 'Fevereiro';
    03:
      result := 'Março';
    04:
      result := 'Abril';
    05:
      result := 'Maio';
    06:
      result := 'Junho';
    07:
      result := 'Julho';
    08:
      result := 'Agosto';
    09:
      result := 'Setembro';
    10:
      result := 'Outubro';
    11:
      result := 'Novembro';
    12:
      result := 'Dezembro';
  end;
end;

function CorExtenso(n: Integer): String;
begin
  Case n Of
    01:
      result := 'AMARELO';
    02:
      result := 'AZUL';
    03:
      result := 'BEGE';
    04:
      result := 'BRANCO';
    05:
      result := 'CINZA';
    06:
      result := 'LARANJA';
    07:
      result := 'MARROM';
    08:
      result := 'PRETA';
    09:
      result := 'ROXO';
    10:
      result := 'VERDE';
    11:
      result := 'VERMELHO';
  end;
end;

function ConservacaoExtenso(n: Integer): String;
begin
  Case n Of
    01:
      result := 'NOVO';
    02:
      result := 'BOM';
    03:
      result := 'OCIOSO';
    04:
      result := 'RECUPERÁVEL';
    05:
      result := 'ANTIECONÔMICO';
    06:
      result := 'IRRECUPERÁVEL';
  end;
end;

function StatusExtenso(n: Integer): String;
begin
  Case n Of
    01:
      result := 'INATIVO';
    02:
      result := 'ATIVO';
  End;
end;

function PrimeiroNome(Nome: String): String;
var
  PNome: String;
begin
  PNome := '';

  if pos(' ', Nome) <> 0 then
    PNome := copy(Nome, 1, pos(' ', Nome) - 1)
  else
    PNome := Nome;

  result := Trim(PNome);
end;

function IIf(Expressao: Variant; ParteTRUE, ParteFALSE: Variant): Variant;
begin
  if Expressao then
    result := ParteTRUE
  else
    result := ParteFALSE;
end;

end.
