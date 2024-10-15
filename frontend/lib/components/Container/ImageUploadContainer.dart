import 'package:flutter/material.dart';

class ImageUploadContainer extends StatelessWidget {
  VoidCallback? onTap;
  ImageUploadContainer({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        height: 100,
        width: 100,
        child: const Center(
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
