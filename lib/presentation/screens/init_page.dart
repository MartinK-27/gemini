import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini/presentation/providers.dart';
import 'package:go_router/go_router.dart';
import 'package:gemini/entities/users.dart';
import 'package:flutter/gestures.dart';

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
  TextEditingController passwordConfirm = TextEditingController();
  String textoingresado1 = '';
  String textoingresado2 = '';
  int R = 255;
  bool visible = true;


  String modo = 'init';

  Widget build(BuildContext context) {
    void ojito() {
    setState(() {
      visible = !visible;
    });
  }
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
                    usuario.text = '';
                    password.text = '';
                    passwordConfirm.text = '';
                    mail.text = '';
                    loRa.text = '';
                    modo = 'login';
                  });
                }, style: ElevatedButton.styleFrom(minimumSize: Size(500, 60), backgroundColor: Colors.white),
                child: Text("Login", style: TextStyle(fontSize: 30, color: Colors.black),))
              ),

                Padding(
                padding: EdgeInsets.all(0.5),
                child: ElevatedButton(onPressed: (){
                  setState(() {
                      usuario.text = '';
                      password.text = '';
                      passwordConfirm.text = '';
                      mail.text = '';
                      loRa.text = '';
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: (){
                    setState(() {
                      modo = 'init';
                    });
                    
                  }, child: Text('Atras')),
                  SizedBox(width: 20,),
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
                        context.go('/HomeScreen');
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
              SizedBox(height: 30,),
              RichText(
          text: TextSpan(
            text: '¿No tenes cuenta? ',
            style: TextStyle(color: Colors.black, fontSize: 18),
            children: [
              TextSpan(
                text: 'Registrate',
                style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    setState(() {
                      usuario.text = '';
                      password.text = '';
                      passwordConfirm.text = '';
                      mail.text = '';
                      loRa.text = '';
                      modo = 'register';
                    });
                  },
              ),
              
            ],
          ),
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
                padding: EdgeInsets.all(12),
                child: TextField(
                  controller: usuario,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nuevo Usuario',
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(12),
                child: TextField(
                  controller: mail,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Mail',
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(12),
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

               Padding(
                padding: EdgeInsets.all(12),
                
                child: TextField(
                  controller: passwordConfirm,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirmar contraseña',
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(12),
                child: TextField(
                  controller: loRa,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Modulo LoRa',
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: (){
                    setState(() {
                      modo = 'init';
                    });
                  }, child: Text("Atras")),
                  SizedBox(width: 20,),
                  ElevatedButton(
                onPressed: () {
                  if(usuario.text.isEmpty || password.text.isEmpty || mail.text.isEmpty || loRa.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('No puede haber nada en blanco')),
                    );
                  } 
                  else if(password.text != passwordConfirm.text){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Las contraseñas tienen que coincidir')),
                    );
                  }
                  else {
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
                    context.go('/HomeScreen');
                  }
                  
                },
                child: Text('Registrar'),
              ),
                ],
              ),
              SizedBox(height: 30,),
              RichText(
          text: TextSpan(
            text: 'Si ya tenes cuenta, ',
            style: TextStyle(color: Colors.black, fontSize: 18),
            children: [
              TextSpan(
                text: 'inicia sesion',
                style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    setState(() {
                      usuario.text = '';
                      password.text = '';
                      passwordConfirm.text = '';
                      mail.text = '';
                      loRa.text = '';
                      modo = 'login';
                    });
                  },
              ),
              
            ],
          ),
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