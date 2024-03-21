import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gemlens_frontend/components/bottomNavigationBar.dart';
import 'package:gemlens_frontend/themes/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart' as rive;

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavigationBar(index: 0),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                primaryColor,
                Color.fromARGB(255, 246, 73, 73),
                Colors.white,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('About',
                    style: GoogleFonts.dmSerifDisplay(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
                Text('GemLens',
                    style: GoogleFonts.aBeeZee(
                      color: Colors.white,
                    )),
                SizedBox(height: 20),
                AboutBlock(),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        children: [
                          Text("About The Developer",style: GoogleFonts.pressStart2p(color: Color.fromARGB(197, 106, 8, 8),),),
                          SizedBox(height: 20)
                          ,
                          ClipOval(
                              child: Image.asset(
                            'assets/icons/avatar.jpg', fit: BoxFit.cover,
                            width: 180, // Adjust the width as needed
                            height: 180,
                          )),
                          SizedBox(height: 20),
                          Text('Hello! I am Deshal Silva, a final-year undergraduate student studying Software Engineering at IIT. Passionate about technology and problem-solving, I am dedicated to creating impactful solutions. With strong programming skills and a drive for innovation, I am excited to contribute to the development of GemLens.'
                          , style: GoogleFonts.dmSerifDisplay(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color : Color.fromARGB(197, 106, 8, 8),

                            
                          ),textAlign: TextAlign.justify,),



                              
                        ],
                      )),
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
        borderRadius: BorderRadius.circular(60),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Text(
          'GemLens is a mobile application that allows users to search for gemstones and get information about them. The application also allows users to take a picture of a gemstone and get information about it. The application also has a feature that allows users to get information about gemstones by entering the name of the gemstone. The application also has a feature that allows users to get information about gemstones by entering the name of the gemstone.',
          style: GoogleFonts.dmSerifDisplay(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(197, 106, 8, 8),
          ),
        ),
      ),
    );
  }
}
