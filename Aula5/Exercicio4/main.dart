import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Recebendo número:'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

double calcular(double numero1, double numero2, String operacao) {
  double resultado;

  switch (operacao) {
    case 'soma':
      resultado = numero1 + numero2;
      break;
    case 'subtracao':
      resultado = numero1 - numero2;
      break;
    case 'multiplicacao':
      resultado = numero1 * numero2;
      break;
    case 'divisao':
      if (numero2 != 0) {
        resultado = numero1 / numero2;
      } else {
        throw Exception('Divisão por zero não é permitida');
      }
      break;
    default:
      throw Exception('Operação desconhecida');
  }

  return resultado;
}

class _MyHomePageState extends State<MyHomePage> {
  late double numero1;
  late double numero2;
  double resultado = 0;
  late String operacao;

  TextEditingController controlador = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: controlador,
                readOnly: true,
              ),
            ),
            Text(
              // exibindo valor do controlador:
              'Resultado: $resultado',
              style: const TextStyle(
                fontSize: 32,
              ),
            ),
            Row( mainAxisAlignment: MainAxisAlignment.center, 
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      controlador.text = '${controlador.text}1';
                    });
                  },
                  child: const Text('1'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      controlador.text = '${controlador.text}2';
                    });
                  },
                  child: const Text('2'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      controlador.text = '${controlador.text}3';
                    });
                  },
                  child: const Text('3'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      controlador.text = '${controlador.text}4';
                    });
                  },
                  child: const Text('4'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      controlador.text = '${controlador.text}5';
                    });
                  },
                  child: const Text('5'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      controlador.text = '${controlador.text}6';
                    });
                  },
                  child: const Text('6'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      controlador.text = '${controlador.text}7';
                    });
                  },
                  child: const Text('7'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      controlador.text = '${controlador.text}8';
                    });
                  },
                  child: const Text('8'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      controlador.text = '${controlador.text}9';
                    });
                  },
                  child: const Text('9'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      controlador.text = '${controlador.text}0';
                    });
                  },
                  child: const Text('0'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (!controlador.text.contains('.')) {
                        controlador.text = '${controlador.text}.';
                      }
                    });
                  },
                  child: const Text('.'),
                ),
              ],
            ),
            Row( mainAxisAlignment: MainAxisAlignment.center, 
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (controlador.text == "") {
                        numero1 = resultado;
                      } else {
                        numero1 = double.parse(controlador.text);
                      }
                      operacao = 'soma';
                      controlador.clear();
                      
                    });
                  },
                  child: const Text('+'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (controlador.text == "") {
                        numero1 = resultado;
                      } else {
                        numero1 = double.parse(controlador.text);
                      }
                      operacao = 'subtracao';
                      controlador.clear();
                      
                    });
                  },
                  child: const Text('-'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (controlador.text == "") {
                        numero1 = resultado;
                      } else {
                        numero1 = double.parse(controlador.text);
                      }
                      operacao = 'multiplicacao';
                      controlador.clear();
                      
                    });
                  },
                  child: const Text('*'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (controlador.text == "") {
                        numero1 = resultado;
                      } else {
                        numero1 = double.parse(controlador.text);
                      }
                      operacao = 'divisao';
                      controlador.clear();
                      
                    });
                  },
                  child: const Text('/'),
                ),
              ],
            ),
            Row( mainAxisAlignment: MainAxisAlignment.center, 
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (controlador.text.isNotEmpty) {
                        controlador.text = controlador.text
                            .substring(0, controlador.text.length - 1);
                      }
                    });
                  },
                  child: const Text('<----'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      controlador.clear();
                      numero1 = 0;
                      numero2 = 0;
                      resultado = 0;
                    });
                  },
                  child: const Text('C'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      numero2 = double.parse(controlador.text);
                      resultado = calcular(numero1, numero2, operacao);
                      controlador.clear();
                      //numero1 = resultado;
                    });
                  },
                  child: const Text('='),
                ),
              ],
            )
          ],
        ),
      ), 
    );
  }
}
