import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smallservices/Services/auth.dart';
import 'package:smallservices/animation/FadeAnimation.dart';
import 'package:smallservices/components/my_button.dart';
import 'package:smallservices/components/my_textfield.dart';
import 'package:smallservices/components/square_tile.dart';
import 'package:smallservices/pages/country_picker.dart';
import 'package:smallservices/pages/login_page.dart';
import 'package:smallservices/pages/otppage.dart';
import 'package:smallservices/pages/provider_controller.dart';

class PhoneVerification extends StatelessWidget {
  PhoneVerification({super.key});


  // text editing controllers
  final usernameController = TextEditingController();

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
                                    border: Border(bottom: BorderSide(color: Colors.white))
                                ),
                                // username textfield
                                child: MyTextField(
                                  controller: usernameController,
                                  hintText: 'رقم الموبايل',
                                  textInputType: TextInputType.number,
                                  obscureText: false,
                                  icon: CountryPicker(),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        )),

                        SizedBox(height: 75,),
                        // sign in button
                        MyButton(onTap: (){signUserIn(context);}, child: Text('تسجيل الدخول',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),),),

                        const SizedBox(height: 30),

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
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
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

                        const SizedBox(height: 30),

                        // google + apple sign in buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // google button
                            InkWell(child: SquareTile(imagePath: 'lib/images/google.png')
                              , onTap: () async {
                                await Auth().googleSignIn(context);
                              },),

                            SizedBox(width: 35),

                            // apple button
                            InkWell(child: SquareTile(imagePath: 'lib/images/user.png')
                              , onTap: () async {
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()
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
  void signUserIn(context) async {
    if (usernameController.text.isNotEmpty) {
      try {
        //when we need to add the user to firestore
        // Auth().signIn(usernameController.text,Auth().currentUser!.getIdToken().toString());
        if (usernameController.text[0] == "0") {
          usernameController.text = usernameController.text.substring(1);
        }
        if(usernameController.text[0] == "9"){
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => OTP(
                  number: Provider.of<ProviderController>(
                      context,
                      listen: false)
                      .dialCodeDigits +
                      usernameController.text,
                )),
          );

        } else {
          HapticFeedback.lightImpact();
          Auth.showSnackBar(context, 'خطأ برقم الموبايل');
        }
      } catch (e) {
        print(e.toString());
        Auth.showSnackBar(context, "حدث خطأ الرجاء المحاولة مجددا");
      }
    } else {
      HapticFeedback.lightImpact();
      Auth.showSnackBar(context, 'الرجاء ملأ جميع الحقول');
    }
  }
}