import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Cultivoscreen extends ConsumerStatefulWidget {
  const Cultivoscreen({super.key});

  @override
  HomescreenState createState() => HomescreenState();
}

class HomescreenState extends ConsumerState<Cultivoscreen> {
  @override
  Widget build(BuildContext context) {
    
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
                }, style: ElevatedButton.styleFrom(minimumSize: Size(500, 60), backgroundColor: Colors.white),
                child: Text("Mis Cultivos", style: TextStyle(fontSize: 30, color: Colors.black),))
              ),

                Padding(
                padding: EdgeInsets.all(20),
                child: ElevatedButton(onPressed: (){
                  
                }, style: ElevatedButton.styleFrom(minimumSize: Size(500, 60), backgroundColor: Colors.red),
                child: Text("Estadisticas", style: TextStyle(fontSize: 30, color: Colors.white)), )
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