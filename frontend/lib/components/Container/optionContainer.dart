import 'package:flutter/material.dart';

class OptionContainer extends StatelessWidget {
  final String title;
  final Color? backgroundColor;
  final Color? leadingColor;
  final double borderRadius;
  final VoidCallback? onTap;

  const OptionContainer({
    super.key,
    required this.title,
    this.backgroundColor,
    required this.borderRadius,
    this.leadingColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Text(
          title,
          style: TextStyle(
            color: leadingColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}