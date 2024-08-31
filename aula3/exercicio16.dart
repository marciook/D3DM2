import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(' Edição de atividade'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            const Row(
              children: [
                Text('Nome da atividade: ', style: TextStyle(fontSize: 20)),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const Row(
              children: [
                Text(' Data da atividade: ', style: TextStyle(fontSize: 20)),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                     
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.datetime,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                FilledButton(onPressed: () {}, child: const Text('Salvar', style: TextStyle(fontSize: 20)))
              ],
            )
          ]),
        ),
      ),
    );
  }
}

