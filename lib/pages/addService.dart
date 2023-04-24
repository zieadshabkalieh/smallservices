import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smallservices/Services/auth.dart';
import 'package:smallservices/animation/FadeAnimation.dart';
import 'package:smallservices/pages/addQuestion.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add Service Collection',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AddServiceCollection(),
    );
  }
}

class AddServiceCollection extends StatefulWidget {
  @override
  _AddServiceCollectionState createState() => _AddServiceCollectionState();
}

class _AddServiceCollectionState extends State<AddServiceCollection> {
  String? _name;
  String? _imageUrl;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إنشاء خدمة'),
      ),
      body:
            Center(
              child: Container(
                width: 250,
                height: 250,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 1.0,
                        crossAxisSpacing: 20.0,
                        mainAxisSpacing: 20.0,
                      ),
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return FadeAnimation(1, AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          // padding: EdgeInsets.all(2.0),
                          child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                InkWell(
                                  child: _imageUrl != null
                                      ? Image.network(
                                    _imageUrl!,
                                    height: 130.0,
                                    width: 130.0,
                                  )
                                      : Icon(Icons.add, size: 130,color: Colors.grey.shade900,),
                                  onTap: () {
                                    setState(() async {
                                      _imageUrl = await Auth().getImage();
                                    });
                                      },
                                ),
                                SizedBox(height: 20,),
                                TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      _name = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintTextDirection: TextDirection.rtl,
                                    hintText: 'ادخل اسم الخدمة',
                                  ),
                                ),
                              ]
                          ),
                        )
                        );
                      }
                  ),
                ),
              ),
            ),

            // SizedBox(height: 16.0),
            // ElevatedButton(
            //   onPressed: () {
            //     // Perform validation and processing here
            //     if (_name != null && _imageUrl != null) {
            //       print('Name: $_name');
            //       print('Image URL: $_imageUrl');
            //     }
            //   },
            //   child: Text('Save'),
            // ),
      floatingActionButton: _name!=null && _imageUrl!=null ? FloatingActionButton(onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddQuestion(name: _name!, imageURL: _imageUrl!,)));
      },child: Icon(Icons.arrow_forward_ios, size: 20,),) : SizedBox(),
    );
  }
}

class ImageUploader {
  final _storage = FirebaseStorage.instance;

  Future<String> uploadImage(File image) async {
    final Reference storageRef = _storage.ref().child('images/${DateTime.now().millisecondsSinceEpoch}');
    final UploadTask uploadTask = storageRef.putFile(image);
    final TaskSnapshot storageSnapshot = await uploadTask.whenComplete(() => null);

    // if (storageSnapshot.error != null) {
    //   throw Exception('Error uploading image: ${storageSnapshot.error}');
    // }

    final String downloadUrl = await storageSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

}
