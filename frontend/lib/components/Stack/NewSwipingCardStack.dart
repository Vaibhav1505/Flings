import 'dart:convert';
import 'package:flings_flutter/Providers/LocationProvider.dart';
import 'package:flings_flutter/Themes/themes.dart';
import 'package:flings_flutter/components/Cards/DragCard.dart';
import 'package:flings_flutter/components/Others/Tag.dart';
import 'package:flings_flutter/models/ProfileModel.dart';
import 'package:flings_flutter/pages/Main/PeopleList/Filter/PeopleListEmptyWidget.dart';
import 'package:flings_flutter/routes/apiStrings.dart';
import 'package:flings_flutter/services/InterceptedHTTP.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_cards/swipe_cards.dart';

class NewSwipingCardStack extends StatefulWidget {
  NewSwipingCardStack({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _NewSwipingCardState createState() => _NewSwipingCardState();
}

class _NewSwipingCardState extends State<NewSwipingCardStack> {
  var interceptedRequest = InterceptedHTTP();
  ProfileModel? userProfile;
  bool isLoading = true;
  List<SwipeItem> _swipeItemStack = [];
  MatchEngine? _matchEngine;
  bool isPeoplesArrayEmpty = false;
  late List<ProfileModel> profiles;

  @override
  void initState() {
    loadProfiles();
    super.initState();
  }

//Function for getting list of all people available in your area..

  Future<void> loadProfiles() async {
    try {
      profiles = await setProfiles();
      setState(() {
        if (profiles.isNotEmpty) {
          _swipeItemStack.clear();
          _swipeItemStack.addAll(profiles
              .map((profile) => SwipeItem(
                  content: DragCard(profile: profile),
                  likeAction: () {
                    acceptUser(profile.id.toString());
                  }))
              .toList());
          _matchEngine = MatchEngine(swipeItems: _swipeItemStack);
          isPeoplesArrayEmpty = false;
        } else {
          isPeoplesArrayEmpty = true;
        }
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Error in setupProfiles: ${e.toString()}");
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<List<ProfileModel>> setProfiles() async {
    try {
      var locationProvider =
          Provider.of<LocationProvider>(context, listen: false);
      var data = {
        'longitude': locationProvider.currentLongitude,
        'latitude': locationProvider.currentLatitude,
      };

      var response = await interceptedRequest.postHttp(GET_PEOPLE_LIST, data);

      if (response.statusCode == 200) {
        List<dynamic> parsedJson = jsonDecode(response.body);

        profiles =
            parsedJson.map((json) => ProfileModel.fromJson(json)).toList();

        setState(() {
          isLoading = false;
        });
        return profiles;
      } else {
        throw Exception(
            'Failed to fetch people list. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint("Error in setProfiles: ${e.toString()}");
      rethrow;
    }
  }

//Function for Accepting User
  void acceptUser(String targetUserID) async {
    try {
      var data = {'targetProfileId': targetUserID};
      var response = await interceptedRequest.postHttp(ACCEPT_USER, data);
      if (response.statusCode == 200) {
      } else {
        print(
            "Unable to Hit API:{ACCEPT_USER}, Data Parameters are not Correct");
      }
    } catch (e) {
      debugPrint("Error in Accpeting User:${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return isPeoplesArrayEmpty
        ? const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 200),
            child: PeopleListEmpty(),
          )
        : isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: MyTheme.primaryColor,
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: SwipeCards(
                            matchEngine: _matchEngine!,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: DragCard(
                                  profile: profiles[index],
                                ),
                              );
                            },
                            onStackFinished: () {
                              setState(() {
                                isPeoplesArrayEmpty = !isPeoplesArrayEmpty;
                              });
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                    "There are no more people in your area now"),
                                duration: Duration(milliseconds: 500),
                              ));
                            },
                            itemChanged: (SwipeItem item, int index) {},
                            leftSwipeAllowed: true,
                            rightSwipeAllowed: true,
                            upSwipeAllowed: true,
                            fillSpace: true,
                            likeTag: Tag(
                                TagIcon: const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                                TagColor: Colors.red),
                            nopeTag: Tag(
                                TagIcon: Icon(Icons.close),
                                TagColor: Colors.grey),
                            superLikeTag: Tag(
                                TagIcon: Icon(Icons.star),
                                TagColor: Colors.yellow)),
                      ),
                    ),
                  ]),
                ],
              );
  }
}
