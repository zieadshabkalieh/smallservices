import 'package:flutter/material.dart';
import 'package:smallservices/pages/forgot_password.dart';

class Account extends StatelessWidget {
  const Account({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(child: Text("إعادة تعيين كلمة المرور"),onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(
              builder: (context) => Forgotpassword()
          ),
          );
        },
    ),
      ),
    );
  }
}