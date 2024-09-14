import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart'; // google_ml_kit প্যাকেজ ব্যবহার করা হলো
import 'package:image_picker/image_picker.dart'; // Camera image picker এর জন্য ব্যবহার করা হয়েছে

class ScannerPage extends StatefulWidget {
  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final BarcodeScanner barcodeScanner = GoogleMlKit.vision.barcodeScanner(); // google_ml_kit এর নতুন Scanner ব্যবহার করা হলো
  final ImagePicker _picker = ImagePicker(); // Camera থেকে ছবি নেওয়ার জন্য ImagePicker ব্যবহার করা হয়েছে

  @override
  void initState() {
    super.initState();
    _scanBarcode(); // Page load হওয়ার সাথে সাথে ক্যামেরা খুলবে
  }

  @override
  void dispose() {
    barcodeScanner.close(); // স্ক্যানার বন্ধ করা হবে যখন পেজ ডিসপোজ হবে
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // স্ক্যান করার সময় ব্যাকগ্রাউন্ড সাদা না দেখানোর জন্য কালো করা হলো
    );
  }

  Future<void> _scanBarcode() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera); // Camera থেকে ছবি নেওয়া হচ্ছে
      if (image == null) {
        Navigator.pop(context); // If no image was captured, return back
        return;
      }

      final inputImage = InputImage.fromFilePath(image.path); // Image path ব্যবহার করে inputImage তৈরি করা হলো
      final List<Barcode> barcodes = await barcodeScanner.processImage(inputImage); // স্ক্যান করা বারকোডগুলো প্রসেস করা হবে

      for (Barcode barcode in barcodes) {
        final String? rawValue = barcode.rawValue; // displayValue এর পরিবর্তে rawValue ব্যবহার করা হলো
        if (rawValue != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Scanned Code: $rawValue')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No valid code found')),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      Navigator.pop(context); // After processing, return back to the previous page
    }
  }
}
