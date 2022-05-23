import 'package:basedatosimp/pages/formulario.dart';
import 'package:basedatosimp/pages/googleauth.dart';
import 'package:basedatosimp/pages/imagenes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'pages/listaDatos.dart';
import 'pages/listaDatos2.dart';
import 'pages/listaDatos3.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Center(
        child:Formulario()//searchScreen2(),//Imagenes()
      ),
    );
    throw UnimplementedError();
  }
}