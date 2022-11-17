# Tugas 8: Flutter Form

Pemrograman Berbasis Platform (CSGE602022) - diselenggarakan oleh Fakultas Ilmu Komputer Universitas Indonesia, Semester Ganjil 2022/2023

**Nama**  : Alicia Kirana Utomo

**NPM**   : 2106751505

**Kelas** : B

## Perbedaan `Navigator.push` & `Navigator.pushReplacement`

`Navigator.push` akan menambahkan layar baru diatas stack navigasi, sedangkan `Navigator.pushReplacement` akan menambahkan layar baru dan menghapus/menghilangkan layar yang sedang berada di stack navigasi untuk digantikan dengan layar yang baru.

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

## Jenis-jenis _event_ pada Flutter

- `onChanged`               : Meng-_update_ ketika _value_ dari _widget_ diubah

- `onPressed`               : Meng-_update_ ketika _widget_ diklik

- `onPointerHover`          : Meng-_update_ ketika _pointer_ melalui atau meng-_hover_ pada _widget_

- dst ...

## Cara kerja `Navigator`

`Navigator` akan mengubah tampilan halaman dengan membangun layar baru di dalam sebuah aplikasi, lalu melakukan _push_ layar tersebut ke dalam stack aplikasi.

## Tahap pengimplementasian

1. Membuat beberapa file _dart_ baru, yaitu: `drawer.dart`, `form.dart`, `budget.dart`, dan `data.dart`

2. Membuat _drawer_ dalam _app bar_ dalam `drawer.dart` dengan menambahkan kode :

    ```dart
    import 'package:counter_7/data.dart';
    import 'package:counter_7/main.dart';
    import 'package:counter_7/form.dart';
    import 'package:counter_7/budget.dart';
    import 'package:flutter/material.dart';

    Drawer buildDrawer(BuildContext context) {
    return Drawer(
        child: Column(
        children: [
            // Menambahkan clickable menu
            ListTile(
            title: const Text('counter_7'),
            onTap: () {
                // Route menu ke counter
                Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const MyHomePage(title: 'Program Counter')),
                );
            },
            ),
            ListTile(
            title: const Text('Tambah Budget'),
            onTap: () {
                Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyFormPage()),
                );
            },
            ),
            ListTile(
            title: const Text('Data Budget'),
            onTap: () {
                Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ShowBudget()),
                );
            },
            ),
        ],
        ),
    );
    }
    ```

3. Membuat laman "Form Budget" yang berisi _form_ untuk meminta _input_ dari _user_ terkait budget dengan menambahkan kode :

    ```dart
    import 'package:flutter/material.dart';
    import 'package:counter_7/drawer.dart';
    import 'package:counter_7/budget.dart';

    class MyFormPage extends StatefulWidget {
    const MyFormPage({super.key});

    @override
    State<MyFormPage> createState() => _MyFormPageState();
    }

    class _MyFormPageState extends State<MyFormPage> {
    final _formKey = GlobalKey<FormState>();
    String _judulBudget = "";
    int? _nominalBudget = 0;
    String? _jenisBudget;
    DateTime? _dateTime;

    final _controllerJudul = TextEditingController();
    final _controllerNominal = TextEditingController();

    void clearText() {
        _controllerJudul.clear();
        _controllerNominal.clear();

        setState(() {
        _jenisBudget = null;
        _dateTime = null;
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
        appBar: AppBar(
            title: const Text('Form Budget'),
        ),
        drawer: buildDrawer(context),
        body: Form(
            key: _formKey,
            child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    children: [
                    Padding(
                        // Menggunakan padding sebesar 8 pixel
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                TextFormField(
                                decoration: InputDecoration(
                                    hintText: "Contoh: Es Krim",
                                    labelText: "Judul",

                                    // Menambahkan circular border agar lebih rapi
                                    border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    ),
                                ),
                                controller: _controllerJudul,
                                // Menambahkan behavior saat nama diketik
                                onChanged: (String? value) {
                                    setState(() {
                                    _judulBudget = value!;
                                    });
                                },
                                // Menambahkan behavior saat data disimpan
                                onSaved: (String? value) {
                                    setState(() {
                                    _judulBudget = value!;
                                    });
                                },
                                // Validator sebagai validasi form
                                validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                    return 'Judul tidak boleh kosong!';
                                    }
                                    return null;
                                },
                                ),
                                const SizedBox(
                                height: 10,
                                ),
                                TextFormField(
                                controller: _controllerNominal,
                                decoration: InputDecoration(
                                    hintText: "Contoh: 15000",
                                    labelText: "Nominal",
                                    border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    ),
                                ),
                                onChanged: (String? value) {
                                    setState(() {
                                    _nominalBudget = int.tryParse(value!);
                                    });
                                },
                                // Menambahkan behavior saat data disimpan
                                onSaved: (String? value) {
                                    setState(() {
                                    _nominalBudget = int.parse(value!);
                                    });
                                },
                                // Validator sebagai validasi form
                                validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                    return 'Nominal tidak boleh kosong!';
                                    } else if (_nominalBudget == null) {
                                    return 'Nominal harus berupa angka!';
                                    }
                                    return null;
                                },
                                )
                            ])),
                    const SizedBox(
                        height: 10,
                    ),
                    SizedBox(
                        width: 120,
                        child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                            enabledBorder: InputBorder.none,
                        ),
                        hint: const Text("Pilih Jenis"),
                        value: _jenisBudget,
                        validator: (value) =>
                            value == null ? "Pilih Jenis" : null,
                        items: const <DropdownMenuItem<String>>[
                            DropdownMenuItem<String>(
                            value: 'Pengeluaran',
                            child: Text('Pengeluaran'),
                            ),
                            DropdownMenuItem<String>(
                            value: 'Pemasukan',
                            child: Text('Pemasukan'),
                            ),
                        ],
                        onChanged: (String? value) {
                            setState(() {
                            _jenisBudget = value!;
                            });
                        },
                        ),
                    ),
                    const SizedBox(
                        height: 10,
                    ),
                    TextButton(
                        child: Text(_dateTime == null
                            ? "Pilih tanggal"
                            : "${_dateTime!.day}/${_dateTime!.month}/${_dateTime!.year}"),
                        onPressed: () {
                        showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2099),
                        ).then((date) {
                            setState(() {
                            _dateTime = date;
                            });
                        });
                        },
                    ),
                    const Spacer(),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.blue),
                        ),
                        onPressed: () {
                            if (_formKey.currentState!.validate() &&
                                _dateTime != null) {
                            ListBudget.data.add(Budget(_judulBudget,
                                _nominalBudget, _jenisBudget!, _dateTime!));

                            clearText();
                            }
                        },
                        child: const Text(
                            "Simpan",
                            style: TextStyle(color: Colors.white),
                        ),
                        ),
                    )
                    ],
                ))),
        );
    }
    }
    ```

4. Membuat class `Budget` untuk menyimpan data dan mem-_passing_-nya ke halaman "Data Budget" dengan menambahkan kode :

    ```dart
    class Budget {
    String judul = "";
    int? nominal = 0;
    String jenis;
    DateTime date;
    Budget(this.judul, this.nominal, this.jenis, this.date);
    }

    class ListBudget {
    static List<Budget> data = [];
    }
    ```

5. Membuat laman "Data Budget" untuk menampilkan data yang berhasil di-_passing_ dari halaman "Form Budget" dengan menambahkan kode :

    ```dart
    import 'package:flutter/material.dart';
    import 'package:counter_7/drawer.dart';
    import 'package:counter_7/budget.dart';

    class ShowBudget extends StatefulWidget {
    const ShowBudget({super.key});

    @override
    State<ShowBudget> createState() => _ShowBudgetState();
    }

    class _ShowBudgetState extends State<ShowBudget> {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
            title: const Text('Form Budget'),
            ),
            drawer: buildDrawer(context),
            body: SingleChildScrollView(
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Column(
                        children: ListBudget.data
                            .map((budget) => Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(.15),
                                        blurRadius: 20.0, // soften the shadow
                                        spreadRadius: 0.0, //extend the shadow
                                        offset: const Offset(
                                        1.0, // Move to right 10  horizontally
                                        1.0, // Move to bottom 10 Vertically
                                        ),
                                    )
                                    ],
                                ),
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: SizedBox(
                                    height: 100,
                                    child: Container(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(
                                            children: [
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                    Text(
                                                    budget.judul,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 18),
                                                    ),
                                                    Text(
                                                    "${budget.date.day}/${budget.date.month}/${budget.date.year}",
                                                    ),
                                                ]),
                                            const Spacer(),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                children: [
                                                Text(budget.nominal.toString()),
                                                Text(budget.jenis)
                                                ],
                                            )
                                            ],
                                        )),
                                    ),
                                ),
                                ))
                            .toList()))));
    }
    }
    ```