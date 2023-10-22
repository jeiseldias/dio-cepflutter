import 'package:diofluttercep/models/backend_cep_model.dart';

class BackendListModel {
  List<BackendCepModel> results = [];

  BackendListModel(this.results);

  BackendListModel.vazio();

  BackendListModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <BackendCepModel>[];
      json['results'].forEach((v) {
        results!.add(BackendCepModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['results'] = results.map((v) => v.toJson()).toList();
    return data;
  }
}
