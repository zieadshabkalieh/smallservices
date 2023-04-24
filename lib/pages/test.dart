// // FutureBuilder(
// // future: databaseReference.child('Services').once(),
// // builder: (BuildContext context, AsyncSnapshot<DataSnapshot> snapshot) {
// // if (snapshot.hasData) {
// // DataSnapshot dataSnapshot = snapshot.data!;
// // var values = dataSnapshot.value;
// // List<List<String>> services = [];
// // if (values is List) {
// // values.forEach((item) {
// // List<String> service = [item["name"].toString(), item["imageURL"].toString(), item["question"].toString()];
// // services.add(service);
// // });
// // } else if (values is Map) {
// // values.forEach((key, item) {
// // List<String> service = [item["name"].toString(), item["imageURL"].toString(), item["question"].toString()];
// // services.add(service);
// // });
// // }
// // print(services[0][0]);
// // return Scaffold(
// // key: _scaffoldKey,
// // body: Builder(builder: (BuildContext context) {
// // if (_selectedIndex == 0) {
// // return Container(
// // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
// // height: 300,
// // child: GridView.builder(
// // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// // crossAxisCount: 3,
// // childAspectRatio: 1.0,
// // crossAxisSpacing: 10.0,
// // mainAxisSpacing: 10.0,
// // ),
// // physics: NeverScrollableScrollPhysics(),
// // itemCount: services.length,
// // itemBuilder: (BuildContext context, int index) {
// // return FadeAnimation(
// // (1.0 + index) / 4,
// // serviceContainer(services[index][1], services[index][0], index),
// // );
// // },
// // ),
// // );
// // } else {
// // // Handle other cases
// // return Container();
// // }
// // }),
// // );
// // } else {
// // // Handle the case where the data is not available yet
// // return CircularProgressIndicator();
// // }
// // },
// // );
//
// import 'package:flutter/material.dart';
//
// class GradientDrawer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [
//             Color(0xFF9B8AFF),
//             Color(0xFF6752FF),
//           ],
//         ),
//       ),
//       child: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             DrawerHeader(
//               child: Text(
//                 'Drawer Header',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24,
//                 ),
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.transparent,
//               ),
//             ),
//             ListTile(
//               leading: Icon(
//                 Icons.home,
//                 color: Colors.white,
//               ),
//               title: Text(
//                 'Home',
//                 style: TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             ListTile(
//               leading: Icon(
//                 Icons.settings,
//                 color: Colors.white,
//               ),
//               title: Text(
//                 'Settings',
//                 style: TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class CollectionEntryPage extends StatefulWidget {
  @override
  _CollectionEntryPageState createState() => _CollectionEntryPageState();
}

class _CollectionEntryPageState extends State<CollectionEntryPage> {
  final databaseReference = FirebaseDatabase.instance.ref();

  final _formKey = GlobalKey<FormState>();

  String? _serviceName;
  String? _imageUrl;
  String? _question;
  List<Map<String, String>> _subServices = [];


  @override
  void initState() {
    _addSubService();
  }

  void _addSubService() {
    setState(() {
      _subServices.add({'name': '', 'imageUrl': ''});
    });
  }

  Widget _buildSubServiceFields(int index) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Sub Service Name',
          ),
          onChanged: (value) {
            setState(() {
              _subServices[index]['name'] = value;
            });
          },
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Sub Service Image URL',
          ),
          onChanged: (value) {
            setState(() {
              _subServices[index]['imageUrl'] = value;
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Collection'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Service Name',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a service name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _serviceName = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Image URL',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an image URL';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _imageUrl = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Question',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a question';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _question = value;
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Sub Services',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 8),
                Column(
                  children: _subServices
                      .asMap()
                      .map(
                        (index, subService) => MapEntry(
                      index,
                      _buildSubServiceFields(index),
                    ),
                  )
                      .values
                      .toList(),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  child: Text('Add Sub Service'),
                  onPressed: _addSubService,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  child: Text('Save'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      databaseReference.child('Services').push().set({
                        'name': _serviceName,
                        'imageURL': _imageUrl,
                        'question': _question,
                        'sub_services': _subServices,
                      });
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
