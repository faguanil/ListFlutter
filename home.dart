import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class GlobalBd {
  static List<String> nome = [];
  static List<String> data = [];
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarefas'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: GlobalBd.nome.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Icon(Icons.note_alt),
              title: Text(GlobalBd.nome[index]),
              subtitle: Text(GlobalBd.data[index]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return FormularioTarefas();
            }),
          );
        },
      ),
    );
  }
}

class FormularioTarefas extends StatefulWidget {
  const FormularioTarefas({super.key});

  @override
  State<FormularioTarefas> createState() => _FormularioTarefasState();
}

class _FormularioTarefasState extends State<FormularioTarefas> {
  TextEditingController controllerNome = TextEditingController();
  TextEditingController controllerData = TextEditingController();
  String textoResultado = "";

  //atualiza a lista
  void reloadList() {
    setState(() {
      GlobalBd.nome.add("testeaqui");
      GlobalBd.data.add("testeaqui");
      ;
    });
  }

  //limpar os campos depois que os dados forem adicionados
  void clearText() {
    controllerNome.clear();
    controllerData.clear();
    reloadList();
  }

  void confirmar() {
    //verifica se os valores dos campos foram digitados
    if (controllerNome.text.isEmpty || controllerData.text.isEmpty) {
      setState(() {
        textoResultado = "Digite os dados solicitados";
      });
    } else {
      setState(() {
        GlobalBd.nome.add(controllerNome.text);
        GlobalBd.data.add(controllerData.text);
        textoResultado = "Tarefa adicionada com sucesso";
      });
      //chamar função para limpar os Campus
      clearText();
    }
  }

  @override
  Widget build(BuildContext context) {
    //variável para armazenar a mascara da DATA
    var mascData = MaskTextInputFormatter(mask: '##/##/####');
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionando Tarefas'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                  autofocus: true,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                  decoration: InputDecoration(
                    labelText: "Nome da Tarefa",
                  ),
                  controller: controllerNome,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                  inputFormatters: [mascData],
                  keyboardType: TextInputType.datetime,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                  decoration: InputDecoration(
                    labelText: "Data da Execussão",
                    hintText: "00/00/0000",
                  ),
                  controller: controllerData,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  child: Text(
                    "Adicionar Tarefa",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  onPressed: confirmar,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  textAlign: TextAlign.center,
                  textoResultado,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

///quando clicar na seta do appbar para voltar para uma página a mesma deve ser atualizada como fazer isso no flutter
///
///void didChangeDependencies() {
    super.didChangeDependencies();
    // Aqui você pode executar ação ou atualizar o estado da página anterior
    final ModalRoute<dynamic>? previousRoute = ModalRoute.of(context)?.previousResult;
    if (previousRoute != null && previousRoute.settings.name == '/previousPage') {
      // Executar ação ou atualizar o estado da página anterior aqui
    }
  }