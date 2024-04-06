import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gemlens_frontend/components/bottomNavigationBar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart' as rive;

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       // backgroundColor: Colors.white, // Changed AppBar color to white
        elevation: 0,
        title: Text(
          "GemLens",
          style: GoogleFonts.dmSerifDisplay(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Changed text color to black
          ),
        ),
      ),
      //bottomNavigationBar: const CustomBottomNavigationBar(index: 0),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AboutBlock(),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Text(
                        "About The Developer",
                        style: GoogleFonts.lato(
                            color: Colors.blueGrey, fontSize: 18),
                      ),
                      SizedBox(height: 20),
                      ClipOval(
                        child: Image.asset(
                          'assets/icons/avatar.jpg',
                          fit: BoxFit.cover,
                          width: 180,
                          height: 180,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Hello! I am Deshal Silva, a final-year undergraduate student studying Software Engineering at IIT. Passionate about technology and problem-solving, I am dedicated to creating impactful solutions. With strong programming skills and a drive for innovation, I am excited to contribute to the development of GemLens.',
                        style:
                            GoogleFonts.lato(fontSize: 16, color: Colors.black),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AboutBlock extends StatelessWidget {
  const AboutBlock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Theme.of(context).primaryColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          Text(
            "About The Application",
            style: GoogleFonts.lato(color: Colors.blueGrey, fontSize: 18),
          ),
          SizedBox(height: 20),
          ClipOval(
            child: Image.asset(
              'assets/icons/mobileIcon.png',
              fit: BoxFit.cover,
              width: 180,
              height: 180,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'GemLens is a mobile application that allows users to search for gemstones and get information about them. The application also allows users to take a picture of a gemstone and get information about it. The application also has a feature that allows users to get information about gemstones by entering the name of the gemstone. The application also has a feature that allows users to get information about gemstones by entering the name of the gemstone.',
            style: GoogleFonts.lato(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
