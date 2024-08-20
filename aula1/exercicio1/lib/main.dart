import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu Cartão',
      home: Scaffold(
	appBar: AppBar(
	  title: const Text('Meu Cartão'),
    backgroundColor: Colors.blue,
    centerTitle: true,
	),
	body: const Center(
	  child: Column(
	    mainAxisAlignment: MainAxisAlignment.center,
	    children: [
	      Text('Marcio Vinicius Okimoto', style: TextStyle(fontSize: 24)),
	      Text('Estudante BA3136876'),
	      Text('IFSP'),
	      Text('marcio.okimoto@aluno.ifsp.edu.br'),
	    ],
	  ),
	),
      ),
    );
  }
}