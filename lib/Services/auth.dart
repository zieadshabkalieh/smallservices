import 'dart:io';
import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:smallservices/models/verifying.dart';
import 'package:smallservices/pages/addService.dart';
import 'package:smallservices/pages/home.dart';
import 'package:smallservices/pages/start.dart';
//TODO 1-dispose splash screen 2- when we get back from otp to main screen we should kill it
abstract class AuthBase {
  // Future<User?> signInWithEmailAndPassword(String email, String password);

  // Future<User?> signUpWithEmailAndPassword(String email, String password);

  // Future<void> signInwithPhoneNumber(String verificationId, String smsCode,
  //     BuildContext context);

  User? get currentUser;

  Stream<User?> authStateChanges();

  Future<void> signIn(String email, String password);

  Future<void> registerUser(String email, String username, String imageURL, String position, String career, String password);

  Future<List<List<String>>> getServices();

  Future<List<List<String>>> getUsers();

  Future googleSignIn(BuildContext context);

  Future<void> verifyPhoneNumber(BuildContext context, String number);

  Future<void> logout(BuildContext context);
}

class Auth implements AuthBase {
  static bool isManager = true;
  final _firebaseAuth = FirebaseAuth.instance;
  final databaseReference = FirebaseDatabase.instance.ref();
  static late final UserCredential userCredential;
  final storage = const FlutterSecureStorage();
  // final CollectionReference rolesCollection = FirebaseFirestore.instance.collection('roles');
  static final firebaseFirestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  // @override
  // Future<User?> signInWithEmailAndPassword(String email, String password) async {
  //   final userAuth = await _firebaseAuth.signInWithEmailAndPassword(
  //       email: email, password: password);
  //   return userAuth.user;
  // }

  // @override
  // Future<User?> signUpWithEmailAndPassword(String email,
  //     String password) async {
  //   final userAuth = await _firebaseAuth.createUserWithEmailAndPassword(
  //       email: email, password: password);
  //   return userAuth.user;
  // }

  // @override
  // Future<void> signInwithPhoneNumber(
  //     String verificationId, String smsCode, BuildContext context)
  // async {
  //   try {
  //     AuthCredential credential = PhoneAuthProvider.credential(
  //         verificationId: verificationId, smsCode: smsCode);
  //     UserCredential userCredential =
  //     await _firebaseAuth.signInWithCredential(credential);
  //     storeTokenAndData(userCredential);

  // Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  //     showSnackBar(context, "logged In");
  //   } catch (e) {
  //     showSnackBar(context, e.toString());
  //   }
  // }

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  // @override
  // Future<void> addUser(String email, String password, String pos) async {
  //   try {
  //     User? currentUser = FirebaseAuth.instance.currentUser;
  //     if (currentUser != null) {
  //       FirebaseFirestore.instance.collection('users').doc(currentUser.uid).set({
  //         'email': email,
  //         'password': password,
  //         'position': pos
  //       });
  //     }
  //   } catch (e) {
  //     // Handle any errors that occur during adding user to firestore
  //     print(e.toString());
  //   }
  // }

  // Future<void> registerWithEmailAndPassword(String email, String password) async {
  //   try {
  //     UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  Future<String?> getImage() async {
    final _imagePicker = ImagePicker();
    final _imageUploader = ImageUploader();
    final imageFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      final imageUrl = await _imageUploader.uploadImage(File(imageFile.path));
      return imageUrl;
    }
  }
  @override
  Future<List<List<String>>> getServices() async {
    var event = await databaseReference.child('Services').once();
    DataSnapshot dataSnapshot = event.snapshot;
    var values = dataSnapshot.value;
    List<List<String>> services = [];
    if (values is List) {
      values.forEach((item) {
        List<String> service = [item["name"].toString(), item["imageURL"].toString(), item["question"].toString()];
        services.add(service);
      });
    } else if (values is Map) {
      values.forEach((key, item) {
        List<String> service = [item["name"].toString(), item["imageURL"].toString(), item["question"].toString()];
        services.add(service);
      });
    }
    return services;
  }

  @override
  Future<List<List<String>>> getUsers() async {
    var event = await databaseReference.child('Users').once();
    DataSnapshot dataSnapshot = event.snapshot;
    var values = dataSnapshot.value;
    List<List<String>> users = [];
    if (values is List) {
      values.forEach((item) {
        List<String> user = [item["name"].toString(), item["imageURL"].toString(), item["career"].toString(), item["position"].toString()];
        users.add(user);
      });
    } else if (values is Map) {
      values.forEach((key, item) {
        List<String> user = [item["name"].toString(), item["imageURL"].toString(), item["career"].toString(), item["position"].toString()];
        users.add(user);
      });
    }
    return users;
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Auth.userCredential = userCredential;
      // Retrieve user data from Firestore
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).get();
      Map<String, dynamic>? userData = userSnapshot.data() as Map<String, dynamic>?;
      if (userData != null) {
        String role = userData['role'];
        // Navigate to appropriate screen based on user role
        if (role == 'manager') {
          isManager = true;
        } else {
          isManager = false;
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> registerUser(String email, String username, String imageURL, String position, String career, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await firebaseFirestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'username': username,
        'imageURL': imageURL,
        'position': position,
        'career': career,
        'password': password
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Future googleSignIn(BuildContext context, [bool mounted = true]) async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardScreen()
        ),
      );
      showSnackBar(context, userCredential.user!.displayName.toString());
    } catch (e) {
      showSnackBar(context, "حدث خطأ الرجاء المحاولة لاحقا");
      print(e.toString());
    }
  }

  @override
  Future<void> verifyPhoneNumber(BuildContext context, String number) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: (PhoneAuthCredential credential) async {},
      verificationFailed: (FirebaseException e) {
        showSnackBar(context, "حدث خطأ الرجاء المحاولة مجددا");
        print(e.toString());
      },
      codeSent: (String vID, int? resendToken, [bool mounted = true]) async {
        Provider.of<Verifying>(context, listen: false).changevID(vID);
        String? code;
        try {
          code = await AltSmsAutofill().listenForSms;
        } catch (e) {
          showSnackBar(context, "حدث خطأ الرجاء المحاولة مجددا");
          print(e.toString());
        }
        if (!mounted) return;
        Provider.of<Verifying>(context, listen: false).setCode(code.toString());
      },
      codeAutoRetrievalTimeout: (String vID) {
        showSnackBar(context, 'ِتم تسجيل الدخول بنجاح');
      },
      timeout: const Duration(seconds: 5),
    );
  }

  @override
  Future<void> logout(BuildContext context) async {
    try {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
      await storage.delete(key: "token");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TodoHomeOnePage()
          )
      );
    } catch (e) {
      showSnackBar(context, "حدث خطأ الرجاء المحاولة مجددا");
      print(e.toString());
    }
  }

  // void storeTokenAndData(UserCredential userCredential) async {
  //   await storage.write(key: "credential", value: userCredential.toString());
  // }
  //
  // Future<String> getCredentials() async {
  //   String? credentialString = await storage.read(key: "credential");
  // }
  static void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text.toString())));
  }
}