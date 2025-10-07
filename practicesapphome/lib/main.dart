import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:practicesapphome/MyFirstApp/myFirstAppMain.dart'
    as my_first_app;
import 'package:practicesapphome/youtube/youtubeMain.dart' as youtube_app;
import 'package:practicesapphome/youtube/src/app_state.dart';
import 'package:practicesapphome/Floating/floatingMain.dart' as floating_app;
import 'Shrine/app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Practicas Desarrollo Mobile',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 157, 157, 228)),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Practicas Desarrollo mobile')),
      body: ListView(
        children: const [
          ExplanationCard(
            title: "My First App",
            icon: Icons.save,
            text:
                "Esta es la Pantalla de Inicio y contiene un resumen de la práctica de desarrollo móvil actual.",
          ),
          ExplanationCard(
            title: "Shrine",
            icon: Icons.shopping_cart,
            text:
                "Una aplicación de comercio electrónico de ejemplo para Flutter.",
          ),
          ExplanationCard(
            title: "Youtube",
            icon: Icons.play_arrow,
            text:
                "Una aplicación de ejemplo para ver listas de reproducción de YouTube.",
          ),
          ExplanationCard(
            title: "Floating",
            icon: Icons.air,
            text: "An example of a floating app bar.",
          ),
        ],
      ),
    );
  }
}

class ExplanationCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String text;

  const ExplanationCard({
    super.key,
    required this.title,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(icon, size: 40),
              title: Text(title, style: Theme.of(context).textTheme.titleLarge),
              subtitle: Text(text),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  if (title == "My First App") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                          create: (context) => my_first_app.MyAppState(),
                          child: my_first_app.MyHomePage(),
                        ),
                      ),
                    );
                  }
                  if (title == "Shrine") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ShrineApp(),
                      ),
                    );
                  }
                  if (title == "Youtube") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ChangeNotifierProvider<FlutterDevPlaylists>(
                          create: (context) => FlutterDevPlaylists(
                            flutterDevAccountId: youtube_app.flutterDevAccountId,
                            youTubeApiKey: youtube_app.youTubeApiKey,
                          ),
                          child: const youtube_app.PlaylistsApp(),
                        ),
                      ),
                    );
                  }
                  if (title == "Floating") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const floating_app.MyApp(),
                      ),
                    );
                  }
                },
                child: const Text('Open'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
