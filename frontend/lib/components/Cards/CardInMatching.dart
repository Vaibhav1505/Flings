import 'package:flings_flutter/styles/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardInMatching extends StatelessWidget {
  const CardInMatching({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(
                "https://imgs.search.brave.com/PtyH8zpkcZDkIU4CRdve3CmhMWW0i5oZ0r5tEvanXKA/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9jZG4u/d2FsbHBhcGVyc2Fm/YXJpLmNvbS8xLzUw/L2N4VDU5ei5qcGc",
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 20),
              Expanded(
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Text("Andrew Bhaiya",
                            style: blackBoldText.copyWith(fontSize: 20)),
                        const SizedBox(height: 2),
                        Text("Lucknow, India", style: greyNormalText),
                        ButtonBar(
                          alignment: MainAxisAlignment.start,
                          children: [
                            TextButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.message),
                                label: Text("")),
                            TextButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.person_add_disabled_sharp),
                                label: Text(""))
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
