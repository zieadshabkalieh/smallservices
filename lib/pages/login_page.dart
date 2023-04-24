import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smallservices/Services/auth.dart';
import 'package:smallservices/animation/FadeAnimation.dart';
import 'package:smallservices/components/my_button.dart';
import 'package:smallservices/components/my_textfield.dart';
import 'package:smallservices/components/square_tile.dart';
import 'package:smallservices/pages/forgot_password.dart';
import 'package:smallservices/pages/home.dart';
import 'package:smallservices/pages/phone_login_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();


  bool _isLoggingIn = false;

  bool _isPasswordHidden = true;

  String? _errorMessage;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

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
                          margin: EdgeInsets.only(top: 80, right: 90),
                          child: Center(
                            child: Container(
                              child: Text("تسجيل الدخول", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),),
                            ),
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
                                  hintText: 'البريد الالكتروني',
                                  obscureText: false,
                                  textInputType: TextInputType.emailAddress,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: MyTextField(
                                  controller: _passwordController,
                                  hintText: 'كلمة المرور',
                                  obscureText: _isPasswordHidden,

                                  icon: IconButton(
                                    icon: Icon(
                                      _isPasswordHidden
                                          ? Icons.visibility_off
                                          : Icons
                                          .visibility,
                                    ),
                                    onPressed: _togglePasswordVisibility,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              if (_errorMessage != null)
                                Text(
                                  _errorMessage!,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                            ],
                          ),
                        )),

                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                child: Text(
                                  'نسيت كلمة المرور؟',
                                  style: TextStyle(color: Colors.grey[600],),
                                ),
                                onTap: (){Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Forgotpassword()
                                    ));}
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 25,),
                        // sign in button
                        MyButton(
                          onTap: _isLoggingIn ? null : signUserIn,
                          child: _isLoggingIn
                              ? Container(
                            height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors
                                  .white),
                          ),
                              )
                              : Text('تسجيل الدخول',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),),),

                        const SizedBox(height: 20),

                        // or continue with
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 0.5,
                                  color: Colors.grey[400],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  'أو أكمل عم طريق',
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  thickness: 0.5,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // google + apple sign in buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // google button
                            InkWell(child: SquareTile(
                                imagePath: 'lib/images/google.png')
                              , onTap: () async {
                                await Auth().googleSignIn(context);
                              },),

                            SizedBox(width: 35),

                            // apple button
                            InkWell(child: SquareTile(
                                imagePath: 'lib/images/phone.png')
                              , onTap: () async {
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PhoneVerification()
                                    ));
                              },
                            )
                          ],
                        ),

                        const SizedBox(height: 50),
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

  // sign user in method
  void signUserIn() async {
    setState(() {
      _isLoggingIn = true;
      _errorMessage = null;
    });
    final email = _emailController.text;
    final password = _passwordController.text;
    if (_emailController.text.isNotEmpty) {
      try {
        //when we need to add the user to firestore
        if (email.isNotEmpty) {
          print("firebase email" + email);
          UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password,
          );
          print(userCredential);
          Auth.userCredential = userCredential;
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context) => DashboardScreen()
              ));
          print('Successfully signed up user ${Auth.userCredential.user!.uid}');
        }
      }
        on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found' || e.code == 'wrong-password') {
          setState(() {
            _errorMessage = 'خطأ في البريد الالكتروني او كلمة المرور';
          });
        } else {
          setState(() {
            _errorMessage = 'حدث خطأ الرجاء اعادة المحاولة';
          });
        }
      } catch (e) {
        setState(() {
          _errorMessage = 'حدث خطأ الرجاء اعادة المحاولة';
        });
        print(e);
      } finally {
        setState(() {
          _isLoggingIn = false;
        });
      }
      //     else {
      //       HapticFeedback.lightImpact();
      //       Auth.showSnackBar(context, 'Invalid Phone Number');
      //     }
      //   } catch (e) {
      //     Auth.showSnackBar(context, e.toString());
      //   }
      // } else {
      //   HapticFeedback.lightImpact();
      //   Auth.showSnackBar(context, 'Please Fill All Gaps');
      // }
    }
  }
}