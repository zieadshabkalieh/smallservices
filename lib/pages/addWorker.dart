// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:smallservices/Services/auth.dart';
//
// class AddWorker extends StatelessWidget {
//   AddWorker({Key? key}) : super(key: key);
//   final CollectionReference usersCollection = FirebaseFirestore.instance.collection('/roles/مساج/users/');
//   Future<void> getUserData(String userId) async {
//     final DocumentSnapshot userDocument = await usersCollection.doc(userId).get();
//     final Map<String, dynamic> data = userDocument.data() as Map<String, dynamic>;
//     final String username = data['username'] as String;
//     final List<dynamic> roles = data['roles'] as List<dynamic>;
//     final String imageURL = data['imageURL'] as String;
//     print(username);
//     print(roles);
//     print(imageURL);
//   }
//   @override
//   Widget build(BuildContext context) {
//     getUserData(Auth.userCredential!.user!.uid);
//     print(Auth.userCredential);
//
//     return Container();
//   }
// }
