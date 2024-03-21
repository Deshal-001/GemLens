import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';

import '../components/button.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Rive animation
            const Positioned.fill(
              child: RiveAnimation.asset('assets/icons/shapes.riv'),
            ),

            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: Colors.white.withOpacity(0.5),
                ),
              
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // App name
                  Text(
                    "GemLens",
                    style: GoogleFonts.dmSerifDisplay(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(216, 23, 23, 0.78),
                    ),
                  ),
                  const SizedBox(height: 25),
                  // Icon
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Image.asset('assets/icons/gem.png')
                          .animate()
                          .fade(duration: 280.ms)
                          .scale(delay: 280.ms), // Animate the image,
                    ),
                  ),
                  SizedBox(height: 15),
                  // Title
                  Text(
                    "THE AUTOMATED GEMSTONE IDENTIFICATION",
                    style: GoogleFonts.dmSerifDisplay(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(216, 23, 23, 0.78),
                    ),
                  ),
                  // Subtitle
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Discover the World of Gems through Your Lens",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(215, 94, 94, 0.776),
                    ),
                  ),
                  SizedBox(height: 15),
                  // Go button
                  Center(
                    child: LandingPageButton(
                      text: "Get Started",
                      onTap: () {
                        Navigator.pushNamed(context, '/menu');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
