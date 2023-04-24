import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smallservices/animation/FadeAnimation.dart';
import 'package:smallservices/pages/login_page.dart';
import 'package:smallservices/pages/signup.dart';

class TodoHomeOnePage extends StatelessWidget {
  final Color color1 = Color(0x00E5EfFF);
  final Color color2 = Color(0xff8EA7E9);
  final Color color3 = Color(0xff7286D3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHeader(),
              Container(
                height: 340,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("lib/images/mainlogo.png"),
                        fit: BoxFit.cover)),
            ),
            SizedBox(height: 5,),
            Center(
              child: FadeAnimation(1.5,
                Text(
                    'لديك مشكلة؟\n تحتاج مساعدة لا تقلق هيا نبدأ',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(textStyle: TextStyle(
                      color: Color(0xff6F1AB6),
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),)
                ),
              ),
            ),
            SizedBox(height: 35,),
        FadeAnimation(
          1.5,
          Padding(
            padding: EdgeInsets.only(left: 50.0, right: 50.0, bottom: 50.0),
            child: MaterialButton(
              elevation: 0,
              color: Color(0xff7286D3),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
              height: 55,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                    'تسجيل الدخول',
                    style: GoogleFonts.montserrat(textStyle: TextStyle(
                      color: Color(0xffE5E0FF),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),)
                ),
              ),
            ),
          ),
        ),
          ],
        ),
      ),
    );
  }

  Container _buildHeader() {
    return Container(
      height: 250,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            left: -100,
            top: -150,
            child: Container(
              width: 350,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [color1, color2]),
                  boxShadow: [
                    BoxShadow(
                        color: color2,
                        offset: Offset(4.0, 4.0),
                        blurRadius: 10.0)
                  ]),
            ),
          ),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [color3, color2]),
                boxShadow: [
                  BoxShadow(
                      color: color3, offset: Offset(1.0, 1.0), blurRadius: 4.0)
                ]),
          ),
          Positioned(
            top: 100,
            right: 200,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [color3, color2]),
                  boxShadow: [
                    BoxShadow(
                        color: color3,
                        offset: Offset(1.0, 1.0),
                        blurRadius: 4.0)
                  ]),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 100, left: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  textAlign: TextAlign.center,
                  "خدمات\nصغيرة",
                  style: GoogleFonts.montserrat(textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold),)
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
