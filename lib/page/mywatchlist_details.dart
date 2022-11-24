import 'package:counter_7/model/watchlist.dart';
import 'package:counter_7/drawer.dart';
import 'package:flutter/material.dart';

class MovieDataText extends StatelessWidget {
  final String title;
  final String value;

  const MovieDataText({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "$title: ",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black87,
          fontSize: 20,
        ),
        children: [
          TextSpan(
            text: value,
            style: const TextStyle(fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}

class MyWatchlistDetailPage extends StatelessWidget {
  final MovieData movie;

  const MyWatchlistDetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
      ),
      drawer: buildDrawer(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                movie.title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
            MovieDataText(title: "Release Date", value: movie.releaseDate),
            const SizedBox(height: 8),
            MovieDataText(title: "Rating", value: "${movie.rating} / 5"),
            const SizedBox(height: 8),
            MovieDataText(
              title: "Status",
              value: movie.watched ? "Watched" : "Not Watched",
            ),
            const SizedBox(height: 8),
            MovieDataText(
              title: "Review",
              value: "\n${movie.review}",
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Back"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
