// ignore_for_file: unused_element, avoid_print

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/SignUp.dart';
import 'package:flutter_application_1/aboutus.dart';
import 'package:flutter_application_1/complaints.dart';
import 'package:flutter_application_1/contacts.dart';
import 'package:flutter_application_1/faqs.dart';
import 'package:flutter_application_1/plans.dart';
import 'package:flutter_application_1/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/util/snackBar.dart';
import 'package:flutter_application_1/util/customButtons.dart';
import 'payOptions.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int activeIndex = 0;

  final list = [
    'assets/images/OTT_SERVICE.jpg',
    'assets/images/BROADBAND_SERVICE.jpg',
    'assets/images/CABLE_SERVICE.jpg'
  ];

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
      drawer: const NavigationDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: CarouselSlider.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index, realIndex) {
                    final img = list[index];
                    return imgBuild(img, index);
                  },
                  options: CarouselOptions(
                    height: 400,
                    autoPlay: true,
                    onPageChanged: (index, reason) =>
                        setState(() => activeIndex = index),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(12, 10, 10, 10),
              child: Text(
                "Why Choose Us?",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(12, 10, 10, 10),
              child: Text(
                "Anonet Communications Private Limited is a Private incorporated on 26 May 2016. It is classified as Non-govt company and is registered at Registrar of Companies, Delhi. Its authorized share capital is Rs. 1,000,000 and its paid up capital is Rs. 652,750. It is inolved in Telecommunications [Production of radio and television programmes, whether or not combined with broadcasting, is classified under class 9213 Anonet Communications Private Limited's Annual General Meeting (AGM) was last held on 29 September 2022 and as per records from Ministry of Corporate Affairs (MCA), its balance sheet was last filed on 31 March 2022. Directors of Anonet Communications Private Limited are Rajeev Garg and Preeti Garg. Anonet Communications Private Limited's Corporate Identification Number is (CIN) U64204DL2016PTC300429 and its registration number is 300429.Its Email address is rajeev@aninetwork.in and its registered address is A-148, BASEMENT PRIYA DARSHANI VIHAR LAXMI NAGAR NEW DELHI East Delhi DL 110092 IN . Current status of Anonet Communications Private Limited is - Active.",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imgBuild(String img, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      color: Colors.grey[300],
      child: Column(
        children: [
          Image.asset(
            img,
            fit: BoxFit.fill,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomButton(
            text: "Buy Now",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PayOptions(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(context) => Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      );

  Widget buildHeader(context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Container(
      color: Colors.blue[300],
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      height: 246,
      child: Column(
        children: [
          const CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage("assets/images/cow2.jpg"),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 3, 0),
            child: SizedBox(
              height: 30,
              child: Text(
                ap.userModel.uid,
                style: const TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 30,
            child: Text(
              ap.userModel.phoneNumber,
              style: const TextStyle(color: Colors.white70, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuItems(context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Container(
      color: Colors.grey[300],
      padding: const EdgeInsets.all(24),
      child: Wrap(
        children: [
          ListTile(
            leading: const Icon(
              Icons.account_circle,
              size: 40,
              color: Colors.black,
            ),
            title: const Text(
              'Complaints',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Complaints(),
                ),
              );
            },
          ),
          const Divider(color: Colors.black),
          ListTile(
            leading: const Icon(
              Icons.home_outlined,
              size: 40,
              color: Colors.black,
            ),
            title: const Text(
              'About Us',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutUs(),
                ),
              );
            },
          ),
          const Divider(color: Colors.black),
          ListTile(
            leading: const Icon(
              Icons.info,
              size: 40,
              color: Colors.black,
            ),
            title: const Text(
              'Plans info',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Plans(),
                ),
              );
            },
          ),
          const Divider(color: Colors.black),
          ListTile(
            leading: const Icon(
              Icons.account_balance_wallet_rounded,
              size: 40,
              color: Colors.black,
            ),
            title: const Text(
              'Contact and Support',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Contacts(),
                ),
              );
            },
          ),
          const Divider(color: Colors.black),
          ListTile(
            leading: const Icon(
              Icons.account_circle,
              size: 40,
              color: Colors.black,
            ),
            title: const Text(
              'FAQs',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Faqs(),
                ),
              );
            },
          ),
          const Divider(color: Colors.black),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app_rounded,
              size: 40,
              color: Colors.black,
            ),
            title: const Text(
              'Sign Out',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              ap.userSignOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignUp(),
                ),
              );
              showSnackBar(context, "account sign out successfully");
            },
          ),
        ],
      ),
    );
  }
}
