import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  // final List<Map<String, dynamic>> reportData; // list of maps containing report data

  const ReportScreen({Key? key
    // , required this.reportData
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report'),
      ),
      body: ListView.builder(
        itemCount: 0,
        itemBuilder: (BuildContext context, int index) {
          // final service = reportData[index];
          // final serviceName = service['service_name'];
          // final imageUrl = service['image_url'];
          // final question = service['question'];
          // final repetition = service['repetition'];
          // final dateTime = service['date_time'];
          // final subServices = service['sub_services'];

          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   height: 200,
                //   width: double.infinity,
                //   child: Text("imageURL")
                //   // Image.network(
                //   //   'imageUrl',
                //   //   fit: BoxFit.cover,
                //   // ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                   'serviceName',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('question'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Repetition: repetition'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Date and Time: dateTime'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Sub-Services:'),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    // final subService = subServices[index];
                    // final subServiceName = subService['sub_service_name'];
                    // final subServiceImageUrl = subService['sub_service_image_url'];

                    return Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.blue,
                            // backgroundImage: NetworkImage('subServiceImageUrl'),
                          ),
                        ),
                        Text('subServiceName'),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
