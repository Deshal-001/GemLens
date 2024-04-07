import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gemlens_frontend/components/bottomNavigationBar.dart';
import 'package:gemlens_frontend/components/helpWidget.dart';
import 'package:gemlens_frontend/themes/colors.dart';
import 'package:gemlens_frontend/themes/fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpAndSupportPage extends StatefulWidget {
  const HelpAndSupportPage({super.key});

  @override
  State<HelpAndSupportPage> createState() => _HelpAndSupportPageState();
}

class _HelpAndSupportPageState extends State<HelpAndSupportPage> {
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //   backgroundColor: Colors.white, // Changed AppBar color to white
        elevation: 0,
        title: Text(
          "Help & Support",
          style: GoogleFonts.dmSerifDisplay(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Changed text color to black
          ),
        ),
      ),
      //bottomNavigationBar: const CustomBottomNavigationBar(
      //  index: 0,
      //),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: CarouselSlider(
                    items: [0, 1, 2, 3].map((i) {
                      return HelpWidget(i: i);
                    }).toList(),
                    options: CarouselOptions(
                      height: 500,
                    )),
              ),
              ElevatedButton(
  onPressed: () {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Feedback Form'),
          content: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(hintText: "Email"),
              ),
              TextField(
                decoration: InputDecoration(hintText: "Subject"),
              ),
              TextField(
                decoration: InputDecoration(hintText: "Message"),
                maxLines: 3,
                controller: emailController,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Submit'),
              onPressed: () {
                              sendFeedbackEmail(emailBody: emailController);

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  },
  child: Text('Submit Feedback'),
  style: ElevatedButton.styleFrom(
    foregroundColor: Colors.white, backgroundColor: primaryColor, // text color
  ),
)
            ],
          ),
        ),
      ),
    );
  }

 sendFeedbackEmail({required TextEditingController emailBody}) async {
  final Uri params = Uri(
    scheme: 'mailto',
    path: 'kavindudeshal2@gmail.com',
    query: 'subject=App Feedback&body=${Uri.encodeComponent(emailBody.text)}',
  );

  String url = params.toString();
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print('Could not launch $url');
  }
}
}
