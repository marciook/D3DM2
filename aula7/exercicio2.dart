import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  final TextEditingController _dateController = TextEditingController();
  List<Map<String, String>> listaDados = [];

  String _errorText = '';

  @override
  void initState() {
    super.initState();
    String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    _dateController.text = formattedDate;
  }

  Future<void> _obterDados() async {
  // Expressão regular para validar a data no formato DD/MM/YYYY
  final regex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
  
  // Limpa a lista de dados toda vez que um novo pedido de dados é feito
  listaDados.clear(); 

  if (!regex.hasMatch(_dateController.text)) {
    setState(() {
      _errorText = 'Formato de data inválido. O correto é DD/MM/YYYY';
    });
  } else {
    setState(() {
      _errorText = ''; // Limpa a mensagem de erro se a data for válida
    });

    DateTime dataFinal = DateFormat('dd/MM/yyyy').parse(_dateController.text);

    for (int i = 0; i < 4; i++) {
      DateTime dataAnosAntes =
          DateTime(dataFinal.year - i, dataFinal.month, dataFinal.day);
      String dataFormatada = DateFormat('yyyyMMdd').format(dataAnosAntes);
      String url =
          'https://economia.awesomeapi.com.br/json/daily/USD-BRL?start_date=$dataFormatada&end_date=$dataFormatada';
      final resposta = await http.get(Uri.parse(url));

      if (resposta.statusCode == 200) {
        final jsonDecodificado = jsonDecode(resposta.body);
        String cotacao;
        
        if (jsonDecodificado.isNotEmpty) {
          cotacao = jsonDecodificado[0]['bid'];
        } else {
          cotacao = '-';
        }

        setState(() {
          listaDados.add({
            'data': DateFormat('dd/MM/yyyy').format(dataAnosAntes),
            'cotacao': cotacao,
          });
        });
      }
      await Future.delayed(const Duration(seconds: 1)); // Espera por 2 segundos
    }
    print(listaDados);
  }
}


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    labelText: 'Data (DD/MM/YYYY)',
                    errorText: _errorText.isNotEmpty ? _errorText : null,
                  ),
                ),
                const SizedBox(
                    height: 16), // Espaço entre o campo de texto e o botão
                ElevatedButton(
                  onPressed: _obterDados, // Chama a validação ao clicar
                  child: const Text('Buscar cotação'),
                ),
                const SizedBox(height: 16),
                Table(
                  border: TableBorder.all(), // Adiciona bordas à tabela
                  children: [
                    const TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Data'),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Cotação'),
                        ),
                      ],
                    ),
                    ...listaDados.map((item) {
                      return TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                Text(item['data'].toString()), // Exibe a data
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                item['cotacao'].toString()), // Exibe a cotação
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
