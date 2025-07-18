import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini/presentation/providers.dart';
import 'package:gemini/entities/crops.dart';
import 'package:go_router/go_router.dart';

class Cultivoscreen extends ConsumerStatefulWidget {
  const Cultivoscreen({super.key});

  @override
  CultivoscreenState createState() => CultivoscreenState();
}

class CultivoscreenState extends ConsumerState<Cultivoscreen> {
  @override
  Widget build(BuildContext context) {

final cultivos = ref.watch(cultivosProvider);

    return Scaffold(
      appBar: AppBar(title: Text("HarvestINT"), centerTitle: true,),
      body: ListView.builder(
        itemCount: cultivos.length,
        itemBuilder: (context, index) {
          //return Text(movies[index].title);   //Ejemplo 1
          return Card(
            child: ListTile(
              title: Text(cultivos[index].name),
             
              leading: Image.network(
                cultivos[index].image,
                width: 80,
                height: 100,
                fit: BoxFit.cover,
              ),
              onTap: () {
                ref.read(selectedcultivoProvider.notifier).state = cultivos[index].name;
                context.push('/SensorScreen');
              },
            ),
          );
        },
      ),
      
             
        
      floatingActionButton:  FloatingActionButton(
            tooltip: "Agregar",
            onPressed: () {
              context.push('/AddcultivoScreen');
            },
            backgroundColor: Color.fromARGB(255, 45, 169, 226),
            child: Icon(Icons.add,
          ),
    ));
  }
  
}
