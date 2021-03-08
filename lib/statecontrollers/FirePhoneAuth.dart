import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart' as fba;

class User {
  const User({@required this.uid});
  final String uid;
}

class FirePhoneAuth extends GetxController{

  String userID = '';
  String authExceptionMessageWhileLoggingWithPhone = '';
  String authExceptionMessageWhileLoggingWithOTP = '';
  String verificationID = '';
  int resendingToken;
  bool loading = false;

  void pauseInput() {
    Timer(Duration(seconds: 10),(){
      loading = !loading ;
      update();
    });
    loading  = !loading;
    update();
  }

  User _userFromFirebase(fba.User user) {
    return user == null ? null : User(uid: user.uid);
  }

  Stream<User> get onAuthStateChanged {
    return fba.FirebaseAuth.instance.authStateChanges().map(_userFromFirebase);
  }

  getCurrentUserUID(){
    try{
      final auth = fba.FirebaseAuth.instance;
      final fba.User user = auth.currentUser;
      userID = user.uid;
      update();
    }catch(e){
      print(e);
    }
  }

  LogInWithOTP(BuildContext context, String smsCode) async{
    final _firebaseAuth = fba.FirebaseAuth.instance;
    try{
      fba.AuthCredential authCreds = fba.PhoneAuthProvider.credential(verificationId: verificationID, smsCode: smsCode.trim());
      await _firebaseAuth.signInWithCredential(authCreds);
      getCurrentUserUID();
    }catch(e){
      print(e);
      authExceptionMessageWhileLoggingWithOTP = e.message;
      update();
    }
  }

  Future<void> LogInWIthPhone(BuildContext context, String phoneNumber) async{

    pauseInput();

    final _firebaseAuth = fba.FirebaseAuth.instance;

    final fba.PhoneVerificationCompleted verified = (fba.AuthCredential authresult) async{
      await _firebaseAuth.signInWithCredential(authresult);
      getCurrentUserUID();
    };

    final fba.PhoneVerificationFailed verificationfailed = (fba.FirebaseAuthException authException){
      print(authException.message);
      authExceptionMessageWhileLoggingWithPhone = authException.message;
      update();
    };

    final fba.PhoneCodeSent smsSent = (String verId, int forceResend){
       verificationID = verId;
       resendingToken = forceResend;
       update();
    };


    final fba.PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId){
      verificationID = verId;
      update();
    };

    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout,
        forceResendingToken: resendingToken
    );
  }

}