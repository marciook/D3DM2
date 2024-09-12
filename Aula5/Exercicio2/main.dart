import 'package:flutter/material.dart';
import 'package:flutter_operacoes_matematicas/multiplicacao.dart';
import 'package:flutter_operacoes_matematicas/soma.dart';
import 'package:flutter_operacoes_matematicas/subtracao.dart';
import 'package:flutter_operacoes_matematicas/divisao.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: 'Soma',
                  //icon: Icon(Icons.directions_car),
                ),
                Tab(
                  text: 'Subtração',
                  //icon: Icon(Icons.directions_transit),
                ),
                Tab(
                  text: 'Multiplicação',
                  //icon: Icon(Icons.directions_transit),
                ),
                Tab(
                  text: 'Divisão',
                  //icon: Icon(Icons.directions_transit),
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              //Icon(Icons.directions_car),
              Soma(),
              //Icon(Icons.directions_transit),
              Subtracao(),
              Multiplica(),
              Divide()
            ],
          ),
        ),
      ),
    );
  }
}
