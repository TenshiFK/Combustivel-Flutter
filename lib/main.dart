import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //controi a interfacedo app
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    ); //Tipo de layout //MaterialApp
  }
}

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState(); //Cria uma estado para a tela incial
}

class _HomeState extends State<Home> {
  final TextEditingController _gasolinaController = TextEditingController();
  final TextEditingController _alcoolController = TextEditingController();

  String _resultado = "Informe os preços!";
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); //Validação do formulário

  void limparCampos() {
    _gasolinaController.text = "";
    _alcoolController.text = "";

    setState(() {
      _resultado = "Informe seus dados!";
    });
  }

  void _mostrarCarregamento() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text("Calculando..."),
              ],
            ),
          ),
        );
      },
    );
  }

  void _calcular() {
    _mostrarCarregamento();

    Future.delayed(Duration(seconds: 2), () {
      double gasolina = double.parse(_gasolinaController.text);
      double alcool = double.parse(_alcoolController.text);
      double resultado = alcool / gasolina;

      String mensagem;

      if (resultado < 0.7) {
        mensagem = "Abasteça com álcool!";
      } else {
        mensagem = "Abasteça com gasolina!";
      }

      Navigator.of(context).pop(); // Fecha o diálogo de carregamento

      // Exibe o resultado em um AlertDialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Resultado"),
            titleTextStyle: TextStyle(
                color: Color.fromARGB(255, 126, 103, 11), fontSize: 25.0),
            content: Text(mensagem, style: TextStyle(fontSize: 20.0)),
            actions: <Widget>[
              TextButton(
                child: Text(
                  "OK",
                  style: TextStyle(fontSize: 14.0),
                ),
                onPressed: () {
                  limparCampos();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //Barra de título
          title: Text("Calculadora de Combustível"),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 30.0),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 126, 103, 11),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(Icons.car_crash_outlined,
                          size: 120.0,
                          color: Color.fromARGB(255, 126, 103, 11)),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Valor da Gasolina",
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 126, 103, 11),
                              fontSize: 25.0),
                        ),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromARGB(255, 126, 103, 11),
                            fontSize: 25.0),
                        controller: _gasolinaController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Insira o preço da gasolina!";
                          }
                          final n = num.tryParse(value);
                          if (n == null || n <= 0) {
                            return "Insira um valor válido!";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Valor do Álcool",
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 126, 103, 11),
                              fontSize: 25.0),
                        ),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromARGB(255, 126, 103, 11),
                            fontSize: 25.0),
                        controller: _alcoolController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Insira o preço do álcool!";
                          }
                          final n = num.tryParse(value);
                          if (n == null || n <= 0) {
                            return "Insira um valor válido!";
                          }
                          return null;
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 10.0, bottom: 10.0, right: 5.0),
                              child: Container(
                                height: 50.0,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      // Verifica se o formulário é válido
                                      _calcular();
                                    }
                                  },
                                  child: Text(
                                    "Calcular",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25.0),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromARGB(255, 126, 103, 11)),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 10.0, bottom: 10.0, left: 5.0),
                              child: Container(
                                height: 50.0,
                                child: ElevatedButton(
                                  onPressed: () {
                                    limparCampos();
                                  },
                                  child: Text(
                                    "Limpar",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25.0),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromARGB(255, 126, 103, 11)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]))));
  }
}
