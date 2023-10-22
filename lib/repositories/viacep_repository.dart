import 'package:dio/dio.dart';
import 'package:diofluttercep/models/backend_cep_model.dart';

class ViaCEPRepository {
  Future<BackendCepModel> consultarCEP(String cep) async {
    Dio dio = Dio();

    try {
      var response = await dio.get("https://viacep.com.br/ws/$cep/json/");
      if (response.statusCode == 200) {
        return BackendCepModel.fromJsonViaCEP(response.data);
      }
    } catch (e) {}

    return BackendCepModel.vazio();
  }
}
