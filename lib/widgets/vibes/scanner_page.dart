import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart'; // Flutter Barcode Scanner প্যাকেজ ব্যবহার করা হলো
import 'package:image_picker/image_picker.dart'; // Camera image picker এর জন্য ব্যবহার করা হয়েছে

class ScannerPage extends StatefulWidget {
  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final ImagePicker _picker = ImagePicker(); // Camera থেকে ছবি নেওয়ার জন্য ImagePicker ব্যবহার করা হয়েছে

  @override
  void initState() {
    super.initState();
    _scanBarcode(); // Page load হওয়ার সাথে সাথে স্ক্যান শুরু হবে
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // স্ক্যান করার সময় ব্যাকগ্রাউন্ড সাদা না দেখানোর জন্য কালো করা হলো
    );
  }

  Future<void> _scanBarcode() async {
    try {
      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", // Barcode scanner color
        "Cancel", // Cancel button label
        true, // Show flash button
        ScanMode.BARCODE, // Only scan barcodes
      );

      if (barcodeScanRes != "-1") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Scanned Code: $barcodeScanRes')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Scan cancelled')),
        );
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
