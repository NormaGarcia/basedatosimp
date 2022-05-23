import 'dart:io';

import 'package:basedatosimp/clases/datos.dart';
import 'package:basedatosimp/pages/formulario.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:intl/intl.dart';

class Imagenes extends StatefulWidget{
  @override
  MiImagen createState() {
    return MiImagen();
  }
}

class MiImagen extends State<Imagenes>{
 // File? imageFile;//= new File('/Users/normagarcia/NORMA/Flutter/Agosto21/accesoadatos/assets/escudo.png');
  final picker = ImagePicker();
  File? imageFile;
  String reffoto = "";
  String nomfoto = "";

  Datos? dat=Datos("","","","");
  Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Seleccione opcion para foto"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: Text("Galeria"),
                      onTap: () {
                        abrirGaleria(context);
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text("Cámara"),
                      onTap: () {
                        abrirCamara(context);
                      },
                    )
                  ],
                ),
              ));
        });
  }

  void abrirGaleria(BuildContext context) async {
    final picture = await picker.getImage(source: ImageSource.gallery);
    this.setState(() {
      // imageFile = picture;
      imageFile = File(picture!.path);
    });
    Navigator.of(context).pop();

  }

  void abrirCamara(BuildContext context) async {
    final picture = await picker.getImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = File(picture!.path);
    });
    Navigator.of(context).pop();

  }

  void enviarImagen() async {
      firebase_storage.FirebaseStorage.instance
          .ref(reffoto+'.jpg')
          .putFile(imageFile!);

  }

  Future<void> visualizafoto() async {
    print("si entra!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    Future.delayed(Duration(seconds: 5), () async{
      String urll= await firebase_storage.FirebaseStorage.instance.ref(reffoto+".jpg").getDownloadURL();
      Datos.downloadURL=urll.toString();
      print('ENVIADA............'+Datos.downloadURL);
      //dat!.foto=Datos.downloadURL;
      });
    print('ENVIANDO IMAGEN............');

  }


  Widget mostrarImagen() {
    if (imageFile != null) {
      return Image.file(imageFile!, width: 500, height: 500);

    } else {
      return Text("Seleccione una Imagen");
    }
  }

  @override
 Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            mostrarImagen(),
            Padding(padding: new EdgeInsets.all(30.00)),
            IconButton(
                icon: Icon(Icons.send_and_archive),
                onPressed: () {
                  nomfoto=(DateFormat.yMd().add_Hms().format(DateTime.now())).toString();
                  reffoto = "aspirantes/" +( nomfoto.replaceAll("/", "_").replaceAll(" ", "_").replaceAll(":", ""));
                  enviarImagen();
                  visualizafoto();
                  Navigator.of(context).pop();
                }
            ),
           /* IconButton(
                icon: Icon(Icons.arrow_downward),
                onPressed: () {
                  imageFile=null;
                  descargarImagen();
                  mostrarImagen();
                }
            )*/
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showSelectionDialog(context);
        },
        child: Icon(Icons.camera_alt),
      ),
    );
  }

}

