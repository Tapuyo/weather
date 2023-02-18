import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:weather/drawer/drawer.dart';
import 'package:weather/models/user_model.dart';
import 'package:weather/provider/user_provider.dart';
import 'package:weather/provider/weather_forecast_provider.dart';
import 'package:weather/services/weather_services.dart';
import 'package:weather/ui/search_result.dart';
import 'package:weather/utils/custom_button.dart';
import 'package:weather/utils/text_form_field.dart';
import 'package:weather/utils/themes.dart';

class MobileHomePage extends StatefulWidget {
  const MobileHomePage({super.key});

  @override
  State<MobileHomePage> createState() => _MobileHomePageState();
}

class _MobileHomePageState extends State<MobileHomePage> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool notifnum = false;
  bool isDrawerOpen = false;
  bool isSearchShow = false;

  TextEditingController searchController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    final UserModel user = context.select((UserProvider p) => p.userAuth!);
    final size = MediaQuery.of(context).size;

    return Stack(
      children: <Widget>[
        DrawerPage(
          onTap: () {
            setState(
              () {
                xOffset = 0;
                yOffset = 0;
                scaleFactor = 1;
                isDrawerOpen = false;
              },
            );
          },
          key: const Key('value'),
        ),
        AnimatedContainer(
          transform: Matrix4.translationValues(xOffset, yOffset, 0)
            ..scale(scaleFactor)
            ..rotateY(isDrawerOpen ? -0.5 : 0),
          duration: const Duration(milliseconds: 250),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0),
            child: Scaffold(
                body: Padding(
              padding: const EdgeInsets.fromLTRB(12, 70, 12, 0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (isDrawerOpen) {
                        setState(
                          () {
                            xOffset = 0;
                            yOffset = 0;
                            scaleFactor = 1;
                            isDrawerOpen = false;
                          },
                        );
                      } else {
                        setState(() {
                          xOffset = size.width - size.width / 3;
                          yOffset = size.height * 0.1;
                          scaleFactor = 0.8;
                          isDrawerOpen = true;
                        });
                      }
                    },
                    child: Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 25.0,
                              backgroundImage: NetworkImage(user.photoURL),
                              backgroundColor: Colors.transparent,
                            )),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Welcome!',
                              style: kTextStyleHeadline6w,
                            ),
                            Text(
                              user.userName,
                              style: kTextStyleBody2b,
                            ),
                          ],
                        ),
                        const Spacer(),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                isSearchShow = !isSearchShow;
                              });
                            },
                            child: Icon(
                              isSearchShow ? Icons.close : Icons.search,
                              size: 35,
                            ))
                      ],
                    ),
                  ),
                  searchBody(),
                ],
              ),
            )),
          ),
        ),
      ],
    );
  }

  Widget searchBody() {
    final weatherProvider = context.read<WeatherProvider>();
    return Column(
      children: [
        if (isSearchShow)
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 125,
                child: CustomTextFormField(
                    controller: searchController, hintText: 'Search City...'),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: CustomButton(
                  borderRadius: 8,
                  textSize: 12,
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  text: 'Search',
                  onPressed: () async {
                    weatherProvider.setSearchString(searchController.text);
                  },
                ),
              )
            ],
          ),
        const SearchResult(),
      ],
    );
  }
}
