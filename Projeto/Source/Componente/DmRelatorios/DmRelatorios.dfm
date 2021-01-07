object DmRelatorio: TDmRelatorio
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 198
  Width = 724
  object QRelatFornecedor: TFDQuery
    Connection = Dm.FDConn
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 50000
    SQL.Strings = (
      
        'SELECT F.ID, F.NOME, F.CPFCNPJ, F.TELEFONE, UPPER(CONCAT(M.NOME,' +
        ' '#39' - '#39', M.UF)) AS CIDADE FROM FORNECEDORES F'
      'LEFT OUTER JOIN MUNICIPIO M ON (M.ID = F.ID_CIDADE)')
    Left = 48
    Top = 80
    object QRelatFornecedorID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object QRelatFornecedorNOME: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NOME'
      Origin = 'nome'
      Size = 80
    end
    object QRelatFornecedorCPFCNPJ: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CPFCNPJ'
      Origin = 'CPFCNPJ'
      Size = 40
    end
    object QRelatFornecedorTELEFONE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'TELEFONE'
      Origin = 'telefone'
      Size = 45
    end
    object QRelatFornecedorCIDADE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CIDADE'
      Origin = 'CIDADE'
      ProviderFlags = []
      ReadOnly = True
      Size = 260
    end
  end
  object frxDBDataset1: TfrxDBDataset
    UserName = 'Fornecedor'
    CloseDataSource = False
    DataSet = QRelatFornecedor
    BCDToCurrency = False
    Left = 48
    Top = 24
  end
  object QPerfil: TFDQuery
    Active = True
    Connection = Dm.FDConn
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 50000
    SQL.Strings = (
      
        'SELECT p.*, UPPER(CONCAT(M.NOME, '#39' - '#39', M.UF)) AS CIDADE FROM Pe' +
        'rfil P'
      'LEFT OUTER JOIN MUNICIPIO M ON (M.ID = P.ID_CIDADE)'
      'where p.id = 1')
    Left = 656
    Top = 96
    object QPerfilid: TFDAutoIncField
      FieldName = 'id'
      ReadOnly = True
    end
    object QPerfilnome: TStringField
      FieldName = 'nome'
      Size = 80
    end
    object QPerfiltelefone: TStringField
      FieldName = 'telefone'
    end
    object QPerfilendereco: TStringField
      FieldName = 'endereco'
      Size = 80
    end
    object QPerfilbairro: TStringField
      FieldName = 'bairro'
      Size = 45
    end
    object QPerfilid_cidade: TIntegerField
      FieldName = 'id_cidade'
    end
    object QPerfilcpfcnpj: TStringField
      FieldName = 'cpfcnpj'
      Size = 45
    end
    object QPerfillogo: TBlobField
      FieldName = 'logo'
    end
    object QPerfilCIDADE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CIDADE'
      Origin = 'CIDADE'
      ProviderFlags = []
      ReadOnly = True
      Size = 260
    end
  end
  object frxDBDataset2: TfrxDBDataset
    UserName = 'Perfil'
    CloseDataSource = False
    DataSet = QPerfil
    BCDToCurrency = False
    Left = 656
    Top = 40
  end
  object QRelatPatrimonio: TFDQuery
    Connection = Dm.FDConn
    SQL.Strings = (
      
        'select p.id, p.numero_placa, t.nome as tipopatrimonio, p.marca, ' +
        'f.nome as fornecedor, concat(s.nome, '#39' - '#39',  d.nome) as sala,'
      'case p.cor'
      'when 1 then '#39'AMARELO'#39' when 2 then '#39'AZUL'#39
      'when 3 then '#39'BEGE'#39' when 4 then '#39'BRANCO'#39
      'when 5 then '#39'CINZA'#39' when 6 then '#39'LARANJA'#39
      'when 7 then '#39'MARROM'#39' when 8 then '#39'PRETA'#39
      'when 9 then '#39'ROXO'#39' when 10 then '#39'VERDE'#39
      'when 11 then '#39'VERMELHO'#39' end as cor,'
      'case p.status'
      'when 1 then '#39'INATIVO'#39' when 2 then '#39'ATIVO'#39' end as status,'
      'case p.estado_fisico'
      'when 1 then '#39'NOVO'#39' when 2 then '#39'BOM'#39' '
      'when 3 then '#39'OCIOSO'#39' when 4 then '#39'RECUPER'#193'VEL'#39' '
      
        'when 5 then '#39'ANTIECON'#212'MICO'#39' when 6 then '#39'IRRECUPER'#193'VEL'#39' end as c' +
        'onservacao,'
      'IFNULL(p.valor, 0) as valor,'
      'date_format(p.data_aquisicao, '#39'%d/%m/%Y'#39') as data_aquisicao,'
      'date_format(p.data_cadastro, '#39'%d/%m/%Y'#39') as data_cadastro'
      ' from patrimonio p'
      'left outer join salas s on (p.id_sala = s.id)'
      
        'left outer join tipo_patrimonio t on (p.id_tipo_patrimonio = t.i' +
        'd)'
      'left outer join fornecedores f on (p.id_fornecedor = f.id)'
      'left outer join departamento d on (s.id_departamento = d.id)'
      'order by p.numero_placa')
    Left = 184
    Top = 80
    object QRelatPatrimonioid: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object QRelatPatrimonionumero_placa: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'numero_placa'
      Origin = 'numero_placa'
    end
    object QRelatPatrimoniotipopatrimonio: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'tipopatrimonio'
      Origin = 'nome'
      ProviderFlags = []
      ReadOnly = True
      Size = 80
    end
    object QRelatPatrimoniomarca: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'marca'
      Origin = 'marca'
      Size = 45
    end
    object QRelatPatrimoniofornecedor: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'fornecedor'
      Origin = 'nome'
      ProviderFlags = []
      ReadOnly = True
      Size = 80
    end
    object QRelatPatrimoniosala: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'sala'
      Origin = 'sala'
      ProviderFlags = []
      ReadOnly = True
      Size = 163
    end
    object QRelatPatrimoniocor: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'cor'
      Origin = 'cor'
      ProviderFlags = []
      ReadOnly = True
      Size = 8
    end
    object QRelatPatrimoniostatus: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'status'
      Origin = '`status`'
      ProviderFlags = []
      ReadOnly = True
      Size = 7
    end
    object QRelatPatrimonioconservacao: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'conservacao'
      Origin = 'conservacao'
      ProviderFlags = []
      ReadOnly = True
      Size = 13
    end
    object QRelatPatrimoniovalor: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'valor'
      Origin = 'valor'
      ProviderFlags = []
      ReadOnly = True
    end
    object QRelatPatrimoniodata_aquisicao: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'data_aquisicao'
      Origin = 'data_aquisicao'
      ProviderFlags = []
      ReadOnly = True
      Size = 10
    end
    object QRelatPatrimoniodata_cadastro: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'data_cadastro'
      Origin = 'data_cadastro'
      ProviderFlags = []
      ReadOnly = True
      Size = 10
    end
  end
  object frxDBDataset3: TfrxDBDataset
    UserName = 'Patrimonio'
    CloseDataSource = False
    DataSet = QRelatPatrimonio
    BCDToCurrency = False
    Left = 184
    Top = 24
  end
end
