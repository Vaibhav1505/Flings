// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flings_flutter/Providers/ProfileInformationProvider.dart';
import 'package:flings_flutter/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    var profileInformationProvider =
        Provider.of<ProfileInformationProvider>(context, listen: false);

    List<String> intrestList = [
      'Movie',
      'Adventure',
      'Travel',
      'Romance',
      'Love',
      'Cooking',
      'Gangster',
      'aasi si baara bira'
    ];

    return Scaffold(
      body: Card(
        elevation: 8,
        shadowColor: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: Image(
                fit: BoxFit.fill,
                image: NetworkImage(
                  "https://imgs.search.brave.com/PtyH8zpkcZDkIU4CRdve3CmhMWW0i5oZ0r5tEvanXKA/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9jZG4u/d2FsbHBhcGVyc2Fm/YXJpLmNvbS8xLzUw/L2N4VDU5ei5qcGc",
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Andrew Tate",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text("Male"),
                    SizedBox(height: 8),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut risus in augue luctus venenatis.",
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Intrests",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Wrap(
                      spacing: 5,
                      children: intrestList
                          .map((intrestItem) => Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Chip(
                                  deleteIcon: Icon(Icons.close),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  label: Text(
                                    intrestItem,
                                    style: whiteBoldText,
                                  ),
                                  backgroundColor: Colors.black,
                                ),
                              ))
                          .toList(),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
          label: Text(
            "Go Back",
            style: whiteBoldText,
          )),
    );
  }
}
