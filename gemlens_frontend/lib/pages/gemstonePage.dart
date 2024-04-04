import 'package:flutter/material.dart';
import 'package:gemlens_frontend/components/gemStone.dart';
import 'package:gemlens_frontend/themes/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class GemStonePage extends StatefulWidget {
  final Gemstone gemstone;
  const GemStonePage({super.key, required this.gemstone});

  @override
  State<GemStonePage> createState() => _GemStonePageState();
}

class _GemStonePageState extends State<GemStonePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

final detailsSections = [
      {
        'header': 'General Information',
        'attributes': [
          {'Name': widget.gemstone.name},
          {'Color': widget.gemstone.color},
          {'Hardness': widget.gemstone.hardness.toString()},
          {'Origin': widget.gemstone.origin},
        ],
      },
      {
        'header': 'Chemical Properties',
        'attributes': [
          {'Category': widget.gemstone.category},
          {'Formula': widget.gemstone.formula},
          {'Crystal System': widget.gemstone.crystalSystem},
          {'Crystal Class': widget.gemstone.crystalClass},
          {'Space Group': widget.gemstone.spaceGroup},
        ],
      },
      {
        'header': 'Physical and Optical Properties',
        'attributes': [
          {'Identification Color': widget.gemstone.identificationColor},
          {'Crystal Habit': widget.gemstone.crystalHabit},
          {'Cleavage': widget.gemstone.cleavage},
          {'Fracture': widget.gemstone.fracture},
          {'Tenacity': widget.gemstone.tenacity},
          {'Mohs Scale Hardness': widget.gemstone.mohsScaleHardness.toString()},
          {'Luster': widget.gemstone.luster},
          {'Streak': widget.gemstone.streak},
          {'Diaphaneity': widget.gemstone.diaphaneity},
          {'Specific Gravity': widget.gemstone.specificGravity},
          {'Optical Properties': widget.gemstone.opticalProperties},
          {'Refractive Index': widget.gemstone.refractiveIndex},
          {'Birefringence': widget.gemstone.birefringence},
          {'Pleochroism': widget.gemstone.pleochroism},
          {'Dispersion': widget.gemstone.dispersion.toString()},
          {'Ultraviolet Fluorescence': widget.gemstone.ultravioletFluorescence},
          {'Common Impurities': widget.gemstone.commonImpurities},
        ],
      },
    ];

    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        widget.gemstone.name,
        style: GoogleFonts.dmSerifDisplay(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(216, 23, 23, 0.78),
        ),
      ),
    ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.width*0.8 , // Fixed height for the container
              width: double.infinity, // Make the container full width
              child: Hero(
                tag: 'gemstone_image_${widget.gemstone.name}',
                child: Image.asset(
                  widget.gemstone.imgPath,
                  fit: BoxFit.cover, // Cover the container bounds while preserving the aspect ratio
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(), // Disable scrolling for the ListView.builder
                shrinkWrap: true, // Allow the ListView to occupy space only for its children
                itemCount: detailsSections.length,
                itemBuilder: (context, index) => _buildSection(theme, detailsSections[index]),
              ),
            ),
            DescriptionWidget(description: widget.gemstone.longDescription),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(ThemeData theme, Map<String, dynamic> section) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ExpansionTile(
        title: Text(section['header'], style: GoogleFonts.nunitoSans(fontSize: 18, fontWeight: FontWeight.bold)),
        children: section['attributes'].map<Widget>((attribute) {
          var entry = attribute.entries.first;
          return ListTile(
            title: Text(entry.key, style: GoogleFonts.nunitoSans(color: theme.primaryColor, fontWeight: FontWeight.bold)),
            subtitle: Text(entry.value, style: GoogleFonts.nunitoSans()),
          );
        }).toList(),
      ),
    );
  }
}

class DescriptionWidget extends StatelessWidget {
  final String description;

  const DescriptionWidget({Key? key, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        description,
        style: GoogleFonts.nunitoSans(
          fontSize: 16,
          height: 1.5, // Adjust line spacing with height
        ),
      ),
    );
  }
}
