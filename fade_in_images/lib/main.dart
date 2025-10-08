import 'package:flutter/material.dart';

void main() => runApp(const HorizonsApp());

class HorizonsApp extends StatelessWidget {
  const HorizonsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      // ScrollBehavior personalizado para una experiencia consistente
      scrollBehavior: const ConstantScrollBehavior(),
      home: Scaffold(
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              // Permite que el AppBar se estire al hacer overscroll.
              stretch: true,
              // Callback que se ejecuta cuando el AppBar se estira.
              onStretchTrigger: () async {
                // Reemplaza print con debugPrint para evitar problemas en producción
                debugPrint('Load new data!');
              },
              // Altura expandida del AppBar.
              expandedHeight: 200.0,
              backgroundColor: Colors.teal,
              // Espacio flexible que se expande y contrae.
              flexibleSpace: FlexibleSpaceBar(
                title: const Text('Horizons'),
                background: DecoratedBox(
                  position: DecorationPosition.foreground,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                      colors: <Color>[Colors.teal[800]!, Colors.transparent],
                    ),
                  ),
                  child: Image.network(
                    headerImage,
                    fit: BoxFit.cover,
                  ),
                ),
                // Modos de colapso y estiramiento.
                stretchModes: const <StretchMode>[
                  StretchMode.zoomBackground,
                  StretchMode.fadeTitle,
                  StretchMode.blurBackground,
                ],
              ),
              // El AppBar permanece visible en la parte superior.
              pinned: true,
            ),
            const WeeklyForecastList(),
          ],
        ),
      ),
    );
  }
}

class WeeklyForecastList extends StatelessWidget {
  const WeeklyForecastList({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime currentDate = DateTime.now();
    final TextTheme textTheme = Theme.of(context).textTheme;

    // SliverList para una carga perezosa y eficiente de la lista.
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final DailyForecast dailyForecast =
              Server.getDailyForecastByID(index);
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: LayoutBuilder(builder: (context, constraints) {
              final bool isNarrow = constraints.maxWidth < 420;

              // Narrow (portrait mobile) -> Column layout: image on top, text below.
              if (isNarrow) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // Image fills width and keeps a pleasant height.
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0),
                      ),
                      child: SizedBox(
                        height: 180.0,
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            Image.network(
                              dailyForecast.imageId,
                              fit: BoxFit.cover,
                            ),
                            DecoratedBox(
                              position: DecorationPosition.foreground,
                              decoration: BoxDecoration(
                                gradient: RadialGradient(
                                  colors: <Color>[
                                    Colors.grey[900]!.withOpacity(0.6),
                                    Colors.transparent
                                  ],
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                dailyForecast
                                    .getDate(currentDate.day)
                                    .toString(),
                                style: textTheme.displayMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14.0, 12.0, 14.0, 12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Expanded text column
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  dailyForecast
                                      .getWeekday(currentDate.weekday),
                                  style: textTheme.headlineMedium,
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  dailyForecast.description,
                                  style: textTheme.bodyMedium,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          // Temps
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Text(
                              '${dailyForecast.highTemp}° | ${dailyForecast.lowTemp}° F',
                              style: textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }

              // Wide layout (tablet / landscape) -> original Row but with improved rounding
              return Row(
                children: <Widget>[
                  SizedBox(
                    height: 160.0,
                    width: 160.0,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        DecoratedBox(
                          position: DecorationPosition.foreground,
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                              colors: <Color>[
                                Colors.grey[800]!.withOpacity(0.7),
                                Colors.transparent
                              ],
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12.0),
                              bottomLeft: Radius.circular(12.0),
                            ),
                            child: Image.network(
                              dailyForecast.imageId,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            dailyForecast.getDate(currentDate.day).toString(),
                            style: textTheme.displayMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            dailyForecast.getWeekday(currentDate.weekday),
                            style: textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 10.0),
                          Text(dailyForecast.description),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      '${dailyForecast.highTemp}° | ${dailyForecast.lowTemp}° F',
                      style: textTheme.titleMedium,
                    ),
                  ),
                ],
              );
            }),
          );
        },
        childCount: 7,
      ),
    );
  }
}

// -- Datos simulados y clases de ayuda (sin cambios, excepto el constructor de ConstantScrollBehavior) --

const String headerImage =
    'https://images.pexels.com/photos/220201/pexels-photo-220201.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2';

class ConstantScrollBehavior extends ScrollBehavior {
  const ConstantScrollBehavior();

  @override
  Widget buildScrollbar(
          BuildContext context, Widget child, ScrollableDetails details) =>
      child;

  @override
  Widget buildOverscrollIndicator(
          BuildContext context, Widget child, ScrollableDetails details) =>
      child;

  @override
  TargetPlatform getPlatform(BuildContext context) => TargetPlatform.macOS;
}

class DailyForecast {
  const DailyForecast({
    required this.id,
    required this.imageId,
    required this.highTemp,
    required this.lowTemp,
    required this.description,
  });
  final int id;
  final String imageId;
  final int highTemp;
  final int lowTemp;
  final String description;

  static const List<String> _weekdays = <String>[
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  String getWeekday(int today) {
    final int offset = today + id;
    final int day = offset >= 7 ? offset % 7 : offset;
    return _weekdays[day];
  }

  int getDate(int today) => today + id;
}

class Server {
  static List<DailyForecast> getDailyForecasts() => const <DailyForecast>[
        DailyForecast(
          id: 0,
          imageId:
              'https://images.pexels.com/photos/414102/pexels-photo-414102.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
          highTemp: 73,
          lowTemp: 52,
          description:
              'Partly cloudy in the morning, with sun appearing in the afternoon.',
        ),
        DailyForecast(
          id: 1,
          imageId:
              'https://images.pexels.com/photos/326240/pexels-photo-326240.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
          highTemp: 70,
          lowTemp: 50,
          description: 'Partly sunny.',
        ),
        DailyForecast(
          id: 2,
          imageId:
              'https://images.pexels.com/photos/414144/pexels-photo-414144.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
          highTemp: 71,
          lowTemp: 55,
          description: 'Partly cloudy.',
        ),
        DailyForecast(
          id: 3,
          imageId:
              'https://images.pexels.com/photos/1102915/pexels-photo-1102915.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
          highTemp: 74,
          lowTemp: 60,
          description: 'Thunderstorms in the evening.',
        ),
        DailyForecast(
          id: 4,
          imageId:
              'https://images.pexels.com/photos/209831/pexels-photo-209831.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
          highTemp: 67,
          lowTemp: 60,
          description: 'Severe thunderstorm warning.',
        ),
        DailyForecast(
          id: 5,
          imageId:
              'https://images.pexels.com/photos/33545/sunrise-phu-quoc-island-ocean.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
          highTemp: 73,
          lowTemp: 57,
          description: 'Cloudy with showers in the morning.',
        ),
        DailyForecast(
          id: 6,
          imageId:
              'https://images.pexels.com/photos/2832061/pexels-photo-2832061.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
          highTemp: 75,
          lowTemp: 58,
          description: 'Sun throughout the day.',
        ),
      ];

  static DailyForecast getDailyForecastByID(int id) {
    assert(id >= 0 && id <= 6);
    return getDailyForecasts()[id];
  }
}