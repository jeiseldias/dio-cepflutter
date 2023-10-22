class BackendCepModel {
  String objectId = "";
  String cep = "";
  String logradouro = "";
  String bairro = "";
  String localidade = "";
  String uf = "";

  BackendCepModel(
      {required this.objectId,
      required this.cep,
      required this.logradouro,
      required this.bairro,
      required this.localidade,
      required this.uf});

  BackendCepModel.vazio();

  BackendCepModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    cep = json['cep'];
    logradouro = json['logradouro'];
    bairro = json['bairro'];
    localidade = json['localidade'];
    uf = json['uf'];
  }

  BackendCepModel.fromJsonViaCEP(Map<String, dynamic> json) {
    cep = json['cep'];
    logradouro = json['logradouro'];
    bairro = json['bairro'];
    localidade = json['localidade'];
    uf = json['uf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['objectId'] = this.objectId;
    data['cep'] = this.cep;
    data['logradouro'] = this.logradouro;
    data['bairro'] = this.bairro;
    data['localidade'] = this.localidade;
    data['uf'] = this.uf;
    return data;
  }
}
