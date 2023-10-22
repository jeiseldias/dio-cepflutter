class ViaCEPModel {
  String cep = "";
  String logradouro = "";
  String bairro = "";
  String localidade = "";
  String uf = "";

  ViaCEPModel(
      {required this.cep,
      required this.logradouro,
      required this.bairro,
      required this.localidade,
      required this.uf});

  ViaCEPModel.vazio();

  ViaCEPModel.fromJson(Map<String, dynamic> json) {
    cep = json['cep'];
    logradouro = json['logradouro'];
    bairro = json['bairro'];
    localidade = json['localidade'];
    uf = json['uf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cep'] = this.cep;
    data['logradouro'] = this.logradouro;
    data['bairro'] = this.bairro;
    data['localidade'] = this.localidade;
    data['uf'] = this.uf;
    return data;
  }
}
