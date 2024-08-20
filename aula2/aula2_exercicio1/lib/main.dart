import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
      	title: const Text(
          'Atividades',
          style: TextStyle(
          fontFamily: 'Quicksand',
          fontSize: 34,),
        
        ),

        centerTitle: true,
        backgroundColor: Colors.blue,
        ),
        body: 
           const Column(
            children: [
              Row(
                children: [
                  Icon(Icons.check_box_outline_blank,
                  color: Colors.blue,
                  ),
                  SizedBox(width: 20,),
	                Text(
                    'Estudar para prova de matemática.',
                    style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 26,
                    color: Colors.blue,
                    decoration: TextDecoration.lineThrough
                    ,),
                    ),
                  Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '16/08/2024',
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 22,
                        color: Colors.blue,
                        decoration: TextDecoration.lineThrough
                      ),
                    ),
                  ),
                )
                ],
              ),
              Row(
                children: [
                  Icon(Icons.check_box_outlined,
                  color: Colors.black,
                  ),
                  SizedBox(width: 20,),
	                Text(
                    'Campeonato de futebol.',
                    style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 26,
                    color: Colors.black
                    ,),
                    
                    ),
                  Expanded(
                  
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '14/08/2024',
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 22,
                        color: Colors.black
                      ),
                      ),
                  ),
                  ),
                ]
              ),
            Row(
                children: [
                  Icon(Icons.timer,
                  color: Colors.green,),
                  SizedBox(width: 20,),
	                Text(
                    'Festa da Joana.',
                    style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 26,
                    color: Colors.green
                  
                    ,),
                    ),
                  Expanded(
                  
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '23/08/2024',
                    style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 22,
                    color: Colors.green
                    
                    ,),
                    ),
                  ),
                  ),
                ]
              ),
	           
	          ],
            ),  
        ),
      );
  }
}
