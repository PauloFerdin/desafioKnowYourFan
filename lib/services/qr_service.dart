import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRService {
  static Widget gerarQRCode(String dados) {
    return QrImageView(
      data: dados,
      version: QrVersions.auto,
      size: 200.0,
      backgroundColor: Colors.transparent,
      eyeStyle: const QrEyeStyle(
        color: Colors.white,
        eyeShape: QrEyeShape.square,
      ),
      dataModuleStyle: const QrDataModuleStyle(
        color: Colors.white,
        dataModuleShape: QrDataModuleShape.square,
      ),
      embeddedImage: const AssetImage('assets/images/furia_logo.png'),
      embeddedImageStyle: const QrEmbeddedImageStyle(
        size: Size(40, 40),
      ),
    );
  }
}
