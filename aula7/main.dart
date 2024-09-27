import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

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
                  const SizedBox(
                      width: 10), // Espaçamento entre o texto e o campo
                  Expanded(
                    child: TextField(
                      enabled: false,
                      controller: latController,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20), // Espaçamento entre as linhas
              Row(
                children: [
                  const Text('Longitude:'),
                  const SizedBox(
                      width: 10), // Espaçamento entre o texto e o campo
                  Expanded(
                    child: TextField(
                      enabled: false,
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
    Position position = await Geolocator.getCurrentPosition();

    var lat_ = position.latitude;
    var lon_ = position.longitude;
    latController.text = lat_.toString();
    lonController.text = lon_.toString();

    String url =
        'https://api.open-meteo.com/v1/forecast?latitude=$lat_&longitude=$lon_&current=temperature_2m,relative_humidity_2m&forecast_days=1';
    print(url);
    final resposta = await http.get(Uri.parse(url));
    //print(resposta.body);
    if (resposta.statusCode == 200) {
      final jsonDecodificado = jsonDecode(resposta.body);
      final temperaturaAtual = Temperatura.fromJson(jsonDecodificado);

      print(lat_);
      print(lon_);
      setState(() {
        temperatura = temperaturaAtual.temperaturaAtual.toString();
        umidade = temperaturaAtual.umidade.toString();
      });
    }
    print(resposta.statusCode);
  }
}

class Temperatura {
  final String latitude;
  final String longitude;
  final num temperaturaAtual;
  final num umidade;

  Temperatura({
    required this.latitude,
    required this.longitude,
    required this.temperaturaAtual,
    required this.umidade,
  });

  // Método para converter um Map em um objeto Temperatura
  factory Temperatura.fromJson(Map<String, dynamic> json) {
    return Temperatura(
        latitude: json['latitude'].toString(),
        longitude: json['longitude'].toString(),
        temperaturaAtual: json['current']['temperature_2m'],
        umidade: json['current']['relative_humidity_2m']);
  }
}
