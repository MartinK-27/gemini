import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Homescreen extends ConsumerStatefulWidget {
  const Homescreen({super.key});

  @override
  HomescreenState createState() => HomescreenState();
}

class HomescreenState extends ConsumerState<Homescreen> {
  @override
  Widget build(BuildContext context) {
    void mostrarSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message, style: TextStyle(color: Colors.white),),
      duration: Duration(seconds: 1),
    );

    // Usamos ScaffoldMessenger para mostrar el SnackBar
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
    return Scaffold(
      appBar: AppBar(title: Text("HarvestINT"), centerTitle: true,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.all(20),
                child: ElevatedButton(onPressed: (){
                  context.push('/CultivoScreen');
                }, style: ElevatedButton.styleFrom(minimumSize: Size(500, 60), backgroundColor: Color.fromARGB(255, 22, 194, 22)),
                child: Text("Mis Cultivos", style: TextStyle(fontSize: 30, color: Colors.black),))
              ),

                Padding(
                padding: EdgeInsets.all(20),
                child: ElevatedButton(onPressed: (){
                  mostrarSnackBar(context, 'Work in progress xd');
                }, style: ElevatedButton.styleFrom(minimumSize: Size(500, 60), backgroundColor: Color.fromARGB(224, 212, 205, 10)),
                child: Text("Estadisticas", style: TextStyle(fontSize: 30, color: const Color.fromARGB(255, 0, 0, 0))), )
              ),

              Padding(
                padding: EdgeInsets.all(20),
                child: ElevatedButton(onPressed: (){
                  context.push('/ChatiScreen');
                }, style: ElevatedButton.styleFrom(minimumSize: Size(500, 60), backgroundColor: Color.fromARGB(255, 82, 65, 216)),
                child: Text("Chati", style: TextStyle(fontSize: 30, color: Colors.white)), )
              ),
          ],
        ),
      ),
    );
  }
}