import 'package:flutter/material.dart';
import 'main.dart';  // Importe o arquivo onde o modelo Cao está definido

class ListarCaes extends StatelessWidget {
  final List<Cao> listaCaes;

  const ListarCaes({Key? key, required this.listaCaes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Cães'),
      ),
      body: SingleChildScrollView(
        // Para permitir rolagem em dispositivos menores
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Nome')),
            DataColumn(label: Text('Raça')),
            DataColumn(label: Text('Idade')),
          ],
          rows: listaCaes.map((cao) {
            return DataRow(cells: [
              DataCell(Text(cao.nome)),
              DataCell(Text(cao.raca)),
              DataCell(Text(cao.idade.toString())),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}
