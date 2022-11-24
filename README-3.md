# Tugas 9: Integrasi Web Service pada Flutter

Pemrograman Berbasis Platform (CSGE602022) - diselenggarakan oleh Fakultas Ilmu Komputer Universitas Indonesia, Semester Ganjil 2022/2023

**Nama**  : Alicia Kirana Utomo

**NPM**   : 2106751505

**Kelas** : B

## Pengambilan data JSON tanpa membuat model

Bisa, karena data dapat langsung dimasukkan ke dalam variabel. Hal ini dapat lebih baik sesuai dengan data yang akan diproses. Jika data hanya beruba data kecil yang tidak perlu dibuat menjadi sebuah object, maka hal ini lebih baik.

## Widgets

- AppBar                    : Menampilkan sebuah bar di bagian atas aplikasi Flutter

- Center                    : Membuat _child widgets_ memiliki center alignment

- Column                    : Menyusun _child widgets_ secara vertikal

- Text                      : Menampilkan tulisan/teks

- Floating Action Button    : Menampilkan button yang berbentuk lingkaran yang melayang di atas konten dair aplikasi

- Row                       : Menyusun _child widgets_ secara horizontal

- Visibility                : Mengatur _visibility_ dari _child widgets_

- Container, Padding, Margin    : Menambahkan _padding_ / _margin_

- Icon                      : Menambahkan logo/icon

- Drawer                    : Membuat drawer untuk melihat _subpage_ yang ada dalam sebuah aplikasi

- SizedBox                  : Membuat sebuah box untuk menyimpan _dropdown_

- DropdownButtonFormFIeld   : Membuat _dropdown_

- Card                      : Membuat _card_ untuk menyimpan budget

- MovieDataText             : Membuat _pair_ _key_ data dan _value_ data

## Mekanisme pengambilan data json

1. Variabel `url` akan menyimpan link dari data json

2. Variabel `res` akan menyimpan data yang didapat dari json dan melakukkan setting access

3. Variabel `data` akan menyimpan data yang telah di-_decode_ dan diproses oleh flutter

4. Loop akan menyimpan seluruh data pada `data` ke dalam variabel `myWatchlists`

5. Catch block akan dijalankan ketika program diatas menimbulkan error dan menunjukkan jenis error ke dalam `console`

## Tahap pengimplementasian

1. Membuat beberapa file _dart_ baru, yaitu: `mywatchlist_details.dart`, `mywatchlist.dart`, dan `watchlist.dart`

2. Membuat model untuk menyimpan list film dan data dari film `watchlist.dart` dengan menambahkan kode :

    ```dart
    class MovieData {
    bool watched;
    String title;
    double rating;
    String releaseDate;
    String review;

    MovieData(
        this.watched,
        this.title,
        this.rating,
        this.releaseDate,
        this.review,
    );

    factory MovieData.fromMap(Map<String, dynamic> map) => MovieData(
            map["watched"],
            map["title"],
            map["rating"],
            map["release_date"],
            map["review"],
        );
    }

    class Movie {
    int pk;
    MovieData fields;

    Movie({
        required this.pk,
        required this.fields,
    });

    factory Movie.fromMap(Map<String, dynamic> map) => Movie(
            pk: map["pk"],
            fields: MovieData.fromMap(map["fields"]),
        );
    }
    ```

3. Membuat _page_ untuk melihat list dari seluruh film pada `mywatchlist.dart` dengan menambahkan kode :

    ```dart
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
            border: Border.all(
            color: widget.data.watched ? Colors.green : Colors.grey,
            width: 2,
            ),
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
    ```

4. Menambahkan _page_ untuk melihat detail mengenai data film pada `mywatchlist_details.dart` dengan menambahkan kode :

    ```dart
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
    ```