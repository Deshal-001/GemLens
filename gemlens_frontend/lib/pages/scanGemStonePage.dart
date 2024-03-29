import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gemlens_frontend/components/bottomNavigationBar.dart';
import 'package:gemlens_frontend/themes/colors.dart';
import 'package:image_picker/image_picker.dart';

import '../components/scanButton.dart';

class ScanImagePage extends StatefulWidget {
  const ScanImagePage({Key? key}) : super(key: key);

  @override
  State<ScanImagePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ScanImagePage> {
  File? selectedImage;
  Uint8List? webImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(index: 1,),
      body: Column(
        children: [
          webImage != null || selectedImage != null
              ?  (webImage != null ? Image.memory(webImage!,width: MediaQuery.of(context).size.width*0.4 ,height: MediaQuery.of(context).size.width*0.4): Image.file(selectedImage!))
              : const DottedSquare(size: 00, child: SizedBox()), // Wrapped in a SizedBox to ensure proper size
          const SizedBox(height: 16), // Spacer
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ScanButton(icon: "../assets/icons/camera_icon.png", onTap: _pickImageFromCamera,),
                  ScanButton(icon: "../assets/icons/gallery_icon.png", onTap: _pickImageFromGallery,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    final ImagePicker imagePicker = ImagePicker();

    if (!kIsWeb) {
      final XFile? image =
          await imagePicker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        final File file = File(image.path);
        setState(() {
          selectedImage = file;
          webImage = null; // Reset web image if any
        });
      } else {
        print("No Image has been Picked");
      }
    } else if (kIsWeb) {
      final XFile? image =
          await imagePicker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        final Uint8List bytes = await image.readAsBytes();
        setState(() {
          webImage = bytes;
          selectedImage = null; // Reset selected image if any
        });
      }
    }
  }

  Future<void> _pickImageFromCamera() async {
    final ImagePicker imagePicker = ImagePicker();

    if (!kIsWeb) {
      final XFile? image =
          await imagePicker.pickImage(source: ImageSource.camera);

      if (image != null) {
        final File file = File(image.path);
        setState(() {
          selectedImage = file;
          webImage = null; // Reset web image if any
        });
      } else {
        print("No Image has been Picked");
      }
    } else {
      // Handle web camera if needed
      print("Camera not supported on web");
    }
  }
}

class DottedSquare extends StatelessWidget {
  final double size;
  final Widget child;
  final VoidCallback? onTap;

  const DottedSquare({
    Key? key,
    required this.size,
    required this.child,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        size: Size(size, size),
        painter: DottedBorderPainter(),
        child: child,
      ),
    );
  }
}

class DottedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final double dashWidth = 5.0;
    final double dashSpace = 5.0;
    double startY = 0.0;

    while (startY < size.height) {
      canvas.drawLine(
        Offset(0, startY),
        Offset(0, startY + dashWidth),
        paint,
      );
      startY += dashWidth + dashSpace;
    }

    double endY = 0.0;
    while (endY < size.width) {
      canvas.drawLine(
        Offset(endY, 0),
        Offset(endY + dashWidth, 0),
        paint,
      );
      endY += dashWidth + dashSpace;
    }

    final double right = size.width - 1;
    final double bottom = size.height - 1;

    double startX = 0.0;
    while (startX < right) {
      canvas.drawLine(
        Offset(startX, bottom),
        Offset(startX + dashWidth, bottom),
        paint,
      );
      startX += dashWidth + dashSpace;
    }

    double endX = 0.0;
    while (endX < bottom) {
      canvas.drawLine(
        Offset(right, endX),
        Offset(right, endX + dashWidth),
        paint,
      );
      endX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
