import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class PdfReport extends StatefulWidget {
  const PdfReport({super.key});

  @override
  State<PdfReport> createState() => _PdfReportState();
}

class _PdfReportState extends State<PdfReport> {
  String? pdfPath = "";
  @override
  void initState() {
    super.initState();
    fromAsset("assets/sample.pdf", 'sample.pdf').then((f) {
      log("File $f");
      setState(() {
        pdfPath = f.path;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Completer<PDFViewController> _controller =
        Completer<PDFViewController>();
    int? pages = 0;
    int? currentPage = 0;
    bool isReady = false;
    String errorMessage = '';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Investigation Report'),
      ),
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: pdfPath,
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: false,
            pageFling: true,
            pageSnap: true,
            defaultPage: currentPage,
            fitPolicy: FitPolicy.BOTH,
            preventLinkNavigation:
                false, // if set to true the link is handled in flutter
            onRender: (_pages) {
              setState(() {
                pages = _pages;
                isReady = true;
              });
            },
            onError: (error) {
              setState(() {
                errorMessage = error.toString();
              });
              log(error.toString());
            },
            onPageError: (page, error) {
              setState(() {
                errorMessage = '$page: ${error.toString()}';
              });
              log('$page: ${error.toString()}');
            },
            onViewCreated: (PDFViewController pdfViewController) {
              _controller.complete(pdfViewController);
            },
            onLinkHandler: (String? uri) {
              log('goto uri: $uri');
            },
            onPageChanged: (int? page, int? total) {
              log('page change: $page/$total');
              setState(() {
                currentPage = page;
              });
            },
          ),
          errorMessage.isEmpty
              ? !isReady
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container()
              : Center(
                  child: Text(errorMessage),
                )
        ],
      ),
      floatingActionButton: FutureBuilder<PDFViewController>(
          future: _controller.future,
          builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
            if (snapshot.hasData) {
              return FloatingActionButton.extended(
                label: Text("Go to ${pages! ~/ 2}"),
                onPressed: () async {
                  await snapshot.data!.setPage(pages! ~/ 2);
                },
              );
            }
            return Container();
          }),
    );
  }

  Future<File> fromAsset(String asset, String filename) async {
    await requestStoragePermission();
    Completer<File> completer = Completer();
    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      log("File Name $file");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }
    return completer.future;
  }

  Future<void> requestStoragePermission() async {
    final status = await Permission.manageExternalStorage.request();
    await Permission.storage.request();

    if (status == PermissionStatus.granted) {
      log('Permission Granted');
    } else if (status == PermissionStatus.denied) {
      log('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      log('Permission Permanently Denied');
      await openAppSettings();
    }
  }
}
