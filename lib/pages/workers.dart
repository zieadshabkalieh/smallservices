import 'package:flutter/material.dart';
import 'package:smallservices/Services/auth.dart';
import 'package:smallservices/animation/FadeAnimation.dart';
import 'package:smallservices/pages/addWorker.dart';
import 'package:smallservices/pages/home.dart';
import 'package:smallservices/pages/signup.dart';
class Worker extends StatelessWidget {
  Worker({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text("المستخدمين"),),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: DashboardScreenState.users!.length,
            itemBuilder: (BuildContext context, int index) {
              var user = DashboardScreenState.users![index];
              return FadeAnimation((1.0 + index) / 4,
                  DashboardScreenState.workerContainer(
                      user['username'] ?? '',
                      user['imageURL'] ?? '',
                      user['career'] ?? '',
                      user['position'] ?? ''));
            }
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {

        // AddWorker().getUserData(Auth.userCredential!.user!.uid);
        // print(Auth.userCredential!.user!.uid);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SignupScreen()
          ),
        );
      },child: Icon(Icons.add),),
    );
  }
  }