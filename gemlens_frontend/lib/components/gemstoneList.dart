import 'package:flutter/material.dart';
import 'package:gemlens_frontend/components/gemStone.dart';
import 'package:gemlens_frontend/pages/gemStoneSearch.dart';
import 'package:gemlens_frontend/pages/gemstonePage.dart';
import 'package:gemlens_frontend/themes/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class GemStoneList extends StatelessWidget {
  final Gemstone gemstone;
  const GemStoneList({
    Key? key, required this.gemstone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
   
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GemStonePage(gemstone: gemstone),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(.2),
            borderRadius: BorderRadius.circular(10),
          ),
          height: 80.0,
          padding: const EdgeInsets.only(left: 10, top: 10),
          margin: const EdgeInsets.only(bottom: 10, top: 10),
          width: size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(.8),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      height: 80.0,
                      child: Image.asset(gemstone.iconPath, height: 450, width: 450,),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    left: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(gemstone.category), // replace with actual category
                        Text(
                          gemstone.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}