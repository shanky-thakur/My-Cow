// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_final_fields

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../util/snackBar.dart';
import 'package:flutter_application_1/otp.dart';
import 'package:flutter_application_1/model/userModel.dart';
import 'package:flutter_application_1/model/complaints.dart';

class AuthProvider extends ChangeNotifier {
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isExpiring = false;
  bool get isExpiring => _isExpiring;

  String? _uid;
  String get uid => _uid!;

  UserModel? _userModel;
  UserModel get userModel => _userModel!;

  ComplaintsModel? _complaintsModel;
  ComplaintsModel get complaintsModel => _complaintsModel!;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  AuthProvider() {
    checkSignIn();
  }

  void checkSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("is_signedin") ?? false;
    notifyListeners();
  }

  Future setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_signedin", true);
    _isSignedIn = true;
    notifyListeners();
  }

  Future setExpiring() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_expiring", true);
    _isExpiring = true;
    notifyListeners();
  }

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {
          throw Exception(error.message.toString());
        },
        codeSent: (verificationId, forceResendingToken) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Otp(verificationId: verificationId)));
        },
        timeout: const Duration(seconds: 120),
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);
      User? user = (await _firebaseAuth.signInWithCredential(creds)).user;
      if (user != null) {
        _uid = user.uid;
        onSuccess();
      }
      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> checkExistingUser() async {
    DocumentSnapshot snapshot =
        await _firebaseFirestore.collection("Users").doc(_uid).get();
    if (snapshot.exists) {
      print("User exists");
      return true;
    } else {
      print("new user");
      return false;
    }
  }

  void saveUserDataToFirebase(
      {required BuildContext context,
      required UserModel userModel,
      required Function onSuccess}) async {
    _isLoading = true;
    notifyListeners();
    try {
      userModel.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
      userModel.uid = _firebaseAuth.currentUser!.uid;
      userModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;

      _userModel = userModel;

      await _firebaseFirestore
          .collection("users")
          .doc(_uid)
          .set(userModel.tomap())
          .then((value) {
        onSuccess();
        _isLoading = false;
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  void saveUserComplaintToFirebase(
      {required BuildContext context,
      required ComplaintsModel complaintsModel,
      required Function onSuccess}) async {
    _isLoading = true;
    notifyListeners();
    try {
      complaintsModel.createdAt =
          DateTime.now().millisecondsSinceEpoch.toString();
      complaintsModel.uid = _firebaseAuth.currentUser!.uid;
      complaintsModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;

      _complaintsModel = complaintsModel;

      await _firebaseFirestore
          .collection("complaints")
          .doc(_uid)
          .set(complaintsModel.tomap())
          .then((value) {
        onSuccess();
        _isLoading = false;
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future getDataFromFirestore() async {
    await _firebaseFirestore
        .collection("users")
        .doc(_firebaseAuth.currentUser!.uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      _userModel = UserModel(
        createdAt: snapshot['createdAt'],
        phoneNumber: snapshot['phoneNumber'],
        uid: snapshot['uid'],
      );
      _uid = userModel.uid;
    });
  }

  Future saveDataToSp() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString(
      "user_model",
      jsonEncode(
        userModel.tomap(),
      ),
    );
  }

  Future saveComplaintToSp() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString(
      "complaints_model",
      jsonEncode(
        userModel.tomap(),
      ),
    );
  }

  Future getDataFromSp() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String data = s.getString("user_model") ?? "";
    _userModel = UserModel.fromMap(jsonDecode(data));
    _uid = _userModel!.uid;
    notifyListeners();
  }

  Future userSignOut() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await _firebaseAuth.signOut();
    _isSignedIn = false;
    notifyListeners();
    s.clear();
  }
}
