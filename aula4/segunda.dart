import 'package:flutter/material.dart';

class Segunda extends StatefulWidget {
  const Segunda({super.key});

  @override
  State<Segunda> createState() => _Segunda();
}

class _Segunda extends State<Segunda> {
  String ajudaData = 'Exemplo: 01/01/1970';
  String ajudaSenha = 'A senha deve ter no mínimo 8 caracteres.';

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

  void _validateData(String value) {
    String pattern = r'^(\d{0,2})(\/)?(\d{0,2})?(\/)?(\d{0,4})?$';
    RegExp regExp = RegExp(pattern);

    setState(() {
      if (regExp.hasMatch(value)) {
        ajudaData = 'Exemplo: 01/01/1970';
        if (value.length == 10) {
          String fullPattern =
              r'^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\d{4}$';
          RegExp fullRegExp = RegExp(fullPattern);
          if (fullRegExp.hasMatch(value)) {
            ajudaData = 'Exemplo: 01/01/1970';
          } else {
            ajudaData = 'Data inválida';
          }
        }
      } else {
        ajudaData = 'Data inválida';
      }
    });
  }

  
  bool comprimentoValido = false;
  bool maiusculaValida = false;
  bool numerosValidos = false;
  bool especiaisValidos = false;

  // Função para validar os critérios da senha progressivamente
  void _validateSenha(String value) {
    setState(() {
      // Verifica o comprimento
      comprimentoValido = value.length >= 8;
      // Verifica se contém uma letra maiúscula
      if (comprimentoValido) {
        maiusculaValida = value.contains(RegExp(r'[A-Z]'));
      }
      // Verifica se contém 3 números
      if (maiusculaValida) {
        numerosValidos = RegExp(r'[0-9]').allMatches(value).length >= 3;
      }
      // Verifica se contém 2 caracteres especiais
      if (numerosValidos) {
        especiaisValidos =
            RegExp(r'[!@#$%^&*()?_\-+=]').allMatches(value).length >= 2;
      }

      // Atualiza o helperText baseado nos critérios atingidos
      if (!comprimentoValido) {
        ajudaSenha = 'A senha deve ter no mínimo 8 caracteres.';
      } else if (!maiusculaValida) {
        ajudaSenha = 'A senha deve conter uma letra maiúscula.';
      } else if (!numerosValidos) {
        ajudaSenha = 'A senha deve conter pelo menos 3 números.';
      } else if (!especiaisValidos) {
        ajudaSenha = 'A senha deve conter pelo menos 2 caracteres especiais.';
      } else {
        ajudaSenha = '';
      }
    });
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
                    _validateData(value);
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
                  onChanged: (value) {
                    _validateSenha(value);
                  },
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
