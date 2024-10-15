import 'package:flutter/cupertino.dart';
import 'package:qr_flutter/qr_flutter.dart';

Widget generateUserQRCode(String userID) {
  return QrImageView(
    data: userID,
    version: QrVersions.auto,
    embeddedImage: const AssetImage('assets/images/background-filled-white-icon-png.png'),
    embeddedImageStyle: const QrEmbeddedImageStyle(
      size: Size(25, 25),
    ),
    errorStateBuilder: (cxt, err) {
    return const Center(
      child: Text(
        'Uh oh! Something went wrong...',
        textAlign: TextAlign.center,
      ),
    );
  },
  );
}