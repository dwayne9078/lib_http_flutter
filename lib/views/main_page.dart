import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool showData = false;
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: ListView(
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (!showData) {
                  showData = true;
                }
              });
            }, 
            child: const Text("Metodo Get"),
          ),
          showData ?
          FutureBuilder(
            future: futureAlbum, 
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.title);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              return const CircularProgressIndicator();
            }
          ):
          const CircularProgressIndicator()
        ],
      )
    );
  }
}

class Album {
  final userId;
  final id;
  final title;
  const Album({
    required this.userId,
    required this.id,
    required this.title
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'userId': int userId,
        'id': int id,
        'title': String title
      } =>
        Album(userId: userId, id: id, title: title),
        _ => throw const FormatException('Fallo al obtener el album')
    };
  }
}

Future <Album> fetchData () async {
  // return http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Fallo al obtener el album');
  }
}
