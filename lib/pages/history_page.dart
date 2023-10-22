import 'package:diofluttercep/models/backend_cep_model.dart';
import 'package:diofluttercep/models/backend_list_model.dart';
import 'package:diofluttercep/repositories/backend_repository.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  TextEditingController idController = TextEditingController();
  TextEditingController cepController = TextEditingController();
  TextEditingController logradouroController = TextEditingController();
  TextEditingController bairroController = TextEditingController();
  TextEditingController localidadeController = TextEditingController();
  TextEditingController ufController = TextEditingController();

  final BackendRepository _backendRepository = BackendRepository();
  List<BackendCepModel> _bconsultas = [];

  @override
  void initState() {
    super.initState();
    obterConsultas();
  }

  void obterConsultas() async {
    BackendListModel backendListModel = BackendListModel.vazio();
    backendListModel = await _backendRepository.listarCEP();
    _bconsultas = backendListModel.results;
    setState(() {});
  }

  void handleListClick(BackendCepModel backendCepModel) {
    idController.text = backendCepModel.objectId;
    cepController.text = backendCepModel.cep;
    logradouroController.text = backendCepModel.logradouro;
    bairroController.text = backendCepModel.bairro;
    localidadeController.text = backendCepModel.localidade;
    ufController.text = backendCepModel.uf;

    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text("Editar consulta"),
            content: Wrap(children: [
              TextField(
                controller: logradouroController,
              ),
              TextField(
                controller: bairroController,
              ),
              TextField(
                controller: localidadeController,
              ),
              TextField(
                controller: ufController,
              ),
            ]),
            actions: [
              TextButton(
                  onPressed: handleCloseDialog, child: const Text("Cancelar")),
              TextButton(
                  onPressed: handleSalvarConsulta, child: const Text("Salvar")),
            ],
          );
        });
  }

  void handleDeletarConsulta(BackendCepModel backendCepModel) async {
    //await _consultasRepository.deletarConsulta(viaCEPModel);
    await _backendRepository.deletarCEP(backendCepModel);
    obterConsultas();
  }

  void handleCloseDialog() {
    Navigator.pop(context);
  }

  void handleSalvarConsulta() async {
    BackendCepModel backendCepModel = BackendCepModel(
        objectId: idController.text,
        cep: cepController.text,
        logradouro: logradouroController.text,
        bairro: bairroController.text,
        localidade: localidadeController.text,
        uf: ufController.text);
    await _backendRepository.atualizarCEP(backendCepModel);

    obterConsultas();
    handleCloseDialog();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: ListView.builder(
          itemCount: _bconsultas.length,
          itemBuilder: (BuildContext bc, int index) {
            var consultaAtual = _bconsultas[index];

            return Dismissible(
              key: Key(consultaAtual.cep),
              direction: DismissDirection.endToStart,
              background: Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      Text(
                        "DELETAR",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
              onDismissed: (DismissDirection dismissDirection) {
                handleDeletarConsulta(consultaAtual);
              },
              child: InkWell(
                onTap: () {
                  handleListClick(consultaAtual);
                },
                child: ListTile(
                  isThreeLine: true,
                  title: Text(consultaAtual.logradouro),
                  subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(consultaAtual.bairro),
                        Text(
                            '${consultaAtual.localidade} - ${consultaAtual.uf}'),
                      ]),
                  trailing: Text(consultaAtual.cep),
                ),
              ),
            );
          }),
    );
  }
}
