import 'package:flings_flutter/Themes/themes.dart';
import 'package:flings_flutter/styles/text.dart';
import 'package:flutter/material.dart';

class MessageChip extends StatelessWidget {
  String chipLabelText;
  Widget? chipAvatar;
  String messageCount;
  Color? chipColor;

  MessageChip(
      {super.key,
      required this.chipLabelText,
      this.chipAvatar,
      required this.messageCount,
      this.chipColor});

  @override
  Widget build(BuildContext context) {
    return Chip(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      backgroundColor: chipColor,
      label: Text(
        chipLabelText,
        style: const TextStyle(color: Colors.black),
      ),
      avatar: CircleAvatar(
        backgroundColor: MyTheme.primaryColor,
        child: Text(messageCount,style: blackBoldText.copyWith(fontSize: 10),),
      ),
    );
  }
}
