import 'package:basedatosimp/clases/datos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ListaDatos extends StatelessWidget{
  //final List<Datos> lista;
  //ListaDatos(this.lista);
  String downloadURL = "";

  Future<String> downloadURLExample(String foto) async {
    downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref(foto)
        .getDownloadURL();
    print("......................." + downloadURL);

    // Within your widgets:
    //Image.network(downloadURL);
   return downloadURL;
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       backgroundColor: Colors.black,
       title: Text('Datos Aspirantes'),
     ),
     body: StreamBuilder<QuerySnapshot>(
       stream:FirebaseFirestore.instance.collection('datos').snapshots(),//loadAllAspirantes(),
       builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> data) {
         if (!data.hasData) {
           return Center(
             child: CircularProgressIndicator(),
           );
         }
         return ListView(
             children: data.data!.docs.map((DocumentSnapshot document) {
                 return ListTile(
                 title: Text("Nombre: "+document.data()!['nombre']),
                 subtitle: Text("Correo: "+document.data()!['correo']+"\n"+
                                "Telefono: "+document.data()!['telefono']),

                   leading: Image(
                   image: NetworkImage(document.data()!['foto']),
                    // image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/datosbase-5fddd.appspot.com/o/IMG_2571.jpg?alt=media&token=84b28563-642f-403b-85f1-69459c598add'),
                   fit: BoxFit.fitHeight,
                   width: 50,
                 ),
                 );
             }).toList(),
         );
       }),
   );
  }

}