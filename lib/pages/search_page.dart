import 'package:diofluttercep/models/backend_cep_model.dart';
import 'package:diofluttercep/repositories/backend_repository.dart';
import 'package:diofluttercep/repositories/viacep_repository.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final ViaCEPRepository _viaCEPRepository = ViaCEPRepository();
  final BackendRepository _backendRepository = BackendRepository();
  BackendCepModel _backendCepModel = BackendCepModel.vazio();
  TextEditingController cepController = TextEditingController();
  bool consultando = false;

  void handleButtonSearch() async {
    setState(() {
      consultando = true;
      _backendCepModel = BackendCepModel.vazio();
    });

    _backendCepModel = await _viaCEPRepository.consultarCEP(cepController.text);
    if (_backendCepModel.logradouro != "" &&
        await _backendRepository.checarCEP(_backendCepModel)) {
      await _backendRepository.salvarCEP(_backendCepModel);
    }

    setState(() {
      cepController.text = "";
      consultando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(children: [
        const Text("Digite o CEP:"),
        TextField(
          controller: cepController,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(
          height: 16,
        ),
        (consultando)
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: handleButtonSearch, child: const Text("Pesquisar")),
        const SizedBox(
          height: 16,
        ),
        const Divider(),
        const SizedBox(
          height: 8,
        ),
        Text(
          _backendCepModel.logradouro,
          style: const TextStyle(fontSize: 20),
        ),
        Text(
          _backendCepModel.bairro,
          style: const TextStyle(fontSize: 16),
        ),
        (_backendCepModel.localidade != "")
            ? Text("${_backendCepModel.localidade} - ${_backendCepModel.uf}",
                style: const TextStyle(fontSize: 14))
            : const Text(""),
      ]),
    );
  }
}
