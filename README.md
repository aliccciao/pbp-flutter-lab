# Tugas 7: Elemen Dasar Flutter

Pemrograman Berbasis Platform (CSGE602022) - diselenggarakan oleh Fakultas Ilmu Komputer Universitas Indonesia, Semester Ganjil 2022/2023

**Nama**  : Alicia Kirana Utomo

**NPM**   : 2106751505

**Kelas** : B

## Stateless & Stateful Widget

Stateless widget adalah widget yang bersifat statis dan menggunakan base configuration yang dimuat pada saat inisiasi awal widget. Stateful widget adalah widget yang bersifat dinamis dan dapat diperbaharui kapan saja berdasarkan perilaku pengguna atau ketika terjadi perubahan data.

## Widgets

- AppBar                    : Menampilkan sebuah bar di bagian atas aplikasi Flutter

- Center                    : Membuat child widgets memiliki center alignment

- Column                    : Menyusun child widgets secara vertikal

- Text                      : Menampilkan tulisan/teks

- Floating Action Button    : Menampilkan button yang berbentuk lingkaran yang melayang di atas konten dair aplikasi

- Row                       : Menyusun child widgets secara horizontal

- Visibility                : Mengatur visibility dari child widgets

- Container                 : Menambahkan padding / margin

- Icon                      : Menambahkan logo/icon

## Fungsi `setState()`

`setState()` berfungsi untuk menandakan framework bahwa internal state dari sebuah objek telah diubah yang dapat mempengaruhi tampilan untuk user. `setState()` perlu digunakan untuk meng-update state dari sebuah objek. Variabel yang terdampak dari `setState()` adalah `_counter`.

## Const vs Final

Const   : variabel yang bersifat immutable dengan value yang konstan dan harus sudah di-set pada saat compile time.

Final   : variabel yang diinisiasikan pada saat run-time, maka tidak dapat dilakukan penyetelan ulang.

## Tahap pengimplementasian

1. Membuat aplikasi baru bernama `counter_7`.

2. Mengganti beberapa kode pada default code yang disediakan Flutter, diantaranya :

    a. Mengganti title pada `MyHomePage` dari "Flutter Demo Home Page" menjadi "Program Counter"

    b. Menambahkan function pada class `_MyHomePageState` :

    ```dart
    void _decrementCounter() {
        setState(() {
        if (_counter > 0) {
            _counter--;
        }
        });
    }
    ```

    c. Membuat conditionals untuk menampilkan teks "GANJIL" atau "GENAP" :

    ```dart
    _counter % 2 == 0
        ? const Text('GENAP', style: TextStyle(color: Colors.redAccent))
        : const Text('GANJIL', style: TextStyle(color: Colors.blueAccent)),
    ```

    d. Membuat 2 buttons untuk increment atau decrement `_counter` :

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
3. 