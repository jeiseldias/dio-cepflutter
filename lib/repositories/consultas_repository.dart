import 'package:diofluttercep/models/viacep_model.dart';
import 'package:diofluttercep/repositories/database_repository.dart';

class ConsultasRepository {
  Future<void> salvarConsulta(ViaCEPModel viaCEPModel) async {
    var db = await DatabaseRepository().obterDB();

    try {
      db.rawInsert(
          'INSERT INTO consultas(cep, logradouro, bairro, localidade, uf) VALUES(?, ?, ?, ?, ?)',
          [
            viaCEPModel.cep,
            viaCEPModel.logradouro,
            viaCEPModel.bairro,
            viaCEPModel.localidade,
            viaCEPModel.uf
          ]);
    } catch (e) {
      return;
    }
  }

  Future<void> deletarConsulta(ViaCEPModel viaCEPModel) async {
    var db = await DatabaseRepository().obterDB();

    db.rawDelete('DELETE FROM consultas WHERE cep = ?', [viaCEPModel.cep]);
  }

  Future<void> atualizarConsulta(ViaCEPModel viaCEPModel) async {
    var db = await DatabaseRepository().obterDB();

    db.rawUpdate(
        'UPDATE consultas SET logradouro = ?, bairro = ?, localidade = ?, uf =  ? WHERE cep = ?',
        [
          viaCEPModel.logradouro,
          viaCEPModel.bairro,
          viaCEPModel.localidade,
          viaCEPModel.uf,
          viaCEPModel.cep,
        ]);
  }

  Future<List<ViaCEPModel>> listarConsultas() async {
    var db = await DatabaseRepository().obterDB();
    List<ViaCEPModel> consultas = [];

    var response = await db.rawQuery("SELECT * FROM consultas");
    for (var consulta in response) {
      consultas.add(ViaCEPModel(
          cep: consulta["cep"].toString(),
          logradouro: consulta["logradouro"].toString(),
          bairro: consulta["bairro"].toString(),
          localidade: consulta["localidade"].toString(),
          uf: consulta["uf"].toString()));
    }

    return consultas;
  }

  Future<bool> checarCEP(ViaCEPModel viaCEPModel) async {
    var db = await DatabaseRepository().obterDB();

    var response = await db
        .rawQuery('SELECT cep FROM consultas WHERE cep = ?', [viaCEPModel.cep]);

    if (response.isNotEmpty) {
      return false;
    }

    return true;
  }
}
