import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );

    return Scaffold(
      backgroundColor: Colors.grey[300],
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "About Us",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            const Image(
              image: AssetImage("assets/images/cow2.jpg"),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                12,
                10,
                8,
                8,
              ),
              child: Text(
                "Our Mission",
                style: TextStyle(
                  color: Colors.blue[900],
                  fontSize: 35,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(
                12,
                10,
                8,
                8,
              ),
              child: Text(
                "We  are focused on realizing our vision - 'To be the most admired telecommunication and infotainment service brand through innovation and excellence'. We understand the importance of delivering quality products and services to nurture long lasting relationships with our customers. It is our endeavor to create significant value for all the stakeholders associated with the company. We truly believe in fundamentals of accountability and transparency and will continue to strive for the highest corporate standards thereby ensuring value creation for all.",
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 8, 8),
              child: Text(
                "Why Us?",
                style: TextStyle(
                  color: Colors.blue[900],
                  fontSize: 35,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(12, 10, 8, 8),
              child: Text(
                "Quality is the signature of our work. We value your business and because of this, we make your product work. Our main agenda while going through your project is to give you the best of the best that you deserve or we can offer.",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
