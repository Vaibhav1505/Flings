import 'package:flings_flutter/Providers/LocationProvider.dart';
import 'package:flings_flutter/Providers/PeopleListProvider.dart';
import 'package:flings_flutter/Themes/themes.dart';
import 'package:flings_flutter/components/List%20Tile/CustomListTile.dart';
import 'package:flings_flutter/components/BottomBanner/ModalBottomBanner.dart';
import 'package:flings_flutter/components/Buttons/onPressedButton.dart';
import 'package:flings_flutter/components/Others/SwitchWidget.dart';
import 'package:flings_flutter/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  double start = 30.0;
  double end = 50.0;
  double startingRange = 0.0;
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    var locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    var peopleListProvider =
        Provider.of<PeopleListProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          "Narrow your Search",
          style: whiteBoldText,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                  child: Text(
                    "Basic Filters",
                    style: whiteBoldText.copyWith(fontSize: 15),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                  child: Text(
                    "Advanced Filters",
                    style: whiteBoldText.copyWith(fontSize: 15),
                  ),
                )
              ],
            ),
            SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Who would you like to Date?",
                  style: blackBoldText,
                ),
                CustomListTile(
                  onTap: () {
                    
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return const GenderModalContainer();
                      },
                    );
                  },
                  borderRadius: 50,
                  leadingText: "Choose Gender",
                  titleColor: Colors.white,
                  backgroundColor: Colors.black,
                  trailingWidget: const Icon(
                    Icons.chevron_right_outlined,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "How old are they?",
                  style: blackBoldText,
                ),
                Card(
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Between ${start.toStringAsFixed(0)} and ${end.toStringAsFixed(0)}",
                          style: whiteBoldText.copyWith(fontSize: 18),
                        ),
                        RangeSlider(
                            activeColor: MyTheme.primaryColor,
                            values: RangeValues(start, end),
                            labels:
                                RangeLabels(start.toString(), end.toString()),
                            onChanged: (value) {
                              setState(() {
                                start = value.start;
                                end = value.end;
                                peopleListProvider.setAgeRange(start, end);
                              });
                            },
                            max: 80,
                            min: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "See people 2 years either sied if i ran out",
                              style: whiteNoramlText,
                            ),
                            const SwtichWidget()
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "How far they are?",
                  style: blackBoldText,
                ),
                Card(
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Upto ${startingRange.toStringAsFixed(0)} kilometers away",
                          style: whiteBoldText.copyWith(fontSize: 18),
                        ),
                        Slider(
                          activeColor: MyTheme.primaryColor,
                          min: 0.0,
                          max: 100.0,
                          value: startingRange,
                          onChanged: (value) {
                            setState(() {
                              startingRange = value;
                              locationProvider.setSearchingArea(value);
                            });
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "See more people if range ran out",
                              style: whiteNoramlText,
                            ),
                            const SwtichWidget()
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          print("Changes Done!!");
        },
        icon: const FaIcon(
          FontAwesomeIcons.check,
          color: Colors.white,
        ),
        label: Text(
          "Apply Changes",
          style: whiteBoldText,
        ),
        backgroundColor: Colors.black,
      ),
      
    );
  }
}
