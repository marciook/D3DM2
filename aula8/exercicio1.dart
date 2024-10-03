import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: Calculadora(),
      ),
    ),
  );
}

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  final TextEditingController _controlaX = TextEditingController();
  final TextEditingController _controlaY = TextEditingController();
  int resultado = 0;

  @override
  void initState() {
    super.initState();
    carrega();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 100,
              child: TextField(
                controller: _controlaX,
              ),
            ),
            SizedBox(
              width: 100,
              child: TextField(
                controller: _controlaY,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: soma,
          child: const Text('Soma'),
        ),
        const SizedBox(
          height: 50,
        ),
        Text(
          'Resultado: $resultado',
          style: const TextStyle(
            fontSize: 32,
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(onPressed: salva, child: const Text('Salva')),
            ElevatedButton(onPressed: limpa, child: const Text('Limpa')),
          ],
        ),
      ],
    );
  }

  void soma() {
    int _x = int.parse(_controlaX.text);
    int _y = int.parse(_controlaY.text);

    setState(() {
      resultado = _x + _y;
    });
  }

  Future<void> salva() async {
    final prefs = await SharedPreferences.getInstance();
    int _x = int.parse(_controlaX.text);
    int _y = int.parse(_controlaY.text);
    await prefs.setInt('x', _x);
    await prefs.setInt('y', _y);
  }

  Future<void> limpa() async {
    _controlaX.clear();
    _controlaY.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('x');
    await prefs.remove('y');
  }

  Future<void> carrega() async {
    final prefs = await SharedPreferences.getInstance();
    final x = prefs.getInt('x') ?? 0;
    final y = prefs.getInt('y') ?? 0;
    _controlaX.text = x.toString();
    _controlaY.text = y.toString();
  }
}
