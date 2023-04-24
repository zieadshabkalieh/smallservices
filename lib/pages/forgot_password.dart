import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smallservices/animation/FadeAnimation.dart';
import 'package:smallservices/components/my_button.dart';
import 'package:smallservices/components/my_textfield.dart';
class Forgotpassword extends StatefulWidget {
  Forgotpassword({Key? key}) : super(key: key);

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 320,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('lib/images/background.png'),
                          fit: BoxFit.fill
                      )
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 30,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(1, Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('lib/images/light-1.png')
                              )
                          ),
                        )),
                      ),
                      Positioned(
                        left: 140,
                        width: 80,
                        height: 100,
                        child: FadeAnimation(1.3, Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('lib/images/light-2.png')
                              )
                          ),
                        )),
                      ),
                      Positioned(
                        right: 40,
                        top: 40,
                        width: 80,
                        height: 100,
                        child: FadeAnimation(1.5, Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('lib/images/clock.png')
                              )
                          ),
                        )),
                      ),
                      Positioned(
                        child: FadeAnimation(1.6, Container(
                          margin: EdgeInsets.only(top: 80, right: 150),
                          child: Center(
                            child: Text("إعادة تعيين\nكلمة المرور", style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),),
                          ),
                        )),
                      ),
                    ],
                  ),
                ),
                FadeAnimation(1.7,
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      children: <Widget>[
                        FadeAnimation(1.8, Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(143, 148, 251, .2),
                                    blurRadius: 20.0,
                                    offset: Offset(0, 10)
                                )
                              ]
                          ),
                          child: Column(
                            children: <Widget>[
                              const SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(color: Colors.white))
                                ),
                                // username textfield
                                child: MyTextField(
                                  controller: _emailController,
                                  hintText: 'بريدك الالكتروني',
                                  obscureText: false,
                                  textInputType: TextInputType.emailAddress,
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        )),
                        const SizedBox(height: 15),
                        // sign in button
                        MyButton(
                          onTap: _forgotPassword,
                          child: Text('إعادة تعيين كلمة المرور',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),),),

                        const SizedBox(height: 30),

                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }

  void _forgotPassword() async {
    final email = _emailController.text;
    try {
      if(email.isNotEmpty) {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: email,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('تم ارسال طلب اعادة تعيين كلمة المرور على بريدك الالكتروني'),
          ),
        );
        print(email.toString());
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('حدث خطأ الرجاء المحاولة مرة أخرى'),
        ),
      );
      print(e);
    }
  }
}
