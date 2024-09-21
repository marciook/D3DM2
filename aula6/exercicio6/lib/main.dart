import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:exercicio6/temperatura.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  var latController = TextEditingController();
  var lonController = TextEditingController();
  var temperatura = '-';
  var umidade = '-';
  

  @override
  Widget build(BuildContext context) {
        return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Text('Latitude:'),
                  const SizedBox(width: 10), // Espaçamento entre o texto e o campo
                  Expanded(
                    child: TextField(
                      controller: latController,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20), // Espaçamento entre as linhas
              Row(
                children: [
                  const Text('Longitude:'),
                  const SizedBox(width: 10), // Espaçamento entre o texto e o campo
                  Expanded(
                    child: TextField(
                      controller: lonController,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(height: 50),
                  const Text('Temperatura atual:'),
                  const SizedBox(width: 10),
                  Text(temperatura),

                ],
              ),
                            Row(
                children: [
                  const SizedBox(height: 50),
                  const Text('Umidade atual:'),
                  const SizedBox(width: 10),
                  Text(umidade),

                ],
              ),
              TextButton(
                onPressed: buscaTemperatura,
                child: const Text('Buscar'),
              ),
            ],
          ),
        ),
      ),
    );
  }


void buscaTemperatura() async {
  
    var latitude = latController.text;
    var longitude = lonController.text;
    
    
    String url = 'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current=temperature_2m,relative_humidity_2m&forecast_days=1';
    print(url);
    final resposta = await http.get(Uri.parse(url));
      //print(resposta.body);
      if (resposta.statusCode == 200) {
        // resposta 200 OK
        // o body contém JSON

        final jsonDecodificado = jsonDecode(resposta.body);
        final temperaturaAtual = Temperatura.fromJson(jsonDecodificado);
        print(temperaturaAtual);
        setState(() {
          temperatura = temperaturaAtual.temperaturaAtual.toString();  
          umidade = temperaturaAtual.umidade.toString();
        });
        
      
    }
    print(resposta.statusCode);
}
  }