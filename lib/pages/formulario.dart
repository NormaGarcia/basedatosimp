import 'package:basedatosimp/clases/datos.dart';
import 'package:basedatosimp/pages/imagenes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';


import 'listaDatos.dart';
import 'listaDatos2.dart';

class Formulario extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return miFormulario();
  }
}
class miFormulario extends State<Formulario>{
  final _controladorn= TextEditingController();
  final _controladorc= TextEditingController();
  final _controladort= TextEditingController();
  final _controladorf= TextEditingController();
  //List <Datos> _datos=[];
  Datos? dat=Datos("","","","");


  Future <void> guardarDatos(String nombre,String correo,String telefono,String foto){
    final datos = FirebaseFirestore.instance.collection('datos');
    return datos.add({
      'nombre': nombre,
      'correo': correo,
      'telefono': telefono,
      'foto' : foto
    });
  }

  /*Future<void> visualizafoto(String foto) async {

      downloadURL = await firebase_storage.FirebaseStorage.instance
          .ref(foto)
          .getDownloadURL();

    print("......................." + downloadURL);
    dat!.foto=downloadURL;
    guardarDatos(dat!.nombre,dat!.correo,dat!.telefono,dat!.foto);
    // Within your widgets:

  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       title: Text("Formulario"),
       backgroundColor: Colors.black,
     ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children:<Widget> [
              Padding(padding: EdgeInsets.all(10.00)),
              TextField(
                controller: _controladorn,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  border:OutlineInputBorder(),
                  labelText: 'Nombre: ',
                ),
              ),
              Padding(padding: EdgeInsets.all(10.00)),
              TextField(
                controller: _controladorc,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border:OutlineInputBorder(),
                  labelText: 'Correo: ',
                ),
              ),
              Padding(padding: EdgeInsets.all(10.00)),
              TextField(
                controller: _controladort,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border:OutlineInputBorder(),
                  labelText: 'Teléfono: ',
                ),
              ),
              Padding(padding: EdgeInsets.all(10.00)),
              IconButton(
                icon: const Icon(Icons.camera_alt),
                tooltip: 'Foto',
                onPressed: () {
                   Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return Imagenes();
                      }));
                },
              ),
              Text('F O T O'),
              /*TextField(
                controller: _controladorf,
                keyboardType: TextInputType.url,
                decoration: InputDecoration(
                  border:OutlineInputBorder(),
                  labelText: 'Foto: ',
                ),
              ),*/
              Padding(padding: EdgeInsets.all(20.00)),
              ElevatedButton(
                  onPressed: () {
                   dat!.nombre=_controladorn.text;
                   dat!.correo=_controladorc.text;
                   dat!.telefono=_controladort.text;
                   //visualizafoto(_controladorf.text+".jpg");
                   dat!.foto=Datos.downloadURL;
                   guardarDatos(dat!.nombre,dat!.correo,dat!.telefono,dat!.foto);
                  // Datos(_controladorn.text,_controladorc.text,_controladort.text,_controladort.text);

                  },
                  child: Text('Enviar')
              ),
             ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) {
                return searchScreen2();//ListaDatos();
              }));
        },
        child: Icon(Icons.arrow_forward),
        backgroundColor: Colors.black,
      ),
    );
  }


///////metodos para validar datos///////////
bool validarNombre(String cadena){
    RegExp exp=new RegExp(r'^[a-zA-z]+[ a-zA-Z]*$');
    if(cadena.isEmpty){
       return false;
    }else if(!exp.hasMatch(cadena)){
        return false;
      }
      else{
        return true;
      }
  }
  bool validarCorreo(String cadena){
    RegExp exp=new RegExp(
        r"(^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$)"
    );
    if(cadena.isEmpty){
      return false;
    }else if(!exp.hasMatch(cadena)){
      return false;
    }
    else{
      return true;
    }
  }
  bool validarTel(String cadena){
    RegExp exp=new RegExp(
        r"^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$"
    );
    if(cadena.isEmpty){
      return false;
    }else if(!exp.hasMatch(cadena)){
      return false;
    }
    else{
      return true;
    }
  }
////////alerta////////
void alerta(BuildContext context){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Alerta!!'),
            content: Text("Verifique la información"),
            actions:<Widget> [
              new ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text('OK')
              )
            ],
          );
        }
    );
}

}