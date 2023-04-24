import 'package:flutter/material.dart';
import 'package:smallservices/Services/auth.dart';
import 'package:smallservices/animation/FadeAnimation.dart';
import 'package:smallservices/pages/addService.dart';
import 'package:smallservices/pages/home.dart';
import 'package:smallservices/pages/test.dart';
class ViewServices extends StatelessWidget {
  ViewServices({Key? key,}) : super(key: key);
  List<List<String>> services = DashboardScreenState.services;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text("الخدمات"),),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: services.length,
            itemBuilder: (BuildContext context, int index) {
              return FadeAnimation((1.0 + index) / 4,
                  DashboardScreenState.workerContainer(services[index][0],
                      "",
                      services[index][1],
                  ''));
            }
        ),
      ),
      floatingActionButton: Auth.isManager ? FloatingActionButton(onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddServiceCollection()
          ),
        );
      },child: Icon(Icons.add),) : SizedBox()
    );
  }
}