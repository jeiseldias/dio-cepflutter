import 'package:dio/dio.dart';
import 'package:diofluttercep/models/backend_cep_model.dart';
import 'package:diofluttercep/models/backend_list_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class BackendRepository {
  Dio dio = Dio();

  BackendRepository() {
    dio.options.baseUrl = "https://parseapi.back4app.com/classes";
    dio.options.headers["X-Parse-Application-Id"] =
        dotenv.get("BACK4APP_APPLICATION_ID");
    dio.options.headers["X-Parse-REST-API-Key"] =
        dotenv.get("BACK4APP_API_KEY");
  }

  Future<BackendListModel> listarCEP() async {
    var response = await dio.get("/ceps");

    return BackendListModel.fromJson(response.data);
  }

  Future<void> salvarCEP(BackendCepModel backendCepModel) async {
    try {
      await dio.post("/ceps", data: backendCepModel.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> atualizarCEP(BackendCepModel backendCepModel) async {
    await dio.put("/ceps/${backendCepModel.objectId}",
        data: backendCepModel.toJson());
  }

  Future<void> deletarCEP(BackendCepModel backendCepModel) async {
    await dio.delete("/ceps/${backendCepModel.objectId}");
  }

  Future<bool> checarCEP(BackendCepModel backendCepModel) async {
    var response =
        await dio.get("/ceps?where={\"cep\":\"${backendCepModel.cep}\"}");

    BackendListModel backendListModel =
        BackendListModel.fromJson(response.data);

    if (backendListModel.results.isNotEmpty) {
      return false;
    }

    return true;
  }
}
