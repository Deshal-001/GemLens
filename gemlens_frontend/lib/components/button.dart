import 'package:flutter/material.dart';

class LandingPageButton extends StatelessWidget {
  final String text;
  final void Function() onTap;
  const LandingPageButton({Key? key, required this.text, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap ,
      child: Container(
        decoration: BoxDecoration(
          color:                        const Color.fromARGB(255, 3, 66, 117)
,
          borderRadius: BorderRadius.circular(60)
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text,style: TextStyle(color: Colors.white),),
            const SizedBox(width: 15),
      
            Icon( Icons.arrow_forward_ios, color: Colors.white)
          ],
        ),
      ),
    );
  }
}
