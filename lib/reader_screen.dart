import 'dart:io';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ReaderScreen extends StatelessWidget {
  final String bookTitle;
  final String filePath;

  const ReaderScreen({Key? key, required this.bookTitle, required this.filePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final file = File(filePath); 

    return Scaffold(
      appBar: AppBar(
        title: Text(bookTitle),
      ),
      body: file.existsSync()
          ? SfPdfViewer.file(file)
          : Center(child: Text("Failed to load file: File not found")),
    );
  }
}
