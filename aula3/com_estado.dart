import 'package:flutter/material.dart';

class ComEstado extends StatefulWidget {
  const ComEstado({super.key});

  @override
  State<ComEstado> createState() => _ComEstadoState();
}

class _ComEstadoState extends State<ComEstado> {
  String nome = 'Fulano';
  // ignore: non_constant_identifier_names
  var nivelOpacity = 0.5;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              OutlinedButton(
                  onPressed: () {
                    setState(() {
                      nome = 'Marcio';
                      nivelOpacity = 1;
                    });
                    print(nome);
                  },
                  child: const Text('Mostre Nome')),
              Opacity(
                  opacity: nivelOpacity,
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text('Nome: $nome'),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
