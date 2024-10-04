import 'dart:async';
import 'package:exercicio3/listarcaes.dart'; // Certifique-se de que está importando corretamente a página de listagem
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'dart:io' show Platform;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit(); // Inicializa o FFI
    databaseFactory = databaseFactoryFfi; // Define o databaseFactory para FFI
  }

  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: PetShop(),
      ),
    ),
  );
}

class PetShop extends StatefulWidget {
  const PetShop({super.key});

  @override
  State<PetShop> createState() => _PetShopState();
}

class _PetShopState extends State<PetShop> {
  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerRaca = TextEditingController();
  final TextEditingController _controllerIdade = TextEditingController();

  late Future<Database> _databaseFuture;

@override
void initState() {
  super.initState();
  _databaseFuture = _initDatabase(); // Inicializa o banco de dados
}

// Função para deletar o banco de dados
//Future<void> deleteDatabase() async {
//  final path = join(await getDatabasesPath(), 'petshop.db');
//  await databaseFactory.deleteDatabase(path);
//}
  
  Future<Database> _initDatabase() async {
     //await deleteDatabase(); 
    return openDatabase(
      join(await getDatabasesPath(), 'petshop.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE caes(id INTEGER PRIMARY KEY, nome TEXT, raca TEXT, idade INTEGER)',
        );
      },
      version: 1,
    );
  }

  Future<void> insereCao(Cao cao) async {
    final db = await _databaseFuture; // Garante que o banco está inicializado

    await db.insert(
      'caes',
      cao.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('Cão inserido: ${cao.nome}');
  }

  void _salvarCao() async {
    final String nome = _controllerNome.text;
    final String raca = _controllerRaca.text;
    final int idade = int.tryParse(_controllerIdade.text) ?? 0;

    if (nome.isNotEmpty && idade > 0) {
      final novoCao = Cao(id: null, nome: nome, raca: raca, idade: idade);
      await insereCao(novoCao);
      setState(() {
        _controllerNome.clear();
        _controllerIdade.clear();
        _controllerRaca.clear();
      });
    } else {
      print('Dados inválidos');
    }
  }

  // Método caes() para buscar os cães do banco
  Future<List<Cao>> caes() async {
    final db = await _databaseFuture;
    final List<Map<String, dynamic>> mapasCaes = await db.query('caes');

    return List.generate(mapasCaes.length, (i) {
      return Cao(
        id: mapasCaes[i]['id'],
        nome: mapasCaes[i]['nome'],
        raca: mapasCaes[i]['raca'],
        idade: mapasCaes[i]['idade'],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('Nome: '),
              SizedBox(width: 200, child: TextField(controller: _controllerNome)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text('Raça: '),
              SizedBox(width: 200, child: TextField(controller: _controllerRaca)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text('Idade: '),
              SizedBox(width: 200, child: TextField(controller: _controllerIdade)),
            ],
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: _salvarCao,
              child: const Text('Salvar'),
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () async {
                final lista = await caes();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListarCaes(listaCaes: lista),
                  ),
                );
              },
              child: const Text('Listar Cães'),
            ),
          ),
        ],
      ),
    );
  }
}

class Cao {
  final int? id;
  final String nome;
  final String raca;
  final int idade;

  Cao({
    this.id,
    required this.nome,
    required this.raca,
    required this.idade,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'nome': nome,
      'raca': raca,
      'idade': idade,
    };
  }

  @override
  String toString() {
    return 'Cao{id: $id, nome: $nome, raca: $raca, idade: $idade}';
  }
}
