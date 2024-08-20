
import 'package:flutter/material.dart';


void main() {
  runApp(const ComEstado());
}


class ComEstado extends StatefulWidget {
  const ComEstado({super.key});

  @override
  State<ComEstado> createState() => _ComEstadoState();
}

class _ComEstadoState extends State<ComEstado> {
  var numero = 1;


  void mudaPar() {
    // mudança:
    setState(() {
      if ((numero % 2) == 0) {
        numero = numero + 2;
      } else {
        numero = numero + 1;
      }
    });
  }

  void mudaImpar() {
    // mudança:
    setState(() {
      if ((numero % 2) == 0) {
        numero = numero + 1;
      } else {
        numero = numero + 2;
      }
    });
  }

  void reset() {
    // mudança:
    setState(() {
      numero = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
	body: Center(
	  child: Column(
	    children: [
	      Text(numero.toString(), style: const TextStyle(fontSize: 32),),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
	          ElevatedButton(onPressed: mudaPar, child: const Text('Par')),
            ElevatedButton(onPressed: mudaImpar, child: const Text('Impar'))
          ]
        ),
        ElevatedButton(onPressed: reset, child: const Text('Reset'))
        
	    ],
	  ),
	),
      ),
    );
  }
}