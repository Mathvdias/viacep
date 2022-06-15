class CepList {
  final String cep;
  final String logradouro;
  final String complemento;
  final String bairro;
  final String localidade;
  final String uf;
  final String ibge;
  final String gia;
  final String ddd;
  final String siafi;

  CepList(
      {required this.cep,
      required this.logradouro,
      required this.complemento,
      required this.bairro,
      required this.localidade,
      required this.uf,
      required this.ibge,
      required this.gia,
      required this.ddd,
      required this.siafi});

  factory CepList.fromJson(Map json){
    return CepList(
        cep: json['cep'],
        logradouro: json['logradouro'],
        complemento: json['complemento'],
        bairro: json['bairro'],
        localidade: json['localidade'],
        uf: json['uf'],
        ibge: json['ibge'],
        gia: json['gia'],
        ddd: json['ddd'],
        siafi: json['siafi']);
  }    
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['cep'] = cep;
    _data['logradouro'] = logradouro;
    _data['complemento'] = complemento;
    _data['bairro'] = bairro;
    _data['localidade'] = localidade;
    _data['uf'] = uf;
    _data['ibge'] = ibge;
    _data['gia'] = gia;
    _data['ddd'] = ddd;
    _data['siafi'] = siafi;
    return _data;
  }
}
