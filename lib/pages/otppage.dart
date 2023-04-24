import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:smallservices/Services/auth.dart';
import 'package:smallservices/models/verifying.dart';
import 'package:smallservices/pages/home.dart';

class OTP extends StatelessWidget {
  final String number;

  const OTP({required this.number, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Auth().verifyPhoneNumber(context, number);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff7f6fb),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: Colors.black54,
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'lib/images/verify.png',
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'التحقق',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                number,
                style: GoogleFonts.sahitya(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.purple)),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "ادخل رمز التحقق",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Consumer<Verifying>(
                  builder: (context, value, child) => PinCodeTextField(
                    autoDisposeControllers: false,
                    appContext: context,
                    pastedTextStyle: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      inactiveFillColor: Colors.white54,
                      inactiveColor: Colors.blueGrey,
                      selectedColor: Colors.grey.shade700,
                      selectedFillColor: Colors.yellow.shade100,
                      activeFillColor: Colors.green.shade100,
                      activeColor: Colors.greenAccent.shade400,
                    ),
                    cursorColor: Colors.brown,
                    enableActiveFill: true,
                    controller: value.code,
                    keyboardType: TextInputType.number,
                    boxShadows: const [
                      BoxShadow(
                        offset: Offset(0, 1),
                        color: Colors.black12,
                        blurRadius: 10,
                      )
                    ],
                    onCompleted: (v) async {
                      try {
                        await FirebaseAuth.instance
                            .signInWithCredential(PhoneAuthProvider.credential(
                                verificationId: value.verificationCode,
                                smsCode: v))
                            .then((value) {
                          if (value.user != null) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => DashboardScreen()));
                          }
                        });
                      } catch (e) {
                        FocusScope.of(context).unfocus();
                        Auth.showSnackBar(context, 'الرجاء المحاولة مرة أخرى');
                      }
                    },
                    onChanged: (value) {},
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                "لم يصل الرمز؟",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 18,
              ),
              InkWell(
                onTap: () {
                  Auth().verifyPhoneNumber(context, number);
                },
                child: Text(
                  "إعادة إرسال رمز التحقق",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
