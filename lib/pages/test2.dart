import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:smallservices/Services/auth.dart';

class CollectionEntryPage extends StatefulWidget {
  @override
  _CollectionEntryPageState createState() => _CollectionEntryPageState();
}

class _CollectionEntryPageState extends State<CollectionEntryPage> {
  final databaseReference = FirebaseDatabase.instance.ref().child('Users').child(Auth.userCredential.user!.uid).child('Orders');

  final _formKey = GlobalKey<FormState>();

  String? _serviceName;
  String? _imageUrl;
  String? _question;
  List<Map<String, String>> _subServices = [];

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
                      String? orderId = databaseReference.push().key;
                      databaseReference.child(orderId!).push().set({
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
Welcome to Stack overflow
When writing to a specific cell within a table in Excel using openpyxl, you need to access the table using the ws._tables attribute and then modify the cell values using the table column and row indexes.

Here is an example code snippet that should write 'hello' to cell A2 in the table named 'DB' on 'sheet1' of the Excel workbook:


import openpyxl as xl

wb = xl.load_workbook('Test1.xlsx', read_only=False)
ws = wb['sheet1']

table = ws._tables['DB']
cell = table.cell(2,1)
cell.value = 'hello'

wb.save('Test1.xlsx')

In this code snippet, we first load the workbook and access the worksheet 'sheet1'. Then we access the table named 'DB' using the ws._tables attribute. We then use the cell method of the table to access the cell at row 2 and column 1 (which is cell A2 in the table). Finally, we set the value of the cell to 'hello' and save the workbook.

Note that it is important to call wb.save to actually save the changes made to the workbook.