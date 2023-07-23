import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/util/customButtons.dart';
import 'SignUp.dart';
import 'home.dart';
import 'provider/auth_provider.dart';
import 'package:provider/provider.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      backgroundColor: Colors.grey[300],
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Welcome!", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 430,
                padding: const EdgeInsets.all(20.0),
                child: Image.asset('assets/images/welcome.jpg'),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
            child: Center(
              child: Text(
                "get started by creating an account with us or by signing in if you already signed in, just get started",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 5, 12, 12),
            child: Container(
              width: 200,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: CustomButton(
                    text: "Get Started",
                    onPressed: () async {
                      if (ap.isSignedIn == true) {
                        await ap.getDataFromSp().whenComplete(
                              () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Home(),
                                ),
                              ),
                            );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUp(),
                          ),
                        );
                      }
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
