// ignore_for_file: unused_import

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:gbook/reader_screen.dart';
import 'package:gbook/ocr_reader_screen.dart'; //  for OCR-based reading

class LibraryScreen extends StatelessWidget {
  void _pickFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
    );

    if (result != null && result.files.single.path != null) {
      final path = result.files.single.path!;
      final name = result.files.single.name;

      if (name.toLowerCase().endsWith('.pdf')) {
        
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ReaderScreen(bookTitle: name, filePath: path),
          ),
        );
      } else {
        
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OCRReaderScreen(
              imagePath: path,
              imageFile: File(path), 
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        icon: Icon(Icons.upload_file),
        label: Text("Import PDF or Image"),
        onPressed: () => _pickFile(context),
      ),
    );
  }
}
