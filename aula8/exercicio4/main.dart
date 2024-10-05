import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:exercicio4/listar_ocorrencias.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final listaDeCameras = await availableCameras();
  final firstCamera = listaDeCameras.first;

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: JanelaTiraFoto(camera: firstCamera),
    ),
  );
}

// Modelo da ocorrência
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'caminhoFoto': caminhoFoto,
    };
  }
}

// Função para abrir o banco de dados e criar a tabela
Future<Database> openDatabaseOcorrencias() async {
  final directory = await getApplicationDocumentsDirectory();
  final path = join(directory.path, 'ocorrencias.db');

  return openDatabase(
    path,
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE ocorrencias(id INTEGER PRIMARY KEY AUTOINCREMENT, titulo TEXT, descricao TEXT, caminhoFoto TEXT)',
      );
    },
    version: 1,
  );
}

// Janela para capturar a foto e preencher o formulário
class JanelaTiraFoto extends StatefulWidget {
  final CameraDescription camera;

  const JanelaTiraFoto({super.key, required this.camera});

  @override
  JanelaTiraFotoState createState() => JanelaTiraFotoState();
}

class JanelaTiraFotoState extends State<JanelaTiraFoto> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  final TextEditingController tituloController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    tituloController.dispose();
    descricaoController.dispose();
    super.dispose();
  }

  Future<void> salvarOcorrencia(String titulo, String descricao, String caminhoFoto) async {
    final db = await openDatabaseOcorrencias();

    await db.insert(
      'ocorrencias',
      {
        'titulo': titulo,
        'descricao': descricao,
        'caminhoFoto': caminhoFoto,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar Ocorrência')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                // Preview da câmera
                Expanded(
                  child: CameraPreview(_controller),
                ),
                // Formulário para título e descrição
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: tituloController,
                        decoration: const InputDecoration(labelText: 'Título'),
                      ),
                      TextField(
                        controller: descricaoController,
                        decoration: const InputDecoration(labelText: 'Descrição'),
                      ),
                      IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ListarOcorrencias(),
                ),
              );
            },
          ),



                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await _initializeControllerFuture;

            // Tira a foto
            final image = await _controller.takePicture();

            if (!context.mounted) return;

            // Salva no banco de dados
            await salvarOcorrencia(
              tituloController.text,
              descricaoController.text,
              image.path,
            );

            // Exibe a imagem capturada
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => janelaMostraFoto(caminhoDaImagem: image.path),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

// Janela que exibe a foto capturada
class janelaMostraFoto extends StatelessWidget {
  final String caminhoDaImagem;

  const janelaMostraFoto({super.key, required this.caminhoDaImagem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mostrando a Foto')),
      body: Image.file(File(caminhoDaImagem)),
    );
  }
}
