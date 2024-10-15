import 'package:flings_flutter/Themes/themes.dart';
import 'package:flings_flutter/models/ProfileModel.dart';
import 'package:flings_flutter/routes/apiStrings.dart';
import 'package:flings_flutter/services/InterceptedHTTP.dart';
import 'package:flings_flutter/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DragCard extends StatelessWidget {
  final ProfileModel profile;

  DragCard({
    super.key,
    required this.profile,
  });

  var interceptedRequest = InterceptedHTTP();

  // Function for Accepting User
  void acceptUser(String targetUserID) async {
    try {
      var data = {'targetProfileId': targetUserID};
      var response = await interceptedRequest.postHttp(ACCEPT_USER, data);
      if (response.statusCode == 200) {
        debugPrint("AccpetUser ResponseCode:${response.statusCode}");
      } else {
        debugPrint(
            "Unable to Hit API:{ACCEPT_USER}, Data Parameters are not Correct");
      }
    } catch (e) {
      debugPrint("Error in Accpeting User:${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (profile == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Loading Profile Data"),
          CircularProgressIndicator(
            color: MyTheme.primaryColor,
          )
        ],
      );
    }
    return Card(
      elevation: 10,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(14)),
            image: DecorationImage(
                image: NetworkImage(
                  profile.gender == 'Male'
                      ? 'https://imgs.search.brave.com/rbr9HK5JYyaSojMzClbvF1IFlOJuRY8xj70r52mvJOM/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly91cGxv/YWQud2lraW1lZGlh/Lm9yZy93aWtpcGVk/aWEvY29tbW9ucy9j/L2M4L0phY2tfUmVh/Y2hlci1fTmV2ZXJf/R29fQmFja19KYXBh/bl9QcmVtaWVyZV9S/ZWRfQ2FycGV0LV9U/b21fQ3J1aXNlXygz/NTMzODQ5MzE1Milf/KGNyb3BwZWQpLmpw/Zw'
                      : 'https://imgs.search.brave.com/mkPJVIMqKVIgIM2tBwhyc9-Fj4prnvDQD2EfhfFiZpU/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvMTI0/ODEwMjA4MC9waG90/by9hbmEtZGUtYXJt/YXMtYXQtdGhlLTk1/dGgtYW5udWFsLWFj/YWRlbXktYXdhcmRz/LWhlbGQtYXQtb3Zh/dGlvbi1ob2xseXdv/b2Qtb24tbWFyY2gt/MTItMjAyMy1pbi5q/cGc_cz02MTJ4NjEy/Jnc9MCZrPTIwJmM9/bEJtcXc0bUd4Sk1w/UmU4Ny15bklZNHM3/TWx2T3pndEN0Vzd0/bTFzX21Vaz0',
                ),
                fit: BoxFit.fill)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.name ?? "No Username",
                style: whiteBoldText.copyWith(fontSize: 25),
              ),
              Text(
                  "${profile.filterPref?.basic?.distance ?? "Unknown"} km away",
                  // "Distance away",
                  style: whiteNoramlText.copyWith(fontSize: 15)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        iconSize: 25,
                        onPressed: () {
                          acceptUser(profile.id.toString());
                        },
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )),
                    IconButton(
                        iconSize: 35,
                        onPressed: () {},
                        icon: Icon(
                          Icons.star,
                          color: MyTheme.primaryColor,
                        )),
                    IconButton(
                        iconSize: 25,
                        onPressed: () {},
                        icon: const Icon(
                          FontAwesomeIcons.xmark,
                          color: Colors.white,
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
