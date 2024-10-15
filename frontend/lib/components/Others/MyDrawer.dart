import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      backgroundColor: Colors.white,
      child: Column(
        children: [
          DrawerHeader(
              child: Column(
            children: [
              Expanded(child: generateUserQRCode('66d34f8dc7aa3a2258374720')),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Connect via QR Code",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontSize: 10),
              ),
            ],
          )),
          ListTile(
            onTap: () {
              debugPrint("Navigate to Home");
            },
            leading: const Icon(
              Icons.settings,
              color: Colors.black,
            ),
            title: const Text("Setting"),
          ),
          ListTile(
            onTap: () {
              debugPrint("Navigate to Home");
            },
            leading: const Icon(
              Icons.privacy_tip,
              color: Colors.black,
            ),
            title: const Text("Privacy and Security"),
          ),
          ListTile(
            onTap: () {
              debugPrint("Navigate to Home");
            },
            leading: const Icon(
              Icons.attach_money_sharp,
              color: Colors.black,
            ),
            title: const Text("Plans"),
          ),
          ListTile(
            onTap: () {
              debugPrint("Navigate to Home");
            },
            leading: const Icon(
              Icons.share,
              color: Colors.black,
            ),
            title: const Text("Share my Profile"),
          ),
          const ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.black,
            ),
            title: Text("Logout"),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ListTile(
                    leading: const Icon(Icons.camera_alt_outlined),
                    title: const Text("Scan QR Code"),
                    onTap: () {
                      print("Hello qr");
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.qr_code),
                    title: const Text("Select QR From Gallery"),
                    onTap: () {
                      print("helllo gallery");
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget generateUserQRCode(String userID) {
  return QrImageView(
    data: userID,
    version: QrVersions.auto,
    embeddedImage: const AssetImage('assets/images/mainLogo-png.png'),
    embeddedImageStyle: const QrEmbeddedImageStyle(
      size: Size(25, 25),
    ),
  );
}
