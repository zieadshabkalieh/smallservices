import 'package:flutter/material.dart';
import 'package:smallservices/Services/auth.dart';
import 'package:smallservices/animation/FadeAnimation.dart';
import 'package:smallservices/pages/home.dart';

class Notifications extends StatelessWidget {
  Notifications({Key? key}) : super(key: key);

  List<String>Messages = ["حسم على جميع الخدمات %50","https://img.icons8.com/color/1x/nutanix.png","العرض صالح لمدة 15 يوم فقط"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return FadeAnimation((1.0 + index) / 4,
                  DashboardScreenState.workerContainer(Messages[0],
                  Messages[1],
                  Messages[2],
                  ''));
            }
        ),
      ),
      floatingActionButton: Auth.isManager ? FloatingActionButton(onPressed: (){},child: Icon(Icons.add)) : SizedBox()
    );
  }
}
