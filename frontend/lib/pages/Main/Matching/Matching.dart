// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'dart:convert';
import 'package:flings_flutter/components/DropDown/CallingOptionsDropDown.dart';
import 'package:flings_flutter/models/MatchingModel.dart';
import 'package:flings_flutter/models/ProfileModel.dart';
import 'package:flings_flutter/pages/Main/PeopleList/Filter/FilterPage.dart';
import 'package:flings_flutter/routes/apiStrings.dart';
import 'package:flings_flutter/routes/imageURL.dart';
import 'package:flings_flutter/services/InterceptedHTTP.dart';
import 'package:flings_flutter/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MatchingPage extends StatefulWidget {
  const MatchingPage({super.key});

  @override
  State<MatchingPage> createState() => _MatchingPageState();
}

class _MatchingPageState extends State<MatchingPage> {
  late ProfileModel profiles;
  late List<MatchingModel> matchedPeopleArray;
  bool isArrayEmpty = true;
  late Future<List<MatchingModel>> futureMatchedPeople;

  @override
  void initState() {
    futureMatchedPeople = getMatchingPeopleList();
    super.initState();
  }

  var interceptedRequest = InterceptedHTTP();
  Future<List<MatchingModel>> getMatchingPeopleList() async {
    try {
      var response = await interceptedRequest.getHttp(GET_MATCHES_LIST);

      if (response.statusCode == 200) {
        List<dynamic> decodedResponseBody = jsonDecode(response.body);
        matchedPeopleArray = decodedResponseBody
            .map((json) => MatchingModel.fromJson(json))
            .toList();
        setState(() {
          isArrayEmpty = matchedPeopleArray.isEmpty;
        });
        debugPrint(matchedPeopleArray.toString());
        return matchedPeopleArray;
      } else {
        debugPrint("getMatches StatusCode:${response.statusCode}");
        return [];
      }
    } catch (e) {
      debugPrint("Error in getting getMatches:${e.toString()}");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 130,
          child: Card(
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Liked You",
                          style: boldGradientText.copyWith(fontSize: 30),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FilterPage(),
                                  ));
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.sliders,
                              color: Colors.white,
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "When People are into you, they will appear here.Enjoy.",
                      style: whiteNoramlText,
                    )
                  ]),
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Card(
              color: Colors.black,
              child: isArrayEmpty
                  ? Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Till no one liked you, Let's expand your search",
                          style: whiteNoramlText,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.all(15)),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FilterPage()));
                            },
                            child: Text(
                              "Let's expand your search",
                              style: blackBoldText,
                            ))
                      ],
                    ))
                  : FutureBuilder(
                      future: futureMatchedPeople,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                                "There is an Error in Snapshot:${snapshot.error}"),
                          );
                        }
                        List<MatchingModel> matchedPeopleArray = snapshot.data!;
                        return ListView.builder(
                          itemCount: matchedPeopleArray.length,
                          itemBuilder: (context, index) {
                            final person = matchedPeopleArray[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Container(
                                height: 250,
                                width: 200,
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            person.gender == 'Male'
                                                ? MALE_AVATAR
                                                : FEMALE_AVATAR),
                                        fit: BoxFit.cover)),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              person.userName!,
                                              style: whiteBoldText.copyWith(
                                                  fontSize: 20),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              person.gender!,
                                              style: whiteNoramlText.copyWith(
                                                  fontSize: 10),
                                            )
                                          ],
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.more_vert),
                                          color: Colors.white,
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Dialog(
                                                  backgroundColor: Colors.black,
                                                  child:
                                                      CallingOptionDropDown(),
                                                );
                                              },
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ),
        )
      ],
    );
  }
}
