import 'dart:ui';

import 'package:flings_flutter/Themes/themes.dart';
import 'package:flings_flutter/styles/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IntrestCard extends StatefulWidget {
  List<String> intrestCardItem;

  IntrestCard({super.key, required this.intrestCardItem});

  @override
  State<IntrestCard> createState() => _IntrestCardState();
}

class _IntrestCardState extends State<IntrestCard> {
  TextEditingController interstController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Intrest",
                style: whiteBoldText.copyWith(fontSize: 20),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: TextFormField(
                          style: whiteBoldText,
                          decoration:  InputDecoration(
                            fillColor: Colors.black,
                            filled: true,
                            hintText: "Enter Your Intrest",
                            
                          ),
                          controller: interstController,
                          onFieldSubmitted: (value) {
                            setState(() {
                              widget.intrestCardItem.add(value);
                              Navigator.pop(context);
                              interstController.clear();
                            });
                          },
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        const Divider(
          thickness: 2,
          color: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Wrap(
            spacing: 3,
            children: widget.intrestCardItem
                .map((item) => Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Chip(
                        
                        deleteIcon: CircleAvatar(
                          backgroundColor: MyTheme.primaryColor,
                          child: const Icon(
                            Icons.delete,
                            color: Colors.black,
                            size: 15,
                          ),
                        ),
                        onDeleted: () {
                          setState(() {
                            widget.intrestCardItem.remove(item);
                          });
                        },
                        backgroundColor: Colors.black,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        label: Text(
                          item,
                          style: whiteNoramlText,
                        ),
                      ),
                    ))
                .toList(),
          ),
        )
      ]),
    );
  }
}
