// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'welcome.dart';
import 'package:logo_n_spinner/logo_n_spinner.dart';
import 'package:flutter/services.dart';

class Spinner extends StatefulWidget {
  const Spinner({super.key});

  @override
  State<Spinner> createState() => _SpinnerState();
}

class _SpinnerState extends State<Spinner> {
  @override
  void initState() {
    super.initState();
    _navigatetoHome();
  }

  _navigatetoHome() async {
    // ignore: prefer_const_constructors
    await Future.delayed(Duration(milliseconds: 6000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Welcome()));
  }

  @override
  Widget build(BuildContext context) {

     SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      backgroundColor: Colors.grey[300],
      resizeToAvoidBottomInset: false,
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LogoandSpinner(
              imageAssets: 'assets/images/cow2.jpg',
            ),
          ],
        ),
      ),
    );
  }
}
