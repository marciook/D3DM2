import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const IMC(title: 'Calcula IMC'),
    );
  }
}

class IMC extends StatefulWidget {
  const IMC({super.key, required this.title});

  final String title;

  @override
  State<IMC> createState() => _IMCState();
}

class _IMCState extends State<IMC> {
  TextEditingController controladorA = TextEditingController();
  TextEditingController controladorP = TextEditingController();
  double imc = 0;

  double calcularIMC() {
    double altura = double.parse(controladorA.text);
    double peso = double.parse(controladorP.text);

  
      imc = peso / (altura * altura);
      return imc;
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: controladorA,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Altura (m)',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: controladorP,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Peso (kg)',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  imc = calcularIMC();
                });
                
                },
              child: const Text('Calcular IMC'),
            ),
            Text(
              'Seu IMC: ${imc.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
