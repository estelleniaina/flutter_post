import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_post/PostDataModel.dart';
import 'package:flutter_post/PostDetail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Afaas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: ' Csa news'),
      home: DefaultTabController(
        length: 2,
        child: const MyHomePage(title: ' Csa news'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var jsonList;
  var colHover = Colors.amberAccent;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
  }
  void getData() async {
    try {
      var path = 'https://csa.afaas.africa/wp-json/wl/v1/posts';
      var response = await Dio().get(path);
      if (response.statusCode == 200) {
        setState(() {
          jsonList = response.data as List;
        });
      } else {
        print(response.statusCode);
      }
    } catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        bottom: const TabBar(
          tabs: [
            Tab(text : "Actualités"),
            Tab(text : "Sauvegarde"),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Row(
          children: <Widget>[
            Image.asset(
                'assets/icons/AFAAS.png',
                width: 30,
                height: 30,
            ),
            Text(widget.title),
          ],
        ),
      ),
      body: const TabBarView(
        children: [
          Center(child: Text('Chats Page'),),
          Icon(Icons.directions_transit),
        ],
      ),
    );
  }
}



