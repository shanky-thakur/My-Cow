import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/tnc.dart';
import 'package:flutter_application_1/util/snackBar.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_application_1/util/customButtons.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/provider/auth_provider.dart';
import 'package:flutter_application_1/home.dart';

class Otp extends StatefulWidget {
  final String verificationId;

  const Otp({super.key, required this.verificationId});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  String? otpCode;

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      backgroundColor: Colors.grey[300],
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title:
            const Text("Verification", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.black,
              ))
            : Center(
                child: Column(
                  children: [
                    const SizedBox(height: 45),
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/cow2.jpg'),
                      backgroundColor: Colors.transparent,
                      radius: 100,
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Pinput(
                        length: 6,
                        showCursor: true,
                        defaultPinTheme: PinTheme(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onCompleted: (value) => {
                          setState(() {
                            otpCode = value;
                          })
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: CustomButton(
                        text: "Verify",
                        onPressed: () {
                          if (otpCode != null) {
                            verifyOtp(context, otpCode!);
                          } else {
                            showSnackBar(context, "Enter 6-digit number");
                          }
                        },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(12, 30, 12, 10),
                      child: Text(
                        "Please enter the 6-digit code that has been sent to you",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  void verifyOtp(BuildContext context, String userOtp) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.verifyOtp(
      context: context,
      verificationId: widget.verificationId,
      userOtp: userOtp,
      onSuccess: () {
        ap.checkExistingUser().then(
          (value) async {
            if (value == true) {
              ap.getDataFromFirestore().then(
                    (value) => ap.saveDataToSp().then(
                          (value) => Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Home()),
                              (route) => false),
                        ),
                  );
            } else {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Tnc(),
                  ),
                  (route) => false);
            }
          },
        );
      },
    );
  }

  
}
