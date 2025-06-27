import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini/presentation/providers.dart';
import 'package:go_router/go_router.dart';
import 'package:gemini/entities/users.dart';

class InitPage extends ConsumerStatefulWidget {
  const InitPage({super.key});

  @override
  InitPageState createState() => InitPageState();
}

class InitPageState extends ConsumerState<InitPage> {
   

  void mostrarSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message, style: TextStyle(color: Colors.white),),
      duration: Duration(seconds: 1),
    );

    // Usamos ScaffoldMessenger para mostrar el SnackBar
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  
  @override
  TextEditingController usuario = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController loRa = TextEditingController();
  String textoingresado1 = '';
  String textoingresado2 = '';
  int R = 255;
  bool visible = true;
  void ojito() {
    setState(() {
      visible = !visible;
    });
  }

  String modo = 'init';

  Widget build(BuildContext context) {
    final listaUsuarios = ref.watch(userProvider);
    if(modo == 'init'){
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "HarvestINT \n        { }",
                style: TextStyle(
                  fontSize: 80,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              SizedBox(height: 20),
              Text('Login or register for use the app', style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 0, 0, 0)),),

              Padding(
                padding: EdgeInsets.all(30),
                child: ElevatedButton(onPressed: (){
                  setState(() {
                    modo = 'login';
                  });
                }, style: ElevatedButton.styleFrom(minimumSize: Size(500, 60), backgroundColor: Colors.white),
                child: Text("Login", style: TextStyle(fontSize: 30, color: Colors.black),))
              ),

                Padding(
                padding: EdgeInsets.all(0.5),
                child: ElevatedButton(onPressed: (){
                  setState(() {
                    modo = 'register';
                  });
                }, style: ElevatedButton.styleFrom(minimumSize: Size(500, 60), backgroundColor: Colors.black),
                child: Text("Register", style: TextStyle(fontSize: 30, color: Colors.white)), )
              ),
              

             
            ],
          ),
        ),
      );

    }
    else if(modo == 'login'){
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "HarvestINT \n        { }",
                style: TextStyle(
                  fontSize: 50,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                  controller: usuario,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Usuraio',
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                  controller: password,
                  obscureText: visible,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Contraseña',
                    suffixIcon: IconButton(
                      onPressed: ojito,
                      icon: Icon(
                        visible ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    textoingresado1 = usuario.text;
                    textoingresado2 = password.text;
                    if (textoingresado1 == '' || textoingresado2 == '') {
                      mostrarSnackBar(context, 'Error, el usuario o la contraseña no pueden estar vacios');
                      setState(() {});
                    } 
                    else {
                     var usuarioingresando = listaUsuarios.firstWhere((Users) => Users.email == textoingresado1, orElse: () => Users(email: 'null', contrasena: 'null', nombre: 'null', loRa: 'null', id: 'null'));
                      if (usuarioingresando.contrasena == textoingresado2 && usuarioingresando.email == textoingresado1) {
                        mostrarSnackBar(context, 'Incio de sesion exitoso');
                        ref.read(userIDProvider.notifier).update((State) => usuarioingresando.id);
                        context.go('/HomePage');
                        setState(() {});
                      } 
                      else {
                        mostrarSnackBar(context, 'Error, Usuario o Contraseña invalidos');
                        setState(() {});
                      }
                    }
                  });
                },
                child: Text('Verificar'),
              ),
            ],
          ),
        ),
      );

    }
    else if(modo == 'register'){
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "HarvestINT \n        { }",
                style: TextStyle(
                  fontSize: 50,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                  controller: usuario,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nuevo Usuario',
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                  controller: mail,
                  obscureText: visible,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Mail',
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                  controller: password,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Contraseña',
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                  controller: loRa,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Modulo LoRa',
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  if(usuario.text.isEmpty || password.text.isEmpty || mail.text.isEmpty || loRa.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill in all fields')),
                    );
                  } else {
                    ref.read(userProvider.notifier).update((state) => [
                      ...state,
                      Users(
                       nombre: usuario.text,
                        email: mail.text,
                        contrasena: password.text,
                        loRa: loRa.text,
                        id: DateTime.now().millisecondsSinceEpoch.toString(), // Genera un ID único 
                      ),
                    ]);
                    context.go('/HomePage');
                  }
                  
                },
                child: Text('Registrar'),
              ),
            ],
          ),
        ),
      );
    }
    else{
      return Scaffold();
    }
  }
}