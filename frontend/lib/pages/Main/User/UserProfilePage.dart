// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:flings_flutter/Providers/ProfileInformationProvider.dart';
import 'package:flings_flutter/Themes/themes.dart';
import 'package:flings_flutter/components/Cards/IntrestCard.dart';
import 'package:flings_flutter/components/Container/ImageUploadContainer.dart';
import 'package:flings_flutter/components/Others/MyDrawer.dart';
import 'package:flings_flutter/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  String? imagePath;
  bool isVerified = true;

  List<String> buttonBarItems = [
    'Subscription',
    'My Plan',
    'Profile',
    'Safety and Welbeing',
    'User Account',
    'Setting',
    'Log out'
  ];

  @override
  Widget build(BuildContext context) {
    var profileInformationProvider =
        Provider.of<ProfileInformationProvider>(context, listen: false);

    return profileInformationProvider.isLoading
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Please wait while we process your information",style: boldGradientText.copyWith(fontSize: 15),),
                SizedBox(height: 10,),
                CircularProgressIndicator(
                  color: MyTheme.primaryColor,
                ),
              ],
            ),
          )
        : Scaffold(
            drawer: MyDrawer(),
            appBar: AppBar(
              title: Text(
                "Profile",
                style: whiteBoldText,
              ),
              backgroundColor: Colors.black,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Card(
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                          radius: 53,
                          backgroundColor: MyTheme.primaryColor,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                                'https://imgs.search.brave.com/4N5wu3bV9InDg4wOO8d3UR_boQfkJcpoHJjIyM_QLBs/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9tLm1l/ZGlhLWFtYXpvbi5j/b20vaW1hZ2VzL00v/TVY1Qk5tVTBZVFl5/WVdZdE1HTTFNeTAw/TVRrNExUbGlOek10/TjJFMU1UTXdPRGcw/WlRWbFhrRXlYa0Zx/Y0dkZVFYVnlNVFkw/TkRFek5EVTMuX1Yx/X1FMNzVfVVg4MjBf/LmpwZw'),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profileInformationProvider.userName!,
                              style: whiteBoldText.copyWith(fontSize: 20),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "monalisa@duniya.com",
                              style: greyNormalText.copyWith(fontSize: 12),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Chip(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              label: Text(
                                "% Profile Completed",
                                style: whiteBoldText,
                              ),
                              avatar: CircleAvatar(
                                backgroundColor: MyTheme.primaryColor,
                                child: Text(
                                  "50",
                                  style: blackBoldText.copyWith(fontSize: 10),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Card(
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Photos",
                                style: whiteBoldText.copyWith(fontSize: 20),
                              ),
                              InkWell(
                                onTap: () {
                                  debugPrint("Only 2 images Uploaded");
                                },
                                child: Chip(
                                  label: Text(
                                    "View All",
                                    style: whiteNoramlText,
                                  ),
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 100,
                            child: ListView.separated(
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  width: 5,
                                );
                              },
                              itemCount: 2,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: ((context, index) {
                                return ImageUploadContainer();
                              }),
                            ),
                          )
                        ]),
                  ),
                ),
                IntrestCard(intrestCardItem: buttonBarItems)
              ],
            ));

    // Stack(
    //   children: [
    //     Container(
    //       decoration: BoxDecoration(color: Colors.grey[100]),
    //       width: double.infinity,
    //       height: double.infinity,
    //       child: Padding(
    //           padding: const EdgeInsets.only(top: 260),
    //           child: Column(
    //             children: [
    //               SingleChildScrollView(
    //                 scrollDirection: Axis.horizontal,
    //                 child: Row(
    //                   children: [
    //                     ButtonBar(
    //                       alignment: MainAxisAlignment.start,
    //                       children: [
    //                         TextButton(
    //                           onPressed: () {},
    //                           child: Text(
    //                             "My Plan",
    //                             style: TextStyle(color: Colors.white),
    //                           ),
    //                           style: ButtonStyle(
    //                               backgroundColor:
    //                                   MaterialStateProperty.all(Colors.black)),
    //                         ),
    //                         TextButton(
    //                           onPressed: () {
    //                             showDialog(
    //                               context: context,
    //                               builder: (context) {
    //                                 return Dialog(
    //                                   backgroundColor: Colors.black,
    //                                   child: ProfileCard(),
    //                                 );
    //                               },
    //                             );
    //                           },
    //                           child: Text(
    //                             "Profile",
    //                             style: TextStyle(color: Colors.white),
    //                           ),
    //                           style: ButtonStyle(
    //                               backgroundColor:
    //                                   MaterialStateProperty.all(Colors.black)),
    //                         ),
    //                         TextButton(
    //                           onPressed: () {},
    //                           child: Text(
    //                             "Safety and Welbeing",
    //                             style: TextStyle(color: Colors.white),
    //                           ),
    //                           style: ButtonStyle(
    //                               backgroundColor:
    //                                   MaterialStateProperty.all(Colors.black)),
    //                         ),
    //                         TextButton(
    //                           onPressed: () {
    //                             Navigator.push(
    //                                 context,
    //                                 MaterialPageRoute(
    //                                   builder: (context) => UpdateProfile(),
    //                                 ));
    //                           },
    //                           child: Text(
    //                             "Instrests",
    //                             style: TextStyle(color: Colors.white),
    //                           ),
    //                           style: ButtonStyle(
    //                               backgroundColor:
    //                                   MaterialStateProperty.all(Colors.black)),
    //                         ),
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 20,
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.symmetric(horizontal: 20),
    //                 child: Column(
    //                   children: [
    //                     CustomListTile(
    //                       borderRadius: 50,
    //                       backgroundColor: Colors.black,
    //                       leadingWidget: Icon(
    //                         Icons.settings,
    //                         color: Colors.white,
    //                       ),
    //                       leadingText: "Setting",
    //                       titleColor: Colors.white,
    //                       trailingWidget: Icon(
    //                         CupertinoIcons.right_chevron,
    //                         color: Colors.white,
    //                       ),
    //                     ),
    //                     SizedBox(
    //                       height: 10,
    //                     ),
    //                     CustomListTile(
    //                       borderRadius: 50,
    //                       backgroundColor: Colors.black,
    //                       leadingWidget: Icon(
    //                         CupertinoIcons.doc_fill,
    //                         color: Colors.white,
    //                       ),
    //                       leadingText: "Terms and Condition",
    //                       titleColor: Colors.white,
    //                       trailingWidget: Icon(
    //                         CupertinoIcons.right_chevron,
    //                         color: Colors.white,
    //                       ),
    //                     ),
    //                     SizedBox(
    //                       height: 10,
    //                     ),
    //                     CustomListTile(
    //                       borderRadius: 50,
    //                       backgroundColor: Colors.black,
    //                       leadingWidget: Icon(
    //                         Icons.payment,
    //                         color: Colors.white,
    //                       ),
    //                       leadingText: "Billing Details",
    //                       titleColor: Colors.white,
    //                       trailingWidget: Icon(
    //                         CupertinoIcons.right_chevron,
    //                         color: Colors.white,
    //                       ),
    //                     ),
    //                     SizedBox(
    //                       height: 10,
    //                     ),
    //                     CustomListTile(
    //                       borderRadius: 50,
    //                       backgroundColor: Colors.black,
    //                       leadingWidget: Icon(Icons.privacy_tip_outlined,
    //                           color: Colors.white),
    //                       leadingText: "Privacy and Policy",
    //                       titleColor: Colors.white,
    //                       trailingWidget: Icon(
    //                         CupertinoIcons.right_chevron,
    //                         color: Colors.white,
    //                       ),
    //                     ),
    //                     SizedBox(
    //                       height: 10,
    //                     ),
    //                     CustomListTile(
    //                       borderRadius: 50,
    //                       backgroundColor: Colors.black,
    //                       leadingWidget: Icon(
    //                         Icons.logout_outlined,
    //                         color: Colors.white,
    //                       ),
    //                       leadingText: "Logout",
    //                       titleColor: Colors.white,
    //                       trailingWidget: Icon(
    //                         CupertinoIcons.right_chevron,
    //                         color: Colors.white,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               )
    //             ],
    //           )),
    //     ),
    //     Container(
    //       decoration: BoxDecoration(
    //         color: Colors.black,
    //         borderRadius: BorderRadius.only(
    //           bottomRight: Radius.circular(25),
    //           bottomLeft: Radius.circular(25),
    //         ),
    //       ),
    //       height: 250,
    //       width: double.infinity,
    //       child: Center(
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             CircleAvatar(
    //                 radius: 75,
    //                 backgroundImage: NetworkImage(
    //                     'https://imgs.search.brave.com/FDv7MCZA9fchghHQCsNvBCiPMUgWz_JliNHuidR2REU/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93YWxs/cGFwZXJjYXZlLmNv/bS93cC93cDExNDg0/MDE1LmpwZw')),
    //             SizedBox(
    //               width: 15,
    //             ),
    //             Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 Row(
    //                   children: [
    //                     Text(
    //                       profileInformationProvider.userName!,
    //                       style: TextStyle(
    //                           color: Colors.white,
    //                           fontWeight: FontWeight.bold,
    //                           fontSize: 20),
    //                     ),
    //                     SizedBox(
    //                       width: 5,
    //                     ),
    //                     isVerified
    //                         ? Icon(
    //                             Icons.verified_outlined,
    //                             color: Colors.white,
    //                           )
    //                         : Icon(null)
    //                   ],
    //                 ),
    //                 SizedBox(
    //                   height: 5,
    //                 ),
    //                 Text(
    //                   "randomEmail@India.com",
    //                   style: TextStyle(color: Colors.white70),
    //                 ),
    //                 Row(
    //                   children: [
    //                     FaIcon(
    //                       FontAwesomeIcons.phone,
    //                       color: Colors.white,
    //                       size: 15,
    //                     ),
    //                     SizedBox(
    //                       width: 5,
    //                     ),
    //                     Text(
    //                       profileInformationProvider.userMobileNumber!,
    //                       style: greyNormalText,
    //                     ),
    //                   ],
    //                 )
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     )
    //   ],
    // );
  }
}
