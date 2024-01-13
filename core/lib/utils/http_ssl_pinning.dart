import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class HttpSSLPinning {
  static Future<http.Client> get _instance async =>
      _clientInstance ??= await createIOClient();

  static http.Client? _clientInstance;

  static http.Client get client => _clientInstance ?? http.Client();

  static Future<void> init() async {
    _clientInstance = await _instance;
  }

  static Future<HttpClient> customHttpClient() async {
    SecurityContext securityContext = SecurityContext();

    try {
      List<int> bytes = (await rootBundle.load('certificates/certificates.pem'))
          .buffer
          .asUint8List();
      securityContext.setTrustedCertificatesBytes(bytes);
      log('customHttpClient() - cert added!');
    } on TlsException catch (e) {
      if (e.osError?.message != null &&
          e.osError!.message.contains('CERT_ALREADY_IN_HASH_TABLE')) {
        log('customHttpClient() - cert already trusted! Skipping.');
      } else {
        log('customHttpClient().setTrustedCertificateBytes EXCEPTION: $e');
        rethrow;
      }
    } catch (e) {
      log('Exception $e');
      rethrow;
    }

    HttpClient httpClient = HttpClient(context: securityContext);
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;

    return httpClient;
  }

  static Future<http.Client> createIOClient() async {
    IOClient ioClient = IOClient(await customHttpClient());
    return ioClient;
  }
}
