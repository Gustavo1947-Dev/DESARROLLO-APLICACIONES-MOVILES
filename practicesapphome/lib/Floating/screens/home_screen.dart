
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The body of the Scaffold is a CustomScrollView.
      body: CustomScrollView(
        slivers: [
          // Add the app bar to the CustomScrollView.
          SliverAppBar(
            // Provide a standard title.
            title: const Text('Floating App Bar'),
            // Pin the app bar to the top of the screen.
            pinned: true,
            // Make the app bar float as the user scrolls.
            floating: true,
            // Add a flexible space to expand and collapse the app bar.
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                'https://picsum.photos/seed/picsum/400/300',
                fit: BoxFit.cover,
              ),
            ),
            // Make the initial height of the SliverAppBar larger than normal.
            expandedHeight: 200,
          ),
          // Next, create a SliverList.
          SliverList.builder(
            // The builder function returns a ListTile with a title that
            // displays the index of the current item.
            itemBuilder: (context, index) => ListTile(
              title: Text('Item #$index'),
            ),
            // Builds 100 ListTiles
            itemCount: 100,
          ),
        ],
      ),
    );
  }
}
