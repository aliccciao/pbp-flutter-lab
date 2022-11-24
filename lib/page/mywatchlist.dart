import 'package:counter_7/model/watchlist.dart';
import 'package:counter_7/page/mywatchlist_details.dart';
import 'package:counter_7/drawer.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WatchlistBox extends StatefulWidget {
  final MovieData data;

  const WatchlistBox({super.key, required this.data});

  @override
  State<WatchlistBox> createState() => _WatchlistBoxState();
}

class _WatchlistBoxState extends State<WatchlistBox> {
  String checkWatched() {
    if (widget.data.watched) {
      return "✅";
    } else {
      return "❎";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
      ),
      child: ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyWatchlistDetailPage(movie: widget.data),
              ),
            );
          },
          title: Text(widget.data.title),
          trailing: TextButton(
              child: Text(checkWatched()),
              onPressed: () {
                if (widget.data.watched == true) {
                  setState(() {
                    widget.data.watched = false;
                  });
                } else {
                  setState(() {
                    widget.data.watched = true;
                  });
                }
              })),
    );
  }
}

Future<List<Movie>> loadData() async {
  List<Movie> myWatchlists = [];

  try {
    final url = "https://tugas-1-pbp.herokuapp.com/mywatchlist/json/";

    final res = await http.get(Uri.parse(url), headers: {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*'
    });
    final data = jsonDecode(res.body);

    for (dynamic item in data) {
      if (item != null) {
        myWatchlists.add(Movie.fromMap(item));
      }
    }
  } catch (error) {
    print(error);
  }

  return myWatchlists;
}

class ShowWatchlist extends StatefulWidget {
  const ShowWatchlist({super.key});

  @override
  State<ShowWatchlist> createState() => _MyWatchlistPageState();
}

class _MyWatchlistPageState extends State<ShowWatchlist> {
  Future<List<Movie>> future = loadData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: buildDrawer(context),
        appBar: AppBar(title: const Text("My Watch List")),
        body: RefreshIndicator(
          onRefresh: () {
            setState(() {
              future = loadData();
            });
            return future;
          },
          child: FutureBuilder(
            initialData: const <Movie>[],
            future: future,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final watchlists = snapshot.data ?? [];

              return ListView.builder(
                itemCount: watchlists.length,
                itemBuilder: (context, i) => WatchlistBox(
                  data: watchlists[i].fields,
                ),
              );
            },
          ),
        ));
  }
}
