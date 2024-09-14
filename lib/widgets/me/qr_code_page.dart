import 'package:flutter/material.dart';
import 'dart:math'; // র‍্যান্ডম রং বাছাই করার জন্য
import 'package:image_picker/image_picker.dart'; // For saving image
import 'dart:ui'; // For gradient colors
import 'dart:typed_data'; // For saving image
import 'dart:io'; // For saving image
import 'package:path_provider/path_provider.dart'; // For saving image
import 'package:flutter/rendering.dart'; // For capturing widget to image
import 'package:pretty_qr_code/pretty_qr_code.dart'; // QR কোড জেনারেট করার জন্য
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart'; // Flutter Barcode Scanner প্যাকেজ ব্যবহার করা হলো

class QRCodePage extends StatefulWidget {
  @override
  _QRCodePageState createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  GlobalKey _globalKey = GlobalKey();
  List<List<Color>> gradientColors = [
    [Colors.purple, Colors.pink],
    [Colors.blue, Colors.green],
    [Colors.orange, Colors.red],
    [Colors.cyan, Colors.indigo],
    [Colors.teal, Colors.lime],
    [Colors.deepPurple, Colors.yellow],
    [Colors.amber, Colors.deepOrange],
    [Colors.blueGrey, Colors.lightBlue],
    [Colors.brown, Colors.lightGreen],
    [Colors.pinkAccent, Colors.blueAccent],
  ];

  Color gradientStart = Colors.purple;
  Color gradientEnd = Colors.pink;

  // র‍্যান্ডম গ্রেডিয়েন্ট স্টাইল পরিবর্তনের ফাংশন
  Future<void> _changeStyle() async {
    setState(() {
      final randomIndex = Random().nextInt(gradientColors.length);
      gradientStart = gradientColors[randomIndex][0];
      gradientEnd = gradientColors[randomIndex][1];
    });
  }

  // QR কোড স্ক্যানিং এর ফাংশন
  Future<void> _scanQR() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QRScannerPage(),
      ),
    );
  }

  // ইমেজ সেভ করার ফাংশন
  Future<void> _saveImage() async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage();
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final directory = (await getExternalStorageDirectory())?.path;
      String fileName = 'qr_code_image_${DateTime.now().millisecondsSinceEpoch}.jpg';
      File imgFile = File('$directory/$fileName');
      await imgFile.writeAsBytes(pngBytes);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('QR কোড ইমেজ হিসাবে সেভ হয়েছে $fileName')),
      );
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('QR কোড সেভ করতে ব্যর্থ হয়েছে')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [gradientStart, gradientEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('lib/assets/images/profile0.jpg'),
                radius: 30,
              ),
              SizedBox(height: 10),
              Text(
                'Tomioka Giyuu',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                'Bangladesh',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 20),
              RepaintBoundary(
                key: _globalKey,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: PrettyQr(
                    data: 'Tomioka Giyuu - Bangladesh', // QR কোড এর তথ্য
                    size: 200, // QR কোডের আকার
                    errorCorrectLevel: QrErrorCorrectLevel.M,
                    roundEdges: true,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Scan the QR code to add as a friend',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: _scanQR,
                    child: Text('Scan', style: TextStyle(color: Colors.blue)),
                  ),
                  TextButton(
                    onPressed: _changeStyle,
                    child: Text('Change style', style: TextStyle(color: Colors.blue)),
                  ),
                  TextButton(
                    onPressed: _saveImage,
                    child: Text('Save image', style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// QR স্ক্যানার পেজ
class QRScannerPage extends StatefulWidget {
  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  @override
  void initState() {
    super.initState();
    _scanBarcode(); // Page load হলে সরাসরি স্ক্যান শুরু হবে
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
        "Cancel", // Cancel text
        true, // Show flash
        ScanMode.BARCODE, // Scan barcode only
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
