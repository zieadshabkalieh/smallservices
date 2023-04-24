import 'package:flutter/material.dart';
import 'package:smallservices/Services/auth.dart';
import 'package:smallservices/pages/addService.dart';
import 'package:smallservices/pages/select_service.dart';
import 'package:smallservices/pages/signup.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(
                  child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Image.network(
                    "https://img.icons8.com/color/1x/nutanix.png",
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'خدمات داليكس',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ],
              )),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blue.shade400,
                    Colors.blue.shade300,
                    Colors.blue.shade200,
                    Colors.blue.shade100,
                  ],
                  stops: [0.1, 0.4, 0.7, 1],
                ),
              ),
            ),
            Auth.isManager ? ListTile(
              leading: Icon(
                Icons.add_reaction_outlined,
                size: 30,
              ),
              title: Text(
                'إنشاء حساب',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SignupScreen()));
              },
            ) : SizedBox(),
            ListTile(
              leading: Icon(
                Icons.new_label_outlined,
                size: 30,
              ),
              title: Text(
                'طلب خدمة',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SelectService()));
              },
            ),
            Auth.isManager ? ListTile(
              leading: Icon(
                Icons.add_box_outlined,
                size: 30,
              ),
              title: Text(
                'إنشاء خدمة',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => AddServiceCollection()
                    ));
              },
            ) : SizedBox(),
            ListTile(
              leading: Icon(
                Icons.logout,
                size: 30,
              ),
              title: Text(
                'تسجيل الخروج',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              onTap: () {
                Auth().logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
