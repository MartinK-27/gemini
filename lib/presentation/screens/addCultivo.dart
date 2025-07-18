import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini/entities/crops.dart';
import 'package:gemini/presentation/providers.dart';
import 'package:go_router/go_router.dart';

class Addcultivo extends ConsumerStatefulWidget {
  const Addcultivo({super.key});

  @override
  AddcultivoState createState() => AddcultivoState();
}

class AddcultivoState extends ConsumerState<Addcultivo> {
  @override
  Widget build(BuildContext context) {

    TextEditingController name = TextEditingController();
TextEditingController image = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Cultivo'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: name,
                decoration: InputDecoration(
                  labelText: 'Cultivo Name',
                  border: OutlineInputBorder(),
                ),
              ),
              
              SizedBox(height: 16),
              
              TextField(
                controller: image,
                decoration: InputDecoration(
                  labelText: 'Image URL (optional)',
                  border: OutlineInputBorder(),
                ),
              ),
              
              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  if(name.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill in all fields')),
                    );
                  } else {
                    ref.read(cultivosProvider.notifier).update((state) => [
                      ...state,
                      Crops(
                        name: name.text,
                        image: image.text.isEmpty ? 'https://www.diet-health.info/images/recipes/700/weizenkoerner-wheat-grains-by-stockpics-fotolia-78750746.jpg' : image.text,
                      ),
                    ]);
                    context.go('/CultivoScreen');
                  }
                  
                },
                child: Text('Add Cultivo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}