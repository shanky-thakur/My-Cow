// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/home.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/util/customButtons.dart';
import 'package:flutter_application_1/util/snackBar.dart';

class PayOptions extends StatefulWidget {
  const PayOptions({super.key});

  @override
  State<PayOptions> createState() => _PayOptionsState();
}

class _PayOptionsState extends State<PayOptions> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      backgroundColor: Colors.grey[300],
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Home",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            buildCard(
              "assets/images/ott.jpg",
              "OTT",
              "30 days",
              "OTT is the most trending means of entertainment so don't lag behind and carry your own daily dose of tv shows, movies, series, all at the same place.",
              "1000",
            ),
            CustomButton(
              text: "Buy Ott",
              onPressed: () {
                Razorpay razorpay = Razorpay();
                var options = {
                  'key': 'rzp_test_h5pXO9jdiORQ2i',
                  'amount': 1000,
                  'name': 'My Cow',
                  'description': 'Purchase Service',
                  'retry': {'enabled': true, 'max_count': 1},
                  'send_sms_hash': true,
                  'prefill': {
                    'contact': '8888888888',
                    'email': 'test@razorpay.com'
                  },
                  'external': {
                    'wallets': ['paytm']
                  }
                };
                razorpay.on(
                    Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                    handlePaymentSuccessResponseOtt);
                razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                    handleExternalWalletSelected);
                razorpay.open(options);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            buildCard(
              "assets/images/broadband.jpg",
              "Broadband",
              "30 days",
              "Broadband service is the best solution for your daily data needs. We care about safety and also value your money by providing speedy network at low cost.",
              "2000",
            ),
            CustomButton(
              text: "Buy Broadband",
              onPressed: () {
                Razorpay razorpay = Razorpay();
                var options = {
                  'key': 'rzp_test_h5pXO9jdiORQ2i',
                  'amount': 2000,
                  'name': 'My Cow',
                  'description': 'Purchase Service',
                  'retry': {'enabled': true, 'max_count': 1},
                  'send_sms_hash': true,
                  'prefill': {
                    'contact': '8888888888',
                    'email': 'test@razorpay.com'
                  },
                  'external': {
                    'wallets': ['paytm']
                  }
                };
                razorpay.on(
                    Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                    handlePaymentSuccessResponseBroadband);
                razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                    handleExternalWalletSelected);
                razorpay.open(options);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            buildCard(
              "assets/images/cable.jpg",
              "Cable Service",
              "30 days",
              "Cable service is meant for providing undisturbed network experience for your television and also at a reasonable cost.",
              "3000",
            ),
            CustomButton(
              text: "Buy Cable",
              onPressed: () {
                Razorpay razorpay = Razorpay();
                var options = {
                  'key': 'rzp_test_h5pXO9jdiORQ2i',
                  'amount': 3000,
                  'name': 'My Cow',
                  'description': 'Purchase Service',
                  'retry': {'enabled': true, 'max_count': 1},
                  'send_sms_hash': true,
                  'prefill': {
                    'contact': '8888888888',
                    'email': 'test@razorpay.com'
                  },
                  'external': {
                    'wallets': ['paytm']
                  }
                };
                razorpay.on(
                    Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                    handlePaymentSuccessResponseCable);
                razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                    handleExternalWalletSelected);
                razorpay.open(options);
              },
            ),
          ],
        ),
      ),
    );
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    showSnackBar(context, "payment failed: ${response.message}");
  }

  void handlePaymentSuccessResponseOtt(PaymentSuccessResponse response) {
    showSnackBar(context, "payment successful : ${response.paymentId}");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Home(),
      ),
    );
  }

  void handlePaymentSuccessResponseBroadband(PaymentSuccessResponse response) {
    showSnackBar(context, "payment successful : ${response.paymentId}");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Home(),
      ),
    );
  }

  void handlePaymentSuccessResponseCable(PaymentSuccessResponse response) {
    showSnackBar(context, "payment successful : ${response.paymentId}");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Home(),
      ),
    );
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showSnackBar(context, "wallet name : ${response.walletName}");
  }

  Widget buildCard(String address, String name, String validity,
      String description, String price) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Container(
        width: 320,
        height: 600,
        color: Colors.red,
        child: Column(
          children: [
            Image.asset(address),
            Text(
              name,
              style: const TextStyle(
                fontSize: 29,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "$validity for $price rupees",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 5, 0),
              child: Text(
                description,
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
