// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/model/complaints.dart';
import 'package:flutter_application_1/provider/auth_provider.dart';
import 'package:flutter_application_1/util/customButtons.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/util/snackBar.dart';
import 'home.dart';
import 'package:http/http.dart' as http;

class Complaints extends StatefulWidget {
  const Complaints({super.key});

  @override
  State<Complaints> createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
  final complaintController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    complaintController.dispose();
  }

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
        title: const Text(
          "Complaints",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              )
            : ListView(
                children: [
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                        vertical: 40,
                        horizontal: 15,
                      ),
                      margin: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Column(
                        children: [
                          textField(
                            hintText: "type complaint here",
                            inputType: TextInputType.name,
                            maxLines: 20,
                            controller: complaintController,
                          ),
                          CustomButton(
                            text: "Send",
                            onPressed: () {
                              storeComplaint();
                              sendEmail();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void storeComplaint() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ComplaintsModel complaintsModel = ComplaintsModel(
      createdAt: "",
      phoneNumber: "",
      uid: "",
      complaint: complaintController.text.trim(),
    );
    ap.saveUserComplaintToFirebase(
      context: context,
      complaintsModel: complaintsModel,
      onSuccess: () {
        ap.saveComplaintToSp();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
        );
        showSnackBar(context, "Complaint registered successfully");
      },
    );
  }

  Widget textField({
    required String hintText,
    required TextInputType inputType,
    required int maxLines,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        cursorColor: Colors.purple,
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          hintText: hintText,
          alignLabelWithHint: true,
          border: InputBorder.none,
          fillColor: Colors.purple.shade50,
          filled: true,
        ),
      ),
    );
  }

  void sendEmail() {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    var serviceId = 'service_ld6spkq';
    var templateId = 'template_73ge8wb';
    var userId = 'vR-3mGxDJz4WE2L32';

    var s = http.post(
      Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
      headers: {
        'origin': 'http:localhost',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'service_id': serviceId,
        'user_id': userId,
        'template_id': templateId,
        'template_params': {
          'from_name': ap.uid,
          'message': complaintController.text,
        }
      }),
    );
    print(s.whenComplete(() => 'done'));
  }
}
