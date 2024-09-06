import 'package:flutter/material.dart';

class Segunda extends StatefulWidget {
  const Segunda({super.key});

  @override
  State<Segunda> createState() => _Segunda();
}

class _Segunda extends State<Segunda> {
  String ajudaData = 'Exemplo: 01/01/1970';
  String ajudaSenha = '';

  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  FocusNode FocusNome = FocusNode();
  void _clearText() {
    _controller1.clear();
    _controller2.clear();
    _controller3.clear();
    _controller4.clear();
    FocusNome.requestFocus();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            children: [
              TextField(
                controller: _controller1,
                focusNode: FocusNome,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nome:',
                  focusColor: Colors.blue,
                ),
                autofocus: true,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: TextField(
                  controller: _controller2,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Sobrenome:',
                    focusColor: Colors.blue,
                  ),
                  autofocus: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: TextField(
                  controller: _controller3,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Nascimento:',
                    focusColor: Colors.blue,
                    helperText: ajudaData,
                  ),
                  autofocus: true,
                  onChanged: (value) {
                    final datePattern = RegExp(r'^(\d{2})/(\d{2})/(\d{4})$');
                    final match = datePattern.matchAsPrefix(value);

                    if (match == null) {
                      setState(() {
                        ajudaData = 'Data inválida';
                      });
                      return;
                    }

                    final day = int.tryParse(match.group(1) ?? '');
                    final month = int.tryParse(match.group(2) ?? '');
                    final year = int.tryParse(match.group(3) ?? '');

                    if (day == null || month == null || year == null) {
                      setState(() {
                        ajudaData = 'Data inválida';
                      });
                      return;
                    }

                    try {
                      final date = DateFormat('dd/MM/yyyy').parseStrict(value);
                      if (date.day != day ||
                          date.month != month ||
                          date.year != year) {
                        setState(() {
                          _isDateValid = false;
                        });
                        return;
                      }
                    } catch (e) {
                      setState(() {
                        _isDateValid = false;
                      });
                      return;
                    }

                    setState(() {
                      _isDateValid = true;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 50),
                child: TextField(
                  controller: _controller4,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Senha:',
                    focusColor: Colors.blue,
                    helperText: ajudaSenha,
                  ),
                  autofocus: true,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 40),
                    child: FilledButton(
                        onPressed: _clearText,
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: const Text('Limpar')),
                  ),
                  FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text('Enviar'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
