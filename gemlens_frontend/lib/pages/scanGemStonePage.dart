import 'dart:convert';
//import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gemlens_frontend/components/bottomNavigationBar.dart';
import 'package:gemlens_frontend/themes/colors.dart';
import 'package:gemlens_frontend/themes/texts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';

import '../components/scanButton.dart';

class ScanImagePage extends StatefulWidget {
  const ScanImagePage({Key? key}) : super(key: key);

  @override
  State<ScanImagePage> createState() => _MyWidgetState();
}

String? predictedClass;

class _MyWidgetState extends State<ScanImagePage> {
  File? selectedImage;
  Uint8List? webImage;
  String? apiResponse;
  int? gemStoneIndex;
  List<String> responses = [];
  String? dominantColor;
  double? confidenceScore;

  Uint8List? xaiImage;
  bool isLoadingXAI = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // bottomNavigationBar: CustomBottomNavigationBar(index: 1),
      appBar:  AppBar(
       // backgroundColor: Colors.white, // Changed AppBar color to white
        elevation: 0,
        title: Text(
          "Scan",
          style: GoogleFonts.dmSerifDisplay(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Changed text color to black
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (webImage != null || selectedImage != null)
                      Card(
                        elevation: 8.0,
                        color: primaryColor.withOpacity(0.9),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: webImage != null
                                  ? Image.memory(webImage!, fit: BoxFit.cover)
                                  : Image.file(selectedImage!, fit: BoxFit.cover),
                            ),
                            ListTile(
                              title: Text(
                                'Predicted Class: $predictedClass',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Confidence: ${confidenceScore != null ? (confidenceScore! * 100).toStringAsFixed(2) : "N/A"}%',
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 16,
                                    ),
                                  ),
                                  if (confidenceScore != null)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: SizedBox(
                                        height: 5,
                                        child: LinearProgressIndicator(
                                          value: confidenceScore,
                                          backgroundColor: Colors.grey[200],
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  primaryColor),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            ExpansionTile(
                              title: const Text('Explanation & XAI Image'),
                              children: [
                                ListTile(
                                  title: Text(interpretDescription(
                                      predictedClass: predictedClass,
                                      dominantColor: dominantColor,
                                      confidenceScore: confidenceScore)),
                                ),
                                if (isLoadingXAI)
                                   Padding(
                                    padding: EdgeInsets.all(20),
                                    child: CircularProgressIndicator(
                                        color: primaryColor),
                                  ),
                                if (xaiImage != null)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.memory(xaiImage!,
                                        fit: BoxFit.cover),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    if (webImage == null && selectedImage == null)
                      Container(
                        width: 300,
                        height: 200,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey,
                              style: BorderStyle.solid,
                              width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text('No image selected'),
                      ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () => _showUploadImageOptions(context),
                      label: const Text('Upload Image'),
                      icon: const Icon(Icons.cloud_upload),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String interpretDescription(
      {String? predictedClass,
      String? dominantColor,
      double? confidenceScore}) {
    // Ensure all parameters are available to form a meaningful description
    if (predictedClass != null &&
        dominantColor != null &&
        confidenceScore != null) {
      // Convert confidence score to a percentage for readability
      final confidencePercentage = (confidenceScore * 100).toStringAsFixed(2);

      // Craft the description
      String description =
          "The model predicts the class as '$predictedClass' with a confidence level of $confidencePercentage%. ";
      description +=
          "A significant factor contributing to this prediction is the dominant color '$dominantColor', ";
      description +=
          "which is commonly associated with the '$predictedClass' class.";

      return description;
    } else {
      // Return a default message if any of the information is missing
      return "Awaiting more data for a comprehensive analysis.";
    }
  }

  void _showUploadImageOptions(BuildContext context) {
    if (kIsWeb) {
      // For web, directly go to gallery picker
      _pickImageFromGallery();
    } else {
      // For mobile, show option to choose between camera and gallery
      showModalBottomSheet(
        context: context,
        builder: (context) => Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                _pickImageFromCamera();
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                _pickImageFromGallery();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
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
        await _uploadImage_getDetails(
            await file.readAsBytes(), basename(image.path));

        if (confidenceScore != null && confidenceScore! > 0.75) {
          _uploadImageXAI(await file.readAsBytes(), basename(image.path));
        }
      } else {
        print("No Image has been Picked");
      }
    } else {
      // Handle web camera if needed
      print("Camera not supported on web");
    }
  }

  Future<void> _pickImageFromGallery() async {
    final ImagePicker imagePicker = ImagePicker();
    print("Picking Image");

    if (!kIsWeb) {
      final XFile? image =
          await imagePicker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        final File file = File(image.path);
        setState(() {
          selectedImage = file;
          webImage = null; // Reset web image if any
        });
        await _uploadImage_getDetails(
            await file.readAsBytes(), basename(image.path));

        if (confidenceScore != null && confidenceScore! > 0.75) {
          _uploadImageXAI(await file.readAsBytes(), basename(image.path));
        }

        print(" Image has been Picked");
      } else {
        print("No Image has been Picked");
      }
    } else if (kIsWeb) {
      print("kIsWeb Image");

      final XFile? image =
          await imagePicker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        final Uint8List bytes = await image.readAsBytes();
        setState(() {
          webImage = bytes;
          selectedImage = null; // Reset selected image if any
        });
        // _uploadImage_class(bytes, basename(image.path));
        await _uploadImage_getDetails(bytes, basename(image.path));
        //_uploadImage_probabilities(bytes, basename(image.path));
        if (confidenceScore != null && confidenceScore! > 0.75) {
          _uploadImageXAI(bytes, basename(image.path));
        }
      }
    }
  }

  Future<void> _uploadImage_class(Uint8List data, String filename) async {
    var uri = Uri.parse(
        "http://127.0.0.1:5000/predict_class"); // Update with the correct endpoint
    var request = http.MultipartRequest("POST", uri);
    request.files.add(http.MultipartFile.fromBytes(
      'image', // Ensure this matches the key expected by Flask
      data,
      filename: filename,
    ));

    var response = await request.send();
    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      print("Response from the server: $responseBody");
      setState(() {
        apiResponse = responseBody;
        gemStoneIndex = int.parse(apiResponse!.replaceAll('"', ''));
        predictedClass = gemStonesList[
            gemStoneIndex!]; // Update your UI based on the response
      });
    } else {
      print('Failed to upload image: ${response.statusCode}');
    }
  }

  Future<void> _uploadImageXAI(Uint8List data, String filename) async {
    var uri = Uri.parse(
        "http://127.0.0.1:5000/predict"); // Update with the correct endpoint
    var request = http.MultipartRequest("POST", uri);
    request.files.add(http.MultipartFile.fromBytes(
      'image', // Ensure this matches the key expected by Flask
      data,
      filename: filename,
    ));

    var response = await request.send();
    if (response.statusCode == 200) {
      Uint8List responseBody = await response.stream.toBytes();
      print("Response from the server received");
      setState(() {
        xaiImage = responseBody; // Update your UI based on the response
        apiResponse = null; // Reset API response if any
      });
    } else {
      print('Failed to upload image: ${response.statusCode}');
    }
  }

  Future<void> _uploadImage_probabilities(
      Uint8List data, String filename) async {
    var uri = Uri.parse("http://127.0.0.1:5000/predict_probabilities");
    var request = http.MultipartRequest("POST", uri);
    request.files.add(http.MultipartFile.fromBytes(
      'image',
      data,
      filename: filename,
    ));

    var response = await request.send();
    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      print("Response from the server: $responseBody");
      setState(() {
        responses.add(responseBody); // Add the response to the list
      });
    } else {
      print('Failed to upload image: ${response.statusCode}');
    }
  }

  Future<void> _uploadImage_dominantColor(
      Uint8List data, String filename) async {
    var uri = Uri.parse(
        "http://127.0.0.1:5000/predict_class"); // Update with the correct endpoint
    var request = http.MultipartRequest("POST", uri);
    request.files.add(http.MultipartFile.fromBytes(
      'image', // Ensure this matches the key expected by Flask
      data,
      filename: filename,
    ));

    var response = await request.send();
    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      print("Response from the server: $responseBody");
      setState(() {
        apiResponse = responseBody;
        gemStoneIndex = int.parse(apiResponse!.replaceAll('"', ''));
        predictedClass = gemStonesList[
            gemStoneIndex!]; // Update your UI based on the response
      });
    } else {
      print('Failed to upload image: ${response.statusCode}');
    }
  }

  Future<void> _uploadImage_getDetails(Uint8List data, String filename) async {
    var uri = Uri.parse("http://127.0.0.1:5000/image_analysis");
    var request = http.MultipartRequest("POST", uri);
    confidenceScore = 0.0;
    request.files.add(http.MultipartFile.fromBytes(
      'image',
      data,
      filename: filename,
    ));

    var response = await request.send();
    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      print("Response from the server: $responseBody");

      // Parse the JSON response
      Map<String, dynamic> analysisResults = jsonDecode(responseBody);

      // Extract the results
      String response_dominantColor = analysisResults['dominant_color'];
      String response_predictedClass = analysisResults['predicted_class'];
      double response_confidenceScore = analysisResults['confidence_score'];
      List response_probabilities = (analysisResults['probabilities'] as List)
          .map((item) => item.toDouble())
          .toList();

      // Use the results as needed
      // For example, you can update your UI based on the results
      setState(() {
        // Update your state variables here
        dominantColor = response_dominantColor;
        gemStoneIndex = int.parse(response_predictedClass);
        predictedClass = gemStonesList[gemStoneIndex!];
        confidenceScore = response_confidenceScore;

        responses = response_probabilities
            .map((item) => item.toStringAsFixed(2))
            .toList()
            .cast<String>();
      });
    } else {
      print('Failed to upload image: ${response.statusCode}');
    }
  }
}

class DottedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.grey // Color of the dots
      ..strokeWidth = 2 // Width of the dots
      ..style = PaintingStyle.stroke; // Stroke style

    var dashWidth = 5.0;
    var dashSpace = 5.0;
    double startX = 0.0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }

    double startY = 0.0;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashWidth), paint);
      startY += dashWidth + dashSpace;
    }

    double endX = size.width;
    startX = 0.0;
    while (startX < size.width) {
      canvas.drawLine(
          Offset(startX, endX), Offset(startX + dashWidth, endX), paint);
      startX += dashWidth + dashSpace;
    }

    double endY = size.height;
    startY = 0.0;
    while (startY < size.height) {
      canvas.drawLine(
          Offset(endY, startY), Offset(endY, startY + dashWidth), paint);
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
