import 'package:firebase_database/firebase_database.dart';

class Service {
  final String name;
  final String imageURL;

  Service(this.name, this.imageURL);
}

// Future<List<Service>> getServices() async {
//
//   // Initialize Firebase Realtime Database
//   final databaseReference = FirebaseDatabase.instance.reference();
//
//   // Fetch the services node from the database
//   DatabaseEvent servicesSnapshot = await databaseReference.child('services').once();
//
//   // Create a list of Service objects from the snapshot
//   List<Service> servicesList = [];
//   Map<dynamic, dynamic> servicesMap = servicesSnapshot.value;
//   servicesMap.forEach((key, value) {
//     String name = value['name'];
//     String imageUrl = value['imageUrl'];
//     Service service = Service(name, imageUrl);
//     servicesList.add(service);
//   });
//
//   // Return the list of Service objects
//   return servicesList;
// }
