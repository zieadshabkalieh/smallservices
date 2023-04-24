// ignore_for_file: file_names
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smallservices/pages/addService.dart';
import 'package:smallservices/pages/home.dart';

class AddQuestion extends StatefulWidget {
  final String name;
  final String imageURL;
  const AddQuestion({super.key, required this.name, required this.imageURL});
  @override
  // ignore: library_private_types_in_public_api
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _formKey = GlobalKey<FormState>();
  final _questionController = TextEditingController();
  final List<Map<String, String>> _subServices = [];
  final _imagePicker = ImagePicker();
  final _imageUploader = ImageUploader();
  final databaseReference = FirebaseDatabase.instance.ref();

  Future<void> _getImage(int index) async {
    final imageFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      final imageURL = await _imageUploader.uploadImage(File(imageFile.path));
      setState(() {
        _subServices[index]['imageURL'] = imageURL;
      });
    }
  }
  @override
  void initState() {
    super.initState();
    _addSubService();
  }

  Widget _buildSubServiceFields(int index) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: const InputDecoration(
              hintTextDirection: TextDirection.rtl,
              hintText: 'اسم الخيار',
            ),
            textDirection: TextDirection.ltr,
            onChanged: (value) {
              setState(() {
                _subServices[index]['name'] = value;
              });
            },
          ),
        ),
        const SizedBox(width: 10,),
        InkWell(
          child: _subServices[index]['imageURL'] != ''
              ? Image.network(
            _subServices[index]['imageURL']!,
            height: 20.0,
            width: 20.0,
          )
              :
              Icon(Icons.add, size: 40,color: Colors.grey.shade900,),
          onTap: () async {
            await _getImage(index);
          },
        ),
      ],
    );
  }


  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }
  void _addSubService() {
    setState(() {
      _subServices.add({'name': '', 'imageURL': ''});
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _questionController.text != '' && _subServices[0]['name'] != '' && _subServices[0]['imageURL'] != '' ? FloatingActionButton(onPressed: (){
        if (_formKey.currentState!.validate()) {

          Map<String, dynamic> serviceData = {
            'name': widget.name,
            'imageURL': widget.imageURL,
            'question': _questionController.text,
          };
          for (int i = 0; i < _subServices.length; i++) {
            serviceData[i.toString()] = _subServices[i];
          }
          databaseReference.child('Services').push().set(serviceData);
          //
          // String? serviceId = databaseReference.push().key;
          // databaseReference.child('Services').child(serviceId!).set({
          //   'name': widget.name,
          //   'imageURL': widget.imageURL,
          //   'question': _questionController.text,
          //   ..._subServices, // Spread the sub_services list as key-value pairs
          // });

          // databaseReference.child('Services').child(serviceId).set(_subServices
          // );
          Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) =>
                      const DashboardScreen()
              ));
        }
      },
      child: const Icon(Icons.arrow_forward_ios, size: 20,)) : const SizedBox(),
      appBar: AppBar(
        title: const Text('إنشاء سؤال',textDirection: TextDirection.rtl,),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _questionController,
                  decoration: const InputDecoration(
                    hintTextDirection: TextDirection.rtl,
                    hintText: 'السؤال',
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
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
                ),
                SizedBox(child: InkWell(
                  onTap: _addSubService,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("إضافة خيار",style: TextStyle(fontSize: 18)),
                      SizedBox(width: 20,),
                      Icon(Icons.add_box_outlined,size: 30,),
                    ],
                  ),
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}


