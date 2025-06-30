import 'package:flutter/material.dart';
import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';


class OCRReaderScreen extends StatefulWidget {
  final File imageFile;
  OCRReaderScreen({required this.imageFile, required String imagePath});

  @override
  _OCRReaderScreenState createState() => _OCRReaderScreenState();
}

class _OCRReaderScreenState extends State<OCRReaderScreen> {
  late final TextRecognizer _textRecognizer;
  List<TextBlock> _blocks = [];
  String _highlightedText = '';

  @override
  void initState() {
    super.initState();
    _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin); 
    _processImage();
  }

  Future<void> _processImage() async {
    final inputImage = InputImage.fromFilePath(widget.imageFile.path);
    final recognizedText = await _textRecognizer.processImage(inputImage);

    setState(() {
      _blocks = recognizedText.blocks; // image theke block nibo
    });
  }

  @override
  void dispose() {
    _textRecognizer.close();
    super.dispose();
  }

  // block k highlight krbo
  Widget _buildTextOverlay() {
    return Stack(
      children: _blocks.map((block) {
        return Positioned(
          left: block.boundingBox.left,
          top: block.boundingBox.top,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _highlightedText = block.text; // Highlight selected text
              });
            },
            child: Container(
              color: Colors.transparent,
              child: Text(
                block.text,
                style: TextStyle(
                  color: _highlightedText == block.text
                      ? Colors.yellow
                      : Colors.black,
                  backgroundColor: _highlightedText == block.text
                      ? Colors.blue.withOpacity(0.4)
                      : Colors.transparent,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('OCR Reader')),
      body: Stack(
        children: [
          Image.file(widget.imageFile), // Image as background
          _buildTextOverlay(), // Text overlay on the image
        ],
      ),
    );
  }
}
