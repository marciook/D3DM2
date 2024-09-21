import 'dart:convert';

import 'package:exercicio4/endereco.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final TextEditingController _cepController = TextEditingController();

  final TextEditingController _ruaController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  var conteudo = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              TextField(
                controller: _cepController,
                decoration: const InputDecoration(labelText: 'Digite o CEP'),
              ),
              Text('Resultado: $conteudo'),
              TextButton(
                onPressed: buscaCEP,
                child: const Text('Buscar'),
              ),
              TextField(
                controller: _ruaController,
              ),
              TextField(
                controller: _bairroController,
              ),
              TextField(
                controller: _cidadeController,
              ),
              TextField(
                controller: _estadoController,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void buscaCEP() async {
    String cep = _cepController.text;

    if (cep.length == 8) {
      String url = 'https://viacep.com.br/ws/$cep/json/';

      final resposta = await http.get(Uri.parse(url));
      print(resposta.body);
      if (resposta.statusCode == 200) {
        // resposta 200 OK
        // o body contém JSON

        final jsonDecodificado = jsonDecode(resposta.body);
        final endereco = Endereco.fromJson(jsonDecodificado);
        print(jsonDecodificado);
        print(jsonDecodificado);

        setState(() {
          _ruaController.text = endereco.rua;
          _bairroController.text = endereco.bairro;
          _cidadeController.text = endereco.cidade;
          _estadoController.text = endereco.estado;
        });
      } else {
        if (resposta.statusCode == 400) {
          limpaCampos();
        }
        // diferente de 200
        throw Exception('Falha no carregamento.');
      }
    } else {
      limpaCampos();
    }
  }

  void limpaCampos() {
    _ruaController.clear();
    _bairroController.clear();
    _cidadeController.clear();
    _estadoController.clear();
  }
}