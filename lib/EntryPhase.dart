import 'package:flutter/material.dart';
import 'package:frontliners/statecontrollers/FirePhoneAuth.dart';
import 'package:frontliners/views/Login.dart';
import 'package:frontliners/views/MyHomePage.dart';
import 'package:get/get.dart';

class EntryPhase extends StatefulWidget {
  @override
  _EntryPhaseState createState() => _EntryPhaseState();
}

class _EntryPhaseState extends State<EntryPhase> {

  FirePhoneAuth firePhoneAuth = Get.put(FirePhoneAuth());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FirePhoneAuth>(builder: (fpa){
      return StreamBuilder<User>(
        stream: fpa.onAuthStateChanged,
        builder: (_, AsyncSnapshot<User> snapshot){
          if(snapshot.connectionState == ConnectionState.active){
            final User user = snapshot.data;
            return user == null? enterPhoneNumber() : MyHomePage();
          }else{
            return Scaffold(
                body: Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
            );
          }
        },
      );
    });
  }
}
