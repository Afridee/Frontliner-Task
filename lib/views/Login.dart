import 'package:frontliners/statecontrollers/FirePhoneAuth.dart';
import 'package:frontliners/widgets/LoginButton.dart';
import 'package:frontliners/widgets/LoginTextFields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class enterPhoneNumber extends StatefulWidget {
  @override
  _enterPhoneNumberState createState() => _enterPhoneNumberState();
}

class _enterPhoneNumberState extends State<enterPhoneNumber> {

  TextEditingController phoneNumber;
  FirePhoneAuth firePhoneAuth = Get.put(FirePhoneAuth());
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    phoneNumber = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    phoneNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GetBuilder<FirePhoneAuth>(
        builder: (fpa){
          return ModalProgressHUD(
            inAsyncCall: fpa.loading,
            child: Scaffold(
                appBar: AppBar(
                  title: Text('Phone verification'),
                  elevation: 0.0,
                  backgroundColor: Colors.transparent,
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                        color: Color(0xff1fbfb7)
                    ),
                  ),
                ),
                body: fpa.verificationID == ''
                    ? Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/background.png"),
                        fit: BoxFit.cover,
                      ),
                    ),

                    child: Container(
                      child: ListView(
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Enter your phone number to verify and log in.',
                              style: TextStyle(
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff1fbfb7)),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          color: Colors.white,
                                          child: loginTextfield(
                                              labelText: 'Example: +8801910027738',
                                              hideText: false,
                                              textController: phoneNumber)),
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Center(
                                child: fpa.authExceptionMessageWhileLoggingWithPhone ==''? Text(
                                  '(Note: Select the country code and type the rest)',
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 10),
                                ) : Text(
                                  fpa.authExceptionMessageWhileLoggingWithPhone,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 10),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: InkWell(
                              child: loginCustomizedButton(buttonText: 'Send verification code'),
                              onTap: () {
                                firePhoneAuth.LogInWIthPhone(context, phoneNumber.text);
                              },
                            ),
                          ),
                        ],
                      ),
                    ))
                    : Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Color(0xfff3f3f3),
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Please enter the sms code we\'ve sent you.',
                            style: TextStyle(
                                fontSize: 28.0,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff1fbfb7)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
                            key: formKey,
                            // ignore: missing_required_param
                            child: PinCodeTextField(
                              appContext: context,
                              backgroundColor: Colors.transparent,
                              pinTheme: PinTheme(
                                selectedColor: Colors.white,
                                selectedFillColor: Colors.white,
                                activeColor: Colors.white,
                                inactiveFillColor: Colors.white,
                                inactiveColor: Colors.white,
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(5),
                                fieldHeight: 60,
                                fieldWidth: 40,
                                activeFillColor: Colors.white,
                              ),
                              pastedTextStyle: TextStyle(
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold,
                              ),
                              length: 6,
                              obscureText: false,
                              obscuringCharacter: '*',
                              animationType: AnimationType.fade,
                              cursorColor: Colors.black,
                              animationDuration: Duration(milliseconds: 300),
                              textStyle: TextStyle(fontSize: 20, height: 1.6),
                              enableActiveFill: true,
                              keyboardType: TextInputType.number,
                              boxShadows: [
                                BoxShadow(
                                  offset: Offset(0, 1),
                                  color: Colors.black12,
                                  blurRadius: 10,
                                )
                              ],
                              onCompleted: (pin) {
                                fpa.LogInWithOTP(context, pin);
                              },
                              beforeTextPaste: (text) {
                                // print("Allowing to paste $text");
                                return true;
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Center(
                              child: Text(
                                fpa.authExceptionMessageWhileLoggingWithOTP,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.red, fontSize: 10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ))
            ),
          );
        },
      ),
    );
  }
}