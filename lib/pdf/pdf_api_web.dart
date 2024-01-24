import 'dart:io';
import 'dart:typed_data';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:path/path.dart' as path;
import "package:universal_html/html.dart" as html;
import 'package:flutter/foundation.dart' show kIsWeb;

class PdfApi {
  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();
    final File file;

    if (kIsWeb) {
      final dir = path.current;
      file = File(path.join(dir.toString(), name));
      _saveDocumentWeb(bytes, name);
    } else {
      final dir = await getApplicationDocumentsDirectory();
      file = File('${dir.path}/$name');

      await file.writeAsBytes(bytes);
    }

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }

  static void _saveDocumentWeb(Uint8List data, String filename) {
    String url =
        html.Url.createObjectUrlFromBlob(html.Blob([data], 'application/pdf'));

    html.AnchorElement element =
        html.document.createElement('a') as html.AnchorElement
          ..href = url
          ..style.display = 'none'
          ..download = filename;

    html.document.body!.children
      ..add(element..click())
      ..remove(element);

    html.Url.revokeObjectUrl(url);
  }
}

// class PdfConverter {
//   static convertToImage(String pdfPath) async {
//     PdfDocument doc = await PdfDocument.openFile(pdfPath);
//     PdfPage page = await doc.getPage(1);

//     final PdfPageImage? pageImg = await page.render(
//         width: 575, height: page.height + 200, backgroundColor: "#ffffff");

//     if (pageImg != null) {
//       String path = (await getApplicationDocumentsDirectory()).path;
//       File file = File(path + "MY_IMG.png");

//       await file.writeAsBytes(pageImg.bytes);
//       String base64String = base64Encode(pageImg.bytes);
//       print(base64String);
//       OpenFile.open(file.path);
//     }
//   }
// }
