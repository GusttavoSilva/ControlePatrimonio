program MeusPatrimonio;

uses
  System.StartUpCopy,
  FMX.Forms,
  uDmDados in 'Source\Componente\DmDados\uDmDados.pas' {Dm: TDataModule},
  Form_Mensagem in 'Source\View\FormMensagem\Form_Mensagem.pas' {Frm_Mensagem},
  uFrmPrincipal in 'Source\View\Principal\uFrmPrincipal.pas' {FrmPrincipal},
  uFrmLogin in 'Source\View\login\uFrmLogin.pas' {FrmLogin},
  u_Library in 'Source\Core\u_Library.pas',
  uClasseUsuario in 'Source\Model\Usuario\uClasseUsuario.pas',
  uInterfaceUsuario in 'Source\Model\Usuario\uInterfaceUsuario.pas',
  uInterfaceDepartamento in 'Source\Model\Departamento\uInterfaceDepartamento.pas',
  uFrmMainCadastros in 'Source\View\FormsMain\FormCadastro\uFrmMainCadastros.pas' {FrmMainCadastros},
  uFrmCadDepartamento in 'Source\View\Cadastros\Departamento\uFrmCadDepartamento.pas' {FrmCadDepartamento},
  uFrmCadUsuario in 'Source\View\Cadastros\Usuario\uFrmCadUsuario.pas' {FrmCadUsuarios},
  uFrmMainPesquisa in 'Source\View\FormsMain\formPesquisa\uFrmMainPesquisa.pas' {FrmMainPesquisa},
  uFrmPesqDepartamento in 'Source\View\Pesquisa\Departamento\uFrmPesqDepartamento.pas' {FrmPesqDepartamento},
  uFrmCadSala in 'Source\View\Cadastros\Sala\uFrmCadSala.pas' {FrmCadSala},
  uInterfaceSala in 'Source\Model\Sala\uInterfaceSala.pas',
  uClasseDepartamento in 'Source\Model\Departamento\uClasseDepartamento.pas',
  uClasseSala in 'Source\Model\Sala\uClasseSala.pas',
  uFrmPesqSalas in 'Source\View\Pesquisa\Salas\uFrmPesqSalas.pas' {FrmPesqSalas},
  uFrmPesqTipoPatrimonio in 'Source\View\Pesquisa\TipoPatrimonio\uFrmPesqTipoPatrimonio.pas' {FrmPesqTipoPatrimonio},
  uInterfaceTipoPatrimonio in 'Source\Model\TipoPatrimonio\uInterfaceTipoPatrimonio.pas',
  uClasseTipoPatrimonio in 'Source\Model\TipoPatrimonio\uClasseTipoPatrimonio.pas',
  uClasseCidade in 'Source\Model\Cidade\uClasseCidade.pas',
  uInterfaceCidade in 'Source\Model\Cidade\uInterfaceCidade.pas',
  uFrmPesqCidade in 'Source\View\Pesquisa\Cidade\uFrmPesqCidade.pas' {FrmPesqCidade},
  uFrmCadFornecedor in 'Source\View\Cadastros\Fornecedor\uFrmCadFornecedor.pas' {FrmCadFornecedor},
  uInterfaceFornecedor in 'Source\Model\fornecedor\uInterfaceFornecedor.pas',
  uClasseFornecedor in 'Source\Model\fornecedor\uClasseFornecedor.pas',
  uFrmPesqFornecedor in 'Source\View\Pesquisa\Fornecedor\uFrmPesqFornecedor.pas' {FrmPesqFornecedor},
  uFrmMainRelatorio in 'Source\View\FormsMain\FormRelatorio\uFrmMainRelatorio.pas' {FrmMainRelatorio},
  DmRelatorios in 'Source\Componente\DmRelatorios\DmRelatorios.pas' {DmRelatorio: TDataModule},
  uFrmRelatFornecedores in 'Source\View\Relatorios\Fornecedor\uFrmRelatFornecedores.pas' {FrmRelatFornecedores},
  uInterfaceRelatFornecedor in 'Source\ModelRelatorio\Fornecedores\uInterfaceRelatFornecedor.pas',
  uClasseRelatFornecedor in 'Source\ModelRelatorio\Fornecedores\uClasseRelatFornecedor.pas',
  uInterfacePerfil in 'Source\Model\Perfil\uInterfacePerfil.pas',
  uClassePerfil in 'Source\Model\Perfil\uClassePerfil.pas',
  uFrmCadPerfil in 'Source\View\Cadastros\Perfil\uFrmCadPerfil.pas' {FrmCadPerfil},
  uFrmCadPatrimonio in 'Source\View\Cadastros\Patrimonio\uFrmCadPatrimonio.pas' {FrmCadPatrimonio},
  uInterfacePatrimonio in 'Source\Model\Patrimonio\uInterfacePatrimonio.pas',
  uClassePatrimonio in 'Source\Model\Patrimonio\uClassePatrimonio.pas',
  uFrmRelatPatrimonio in 'Source\View\Relatorios\Patrimonio\uFrmRelatPatrimonio.pas' {FrmRelatPatrimonio},
  uInterfaceRelatPatrimonio in 'Source\ModelRelatorio\Patrimonio\uInterfaceRelatPatrimonio.pas',
  uClasseRelatPatrimonio in 'Source\ModelRelatorio\Patrimonio\uClasseRelatPatrimonio.pas',
  uFrmCadTipoPatrimonio in 'Source\View\Cadastros\TipoPatrimonio\uFrmCadTipoPatrimonio.pas' {FrmCadTipoPatrimonio};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDm, Dm);
  Application.CreateForm(TDmRelatorio, DmRelatorio);
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(TFrm_Mensagem, Frm_Mensagem);
  Application.Run;

end.
