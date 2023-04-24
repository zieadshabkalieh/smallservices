import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smallservices/models/verifying.dart';
import 'package:smallservices/pages/home.dart';
import 'package:smallservices/pages/provider_controller.dart';
import 'package:smallservices/pages/start.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider<ProviderController>(
          create: (BuildContext context) => ProviderController(),
        ),
        ChangeNotifierProvider<Verifying>(
          create: (BuildContext context) => Verifying(),
        ),
      ],
      child: MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    print(user);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Page',
      theme: ThemeData(
        textTheme:
        GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:
      (user != null) ?  DashboardScreen() : TodoHomeOnePage()
    );
  }
}
