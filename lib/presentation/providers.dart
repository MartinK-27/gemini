import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini/entities/crops.dart';
import 'package:gemini/entities/users.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

StateProvider<String> userIDProvider = StateProvider<String>((ref) => '');



final chatMessagesProvider = StateProvider<List<ChatMessage>>((ref) => []);
final chatHistoryProvider = StateProvider<List<ChatMessage>>((ref) => []);



final cultivosProvider = StateProvider<List<Crops>>((ref) => [
   Crops(name: "Trigo", image: "https://www.diet-health.info/images/recipes/700/weizenkoerner-wheat-grains-by-stockpics-fotolia-78750746.jpg"),
  Crops(name: "Soja", image: "https://pxcdn.0223.com.ar/f/55d5fc7b7840e805000000f8/1440087444450.webp?cw=748&ch=420&extw=jpeg"),
  Crops(name: "Maiz", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxDQY3sRJvsKQv93t00vUUJCQZs9H878zW5Q&s"),
  Crops(name: "Sorgo", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSV_TIMtkZO1nNcjPTHR92xV8UY8HOOeCckzA&s"),],);
final selectedcultivoProvider = StateProvider<String?>((ref) => null);



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