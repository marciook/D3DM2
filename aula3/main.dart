import 'package:flutter/material.dart';
import 'package:flutter_application_1/com_estado.dart';

void main() {
  runApp(ComEstado());
}

class MainApp extends StatelessWidget {
  String nome = 'Fulano';
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              OutlinedButton(
                  onPressed: () {
                    nome = 'Marcio';
                    print(nome);
                  },
                  child: const Text('Mostre Nome')),
              Text('Nome: $nome')
            ],
          ),
        ),
      ),
    );
  }
}
