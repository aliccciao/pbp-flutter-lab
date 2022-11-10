# Tugas 7: Elemen Dasar Flutter

Pemrograman Berbasis Platform (CSGE602022) - diselenggarakan oleh Fakultas Ilmu Komputer Universitas Indonesia, Semester Ganjil 2022/2023

**Nama**  : Alicia Kirana Utomo

**NPM**   : 2106751505

**Kelas** : B

## Stateless & Stateful Widget

_Stateless widget_ adalah widget yang bersifat statis dan menggunakan _base configuration_ yang dimuat pada saat inisiasi awal _widget_. _Stateful widget_ adalah _widget_ yang bersifat dinamis dan dapat diperbaharui kapan saja berdasarkan perilaku pengguna atau ketika terjadi perubahan data.

## Widgets

- AppBar                    : Menampilkan sebuah bar di bagian atas aplikasi Flutter

- Center                    : Membuat _child widgets_ memiliki center alignment

- Column                    : Menyusun _child widgets_ secara vertikal

- Text                      : Menampilkan tulisan/teks

- Floating Action Button    : Menampilkan button yang berbentuk lingkaran yang melayang di atas konten dair aplikasi

- Row                       : Menyusun _child widgets_ secara horizontal

- Visibility                : Mengatur _visibility_ dari _child widgets_

- Container                 : Menambahkan _padding_ / _margin_

- Icon                      : Menambahkan logo/icon

## Fungsi `setState()`

`setState()` berfungsi untuk menandakan _framework_ bahwa internal _state_ dari sebuah objek telah diubah yang dapat mempengaruhi tampilan untuk _user_. `setState()` perlu digunakan untuk meng-_update_ _state_ dari sebuah objek. Variabel yang terdampak dari `setState()` adalah `_counter`.

## Const vs Final

Const   : variabel yang bersifat _immutable_ dengan _value_ yang konstan dan harus sudah di-_set_ pada saat _compile time_.

Final   : variabel yang diinisiasikan pada saat _run-time_, maka tidak dapat dilakukan penyetelan ulang.

## Tahap pengimplementasian

1. Membuat aplikasi baru bernama `counter_7`.

2. Mengganti beberapa kode pada _default code_ yang disediakan Flutter, diantaranya :

    a. Mengganti _title_ pada `MyHomePage` dari "Flutter Demo Home Page" menjadi "Program Counter"

    b. Menambahkan _function_ pada _class_ `_MyHomePageState` :

    ```dart
    void _decrementCounter() {
        setState(() {
        if (_counter > 0) {
            _counter--;
        }
        });
    }
    ```

    c. Membuat _conditionals_ untuk menampilkan teks "GANJIL" atau "GENAP" :

    ```dart
    _counter % 2 == 0
        ? const Text('GENAP', style: TextStyle(color: Colors.redAccent))
        : const Text('GANJIL', style: TextStyle(color: Colors.blueAccent)),
    ```

    d. Membuat 2 _buttons_ untuk _increment_ atau _decrement_ `_counter` :

    ```dart
    floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
            Visibility(
                visible: _counter > 0,
                child: Container(
                    margin: const EdgeInsets.all(10),
                    child: FloatingActionButton(
                    onPressed: _decrementCounter,
                    backgroundColor: Colors.blueAccent,
                    tooltip: 'Increment',
                    child: Icon(Icons.remove),
                    )
                )),
            Container(
                margin: const EdgeInsets.all(10),
                child: FloatingActionButton(
                onPressed: _incrementCounter,
                backgroundColor: Colors.blueAccent,
                tooltip: 'Increment',
                child: Icon(Icons.add),
                )),
        ],
    ),
    ```