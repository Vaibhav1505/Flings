import 'dart:convert';
import 'package:flings_flutter/Themes/themes.dart';
import 'package:flings_flutter/components/Others/Chip.dart';
import 'package:flings_flutter/models/MatchingModel.dart';
import 'package:flings_flutter/pages/Main/Chat/ChatPage.dart';
import 'package:flings_flutter/pages/Main/PeopleList/Filter/FilterPage.dart';
import 'package:flings_flutter/routes/apiStrings.dart';
import 'package:flings_flutter/routes/imageURL.dart';
import 'package:flings_flutter/services/InterceptedHTTP.dart';
import 'package:flings_flutter/styles/text.dart';
import 'package:flutter/material.dart';

class ChatPeopleListPage extends StatefulWidget {
  const ChatPeopleListPage({super.key});

  @override
  State<ChatPeopleListPage> createState() => _ChatPeopleListPageState();
}

class _ChatPeopleListPageState extends State<ChatPeopleListPage> {
  bool isUnreadMessage = true;
  var currentTime = '${DateTime.now().hour}:${DateTime.now().minute}';
  var interceptedRequest = InterceptedHTTP();
  late List<MatchingModel> matchedPeopleArray;
  bool isArrayEmpty = true;


  late Future<List<MatchingModel>> futureMatchedPeople;

  @override
  void initState() {
    futureMatchedPeople = getMatchingPeopleList();
    super.initState();
  }

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Chats",
                      style: boldGradientText.copyWith(fontSize: 30),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MessageChip(
                        chipLabelText: "Total Messages",
                        messageCount: "15",
                        chipColor: Colors.white,
                      ),
                      MessageChip(
                        chipLabelText: "Unread",
                        messageCount: "5",
                        chipColor: Colors.white,
                      ),
                      MessageChip(
                        chipLabelText: "Total",
                        messageCount: "10",
                        chipColor: Colors.white,
                      )
                    ],
                  ),
                ],
              )),
        ),
        const SizedBox(
          height: 2,
        ),
        Expanded(
            child: isArrayEmpty
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Connections start here",
                                  style: whiteBoldText.copyWith(fontSize: 30)),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "When you swipe right on each other,you'll match. Here is where you can chat.",
                                style: whiteNoramlText,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              ElevatedButton(
                                  style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(10),
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.all(15)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white)),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return const FilterPage();
                                      },
                                    ));
                                  },
                                  child: Text(
                                    "Keep Connecting",
                                    style: blackBoldText,
                                  ))
                            ]),
                      ),
                    ),
                  )
                : FutureBuilder(
                    future: futureMatchedPeople,
                    builder: (context, snapshot) {
                      debugPrint(
                          "Snapshot connectionState from ChatPeoplePageList:${snapshot.connectionState}");
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: MyTheme.primaryColor,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                              'Error in getting Chatting Page ${snapshot.error}'),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            color: Colors.black,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Connections start here",
                                        style: whiteBoldText.copyWith(
                                            fontSize: 30)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "When you swipe right on each other, you'll match. Here is where you can chat.",
                                      style: whiteNoramlText,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                          elevation:
                                              MaterialStateProperty.all(10),
                                          padding: MaterialStateProperty.all(
                                              const EdgeInsets.all(15)),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white)),
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return const FilterPage();
                                          },
                                        ));
                                      },
                                      child: Text(
                                        "Keep Connecting",
                                        style: blackBoldText,
                                      ),
                                    )
                                  ]),
                            ),
                          ),
                        );
                      }

                      List<MatchingModel> peopleList = snapshot.data!;
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          color: Colors.black,
                          elevation: 10,
                          child: Column(children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: peopleList.length,
                                itemBuilder: (context, index) {
                                  final person = peopleList[index];

                                  return ListTile(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return ChatPage(
                                          userName:
                                              person.userName ?? "Unknown",
                                          targetUserID: person.userId!,
                                          gender: person.gender,
                                          matchId: person.sId,
                                        );
                                      }));
                                    },
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          person.gender == 'Male'
                                              ? MALE_AVATAR
                                              : FEMALE_AVATAR),
                                    ),
                                    title: Text(
                                      person.userName ?? "No username",
                                      style:
                                          whiteBoldText.copyWith(fontSize: 15),
                                    ),
                                    subtitle: Text(
                                      person.lastMessage ??
                                          "There are no messages till now",
                                      style:
                                          greyNormalText.copyWith(fontSize: 12),
                                    ),
                                    trailing: isUnreadMessage
                                        ? CircleAvatar(
                                            radius: 10,
                                            backgroundColor:
                                                MyTheme.primaryColor,
                                            child: Text(
                                              '1',
                                              style: blackBoldText.copyWith(
                                                  fontSize: 10),
                                            ),
                                          )
                                        : Text(currentTime),
                                  );
                                },
                              ),
                            ),
                          ]),
                        ),
                      );
                    },
                  ))
      ],
    );
  }
}
