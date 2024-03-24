import 'package:flutter/material.dart';
import 'package:gemlens_frontend/themes/fonts.dart';
import 'package:gemlens_frontend/themes/texts.dart';


class HelpWidget extends StatelessWidget {
  final int i;
  const HelpWidget({
    super.key,
    required this.i,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(imgList[i]),
            ),
            Text(
              titleList[i],
              style: redTitleFont,
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                descList[i],
                style: redBodyMultilineText,
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}