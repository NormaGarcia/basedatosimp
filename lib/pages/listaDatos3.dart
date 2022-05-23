//completo
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class searchScreen extends StatefulWidget {
  const searchScreen({Key? key}) : super(key: key);

  @override
  State<searchScreen> createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowOrder = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  Future<Query?> searchQuery() async {
    var query = FirebaseFirestore.instance.collection('datos');
    /*var query1 = query.where('requestingUser',
        isEqualTo: FirebaseAuth.instance.currentUser!.uid);*/
    var query2 =
    query.where('nombre', isGreaterThanOrEqualTo: searchController.text);
    return query2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: TextFormField(
          cursorColor: Colors.white,
          controller: searchController,
          decoration: const InputDecoration(
            hintText: 'Search for an order',
          ),
          style: TextStyle(color: Colors.black),
          onFieldSubmitted: (String searchQuery) {
            setState(() {
              isShowOrder = true;
              print(searchQuery);
            });
          },
        ),
      ),
      body: isShowOrder
          ? FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('datos')
        /*.where('requestingUser',
            isEqualTo: FirebaseAuth.instance.currentUser!.uid)*/
            .where('nombre', isGreaterThanOrEqualTo: searchController.text)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: (snapshot.data! as dynamic).docs.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  /*   return Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => orderScreen(
                      snap: (snapshot.data! as dynamic).docs[index],
                    ),
                  ),
                );*/
                },
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        (snapshot.data! as dynamic).docs[index]['foto']
                      // 'https://firebasestorage.googleapis.com/v0/b/futterene2022.appspot.com/o/aspirantes%2F5_3_2022_132706.jpg?alt=media&token=bbb1aebb-e33d-442e-ace5-be94d3876f71',
                    ),
                  ),
                  title: Text(
                    'Nombre: ${(snapshot.data! as dynamic).docs[index]['nombre'].toString()}',
                  ),
                  subtitle: Text(
                    'Correo: ${(snapshot.data! as dynamic).docs[index]['correo'].toString()}',
                  ),
                ),
              );
            },
          );
        },
      )
          : StreamBuilder<QuerySnapshot>(
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

                  /*  leading: Image(
                    image: NetworkImage(document.data()!['foto']),
                    // image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/datosbase-5fddd.appspot.com/o/IMG_2571.jpg?alt=media&token=84b28563-642f-403b-85f1-69459c598add'),
                    fit: BoxFit.fitHeight,
                    width: 50,
                  ),*/
                );
              }).toList(),
            );
          }),
      /*const
      ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
           // (snapshot.data! as dynamic).docs[index]['stage']
            'https://firebasestorage.googleapis.com/v0/b/futterene2022.appspot.com/o/aspirantes%2F5_3_2022_132706.jpg?alt=media&token=bbb1aebb-e33d-442e-ace5-be94d3876f71',
          ),
        ),
        title: Text(
          'Nombre: ',
        ),
        subtitle: Text(
          'Correo: ',
        ),
      ),*/
    );
  }
}

