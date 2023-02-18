import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/provider/weather_forecast_provider.dart';
import 'package:weather/services/weather_services.dart';
import 'package:weather/utils/themes.dart';

class SearchResult extends HookWidget {
  const SearchResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectIndex = useState<int>(0);
    final bool isRefresh = context.select((WeatherProvider p) => p.isRefresh);
    final String searchString =
        context.select((WeatherProvider p) => p.searchString);
    final WeatherModel? weather =
        context.select((WeatherProvider p) => p.weatherForecast);
    String dt = DateFormat('yyyy-MM-dd').format(DateTime.now());
    useEffect(() {
      Future.microtask(() async {
        await DailyServices.getWeatherDetails(context, searchString);
      });
      return;
    }, [searchString]);

    return weather != null
        ? Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ColoredBox(
                  color: kColorDarkBlue.withOpacity(.5),
                  child: const SizedBox(
                    height: 2,
                    width: 80,
                  )),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Weather Forecast",
                style: kTextStyleSubtitle2b,
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 5),
              child: isRefresh
                  ? const SizedBox(
                      height: 25,
                      child: SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator()))
                  : const SizedBox.shrink(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                dt.toString(),
                style: kTextStyleSubtitle2b,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                weather.name,
                style: const TextStyle(
                    color: kColorDarkBlue,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),

             Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                weather.description,
                style: const TextStyle(
                    color: kColorDarkBlue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
             Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                weather.weather,
                style: const TextStyle(
                    color: kColorDarkBlue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  GestureDetector(
                    onTap: () {
                      selectIndex.value = 0;
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: 100,
                          height: 200,
                          decoration: BoxDecoration(
                              color: selectIndex.value == 0
                                  ? kColorBlue
                                  : Colors.black54,
                              border: Border.all(
                                color: Colors.white,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                        ),
                        const Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: Text('Temp'),
                            )),
                        Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(15, 70, 15, 0),
                                child: Icon(
                                  weather.feelsLike < 10
                                      ? FontAwesomeIcons.cloudRain
                                      : FontAwesomeIcons.cloudSun,
                                  size: 55,
                                  color: weather.feelsLike < 10
                                      ? Colors.grey
                                      : Colors.amber,
                                ))),
                        Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
                              child: SizedBox(
                                width: 100,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      weather.temp.toString(),
                                      style: const TextStyle(fontSize: 20),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      selectIndex.value = 1;
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: 100,
                          height: 200,
                          decoration: BoxDecoration(
                              color: selectIndex.value == 1
                                  ? kColorBlue
                                  : Colors.black54,
                              border: Border.all(
                                color: Colors.white,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                        ),
                        const Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: Text('Pressure'),
                            )),
                        Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                                padding:const EdgeInsets.fromLTRB(15, 70, 15, 0),
                                child: Icon(FontAwesomeIcons.pushed,
                                  size: 55,
                                  color: weather.pressure < 10
                                      ? Colors.grey
                                      : Colors.amber,
                                ))),
                        Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
                              child: SizedBox(
                                width: 100,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      weather.pressure.toString(),
                                      style: const TextStyle(fontSize: 20),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                   const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      selectIndex.value = 2;
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: 100,
                          height: 200,
                          decoration: BoxDecoration(
                              color: selectIndex.value == 2
                                  ? kColorBlue
                                  : Colors.black54,
                              border: Border.all(
                                color: Colors.white,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                        ),
                        const Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: Text('Humidity'),
                            )),
                        Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(15, 70, 15, 0),
                                child: Icon(FontAwesomeIcons.pushed,
                                  size: 55,
                                  color: weather.humidity < 50
                                      ? Colors.grey
                                      : Colors.amber,
                                ))),
                        Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
                              child: SizedBox(
                                width: 100,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      weather.humidity.toString(),
                                      style: const TextStyle(fontSize: 20),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
          ])
        : Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding:  EdgeInsets.fromLTRB(0, 50, 0, 20),
              child:  Text(
                'Weather Forecast',
                style: kTextStyleSubtitle4b,
              ),
            ),
        Image.asset(
          'assets/globeimg.webp',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          fit: BoxFit.fitWidth,
        )
          ],
        );
  }

}
