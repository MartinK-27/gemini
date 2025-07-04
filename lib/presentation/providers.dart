import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini/entities/users.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

StateProvider<String> userIDProvider = StateProvider<String>((ref) => '');



final chatMessagesProvider = StateProvider<List<ChatMessage>>((ref) => []);



StateProvider<List<Users>> userProvider = StateProvider((ref) => [
Users(
      email: 'martinkin2021@gmail.com',
      contrasena: 'NuevaContraseña2021',
      nombre: 'Tincho',
      loRa: 'Nazca 1830',
      id: '1',
    ),
    Users(
      email: 'martinkin2020@gmail.com',
      contrasena: 'Pandemia2020',
      nombre: 'Marto',
      loRa: 'Jonte 1234',
      id: '2',
    ),
    Users(
      email: '48522161@est.ort.edu.ar',
      contrasena: 'MecatronicaDap123',
      nombre: 'Martin',
      loRa: 'Yatay 123',
      id: '3',
    ),
    Users(
      email: '23903423@est.ort.edu.ar',
      contrasena: 'Marcelito22',
      nombre: 'Marcelo',
      loRa: 'Rio de Janerio 321',
      id: '4',
    ),
    Users(
      email: 'fofo_god@gmail.com',
      contrasena: 'Minecraft123',
      nombre: 'Fefe',
      loRa: 'Angel gallardo 2000',
      id: '5',
    ),
    Users(email: 'a', contrasena: 'a', nombre: 'FastUser', loRa: '123', id: '6'),

]);