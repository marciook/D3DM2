import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

// Modelo de Ocorrência
class Ocorrencia {
  final int id;
  final String titulo;
  final String descricao;
  final String caminhoFoto;

  Ocorrencia({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.caminhoFoto,
  });

  // Converte um Map para um objeto Ocorrência
  factory Ocorrencia.fromMap(Map<String, dynamic> map) {
    return Ocorrencia(
      id: map['id'],
      titulo: map['titulo'],
      descricao: map['descricao'],
      caminhoFoto: map['caminhoFoto'],
    );
  }
}

// Função para abrir o banco de dados
Future<Database> openDatabaseOcorrencias() async {
  final directory = await getApplicationDocumentsDirectory();
  final path = join(directory.path, 'ocorrencias.db');
  return openDatabase(path);
}

// Tela para listar as ocorrências
class ListarOcorrencias extends StatefulWidget {
  const ListarOcorrencias({Key? key}) : super(key: key);

  @override
  _ListarOcorrenciasState createState() => _ListarOcorrenciasState();
}

class _ListarOcorrenciasState extends State<ListarOcorrencias> {
  List<Ocorrencia> ocorrencias = [];

  @override
  void initState() {
    super.initState();
    _carregarOcorrencias();
  }

  // Função para buscar todas as ocorrências do banco de dados
  Future<void> _carregarOcorrencias() async {
    final db = await openDatabaseOcorrencias();

    // Busca todas as ocorrências do banco
    final List<Map<String, dynamic>> maps = await db.query('ocorrencias');

    setState(() {
      ocorrencias = List.generate(maps.length, (i) {
        return Ocorrencia.fromMap(maps[i]);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ocorrências Registradas'),
      ),
      body: ListView.builder(
        itemCount: ocorrencias.length,
        itemBuilder: (context, index) {
          final ocorrencia = ocorrencias[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: Image.file(
                File(ocorrencia.caminhoFoto),
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(ocorrencia.titulo),
              subtitle: Text(ocorrencia.descricao),
            ),
          );
        },
      ),
    );
  }
}
