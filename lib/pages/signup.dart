import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smallservices/Services/auth.dart';
import 'package:smallservices/animation/FadeAnimation.dart';
import 'package:smallservices/components/my_button.dart';
import 'package:smallservices/components/my_textfield.dart';
import 'package:smallservices/pages/home.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // text editing controllers
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isSigningUp = false;
  bool _isPasswordHidden = true;

  String? _errorMessage;

//make the default is first item
  String? _selectedRole;
  String imageURL = "https://img.icons8.com/fluency/1x/gender-neutral-user.png";

  List<String> _roles = [
    'تنظيف',
    'مكياج',
    'الكتروني',
    'دهان',
    'مساج',
    'طباخ',
  ];

  int _selectedOption = 0;

  void _handleRadioValueChange(int? value) {
    setState(() {
      _selectedOption = value!;
    });
  }

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
              height: 250,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('lib/images/background.png'),
                      fit: BoxFit.fill)),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 30,
                    width: 80,
                    height: 150,
                    child: FadeAnimation(
                        1,
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('lib/images/light-1.png'))),
                        )),
                  ),
                  Positioned(
                    left: 140,
                    width: 80,
                    height: 100,
                    child: FadeAnimation(
                        1.3,
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('lib/images/light-2.png'))),
                        )),
                  ),
                  Positioned(
                    right: 40,
                    top: 40,
                    width: 80,
                    height: 100,
                    child: FadeAnimation(
                        1.5,
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('lib/images/clock.png'))),
                        )),
                  ),
                  Positioned(
                    child: FadeAnimation(
                        1.6,
                        Container(
                          margin: EdgeInsets.only(top: 95, right: 160),
                          child: Center(
                            child: Text(
                              "إنشاء حساب",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: imageURL != "https://img.icons8.com/fluency/1x/gender-neutral-user.png"
                                  ? Image.network(
                                      imageURL,
                                      height: 130.0,
                                      width: 130.0,
                                    )
                                  : Stack(children: [
                                      Image.network(
                                        "https://img.icons8.com/fluency/1x/gender-neutral-user.png",
                                      ),
                                      Positioned(
                                        child: Icon(
                                          Icons.add,
                                          size: 30,
                                          color: Colors.grey.shade900,
                                        ),
                                        left: 25,
                                        bottom: 25,
                                      ),
                                    ]),
                            ),
                            Text("أضف صورة شخصية")
                          ],
                        ),
                        onTap: () {
                          setState(() async {
                            imageURL = await Auth().getImage().toString();
                          });
                        },
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Column(
                        children: [
                          Container(
                            width: 150,
                            child: DropdownButtonFormField<String?>(
                              hint: Text("المهنة"),
                              value: _selectedRole,
                              items: _roles
                                  .map((role) => DropdownMenuItem<String?>(
                                        child: Text(role),
                                        value: role,
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedRole = value;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // SizedBox(width: 250,),
                              Text(
                                ":نوع المستخدم",
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Radio(
                                value: 0,
                                groupValue: _selectedOption,
                                onChanged: _handleRadioValueChange,
                              ),
                              Text('زبون'),
                              // SizedBox(width: 20,),
                              Radio(
                                value: 1,
                                groupValue: _selectedOption,
                                onChanged: _handleRadioValueChange,
                              ),
                              Text('مدير'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FadeAnimation(
              1.7,
              Padding(
                  padding:
                      EdgeInsets.only(bottom: 30.0, left: 30.0, right: 30.0),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(
                          1.8,
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(143, 148, 251, .2),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                const SizedBox(height: 10),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom:
                                              BorderSide(color: Colors.white))),
                                  // username textfield
                                  child: MyTextField(
                                    controller: _usernameController,
                                    hintText: 'اسم المستخدم',
                                    obscureText: false,
                                    textInputType: TextInputType.name,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom:
                                              BorderSide(color: Colors.white))),
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
                                            : Icons.visibility,
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

                      const SizedBox(height: 50),
                      // sign in button
                      MyButton(
                        onTap: _isSigningUp ? null : signUserUp,
                        child: _isSigningUp
                            ? Container(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )
                            : Text(
                                'إنشاء حساب',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      )),
    );
  }

  // sign user in method
  void signUserUp() async {
    setState(() {
      _isSigningUp = true;
      _errorMessage = null;
    });

    final username = _usernameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      if (email != null &&
          username != null &&
          _selectedOption != null &&
          _selectedRole != null &&
          password != null) {
        Auth().registerUser(email, username, imageURL,
            _selectedOption == 0 ? "زبون" : "مدير", _selectedRole!, password);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => DashboardScreen()));
      } else {
        _errorMessage = 'الرجاء ملأ جميع معلومات المستخدم';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
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
        _isSigningUp = false;
      });
    }
  }
}
