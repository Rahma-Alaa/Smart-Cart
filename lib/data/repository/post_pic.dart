import 'dart:io';
import 'package:http/http.dart' as http;

Future<void> postPicture(String userId, File file) async {
  var request = http.MultipartRequest(
    'POST',
    Uri.parse(
        'https://smartcartapplback.azurewebsites.net/FileSystem/UserProfilePictureUpload?userId=$userId'),
  );
  request.headers['accept'] = '*/*';
  request.files.add(await http.MultipartFile.fromPath('files', file.path));
  await request.send();
  // if (response.statusCode == 200) {
  //   print('File uploaded successfully');
  // } else {
  //   print('Error uploading file');
  // }
}

Future<void> postPdf(String userId, String invoiceId, File file) async {
  var request = http.MultipartRequest(
    'POST',
    Uri.parse(
        'https://smartcartapplback.azurewebsites.net/FileSystem/UserInvoicePDFUpload?userId=$userId&invoiceId=$invoiceId'),
  );
  request.headers['accept'] = '*/*';
  request.files.add(await http.MultipartFile.fromPath('files', file.path));
  await request.send();
  // if (response.statusCode == 200) {
  //   print('File uploaded successfully');
  // } else {
  //   print('Error uploading file');
  // }
}
