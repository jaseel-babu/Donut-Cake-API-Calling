import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newsample/model/datamodel.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

Welcome datamodel = Welcome();

getDataFromServer() async {
  final response = await http
      .get(Uri.parse("https://examin.co.in/TestSeries_Android/json-parse.php"));
  final jsondata = json.decode(response.body);
  final map = Welcome.fromJson(jsondata);
  return map;
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    getDataFromServer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final maxwidth = MediaQuery.of(context).size.width;
    final maxheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FutureBuilder(
          future: getDataFromServer(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Welcome data = snapshot.data as Welcome;

              return ListView(
                shrinkWrap: true,
                children: [
                  Image.asset(
                    "assets/images/pngegg.png",
                    width: maxwidth / 2,
                  ),
                  Center(
                    child: Text(
                      data.items!.item!.first.name!,
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0),
                    ),
                  ),
                  Center(
                    child: Text(
                      data.items!.item!.first.type!,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  const Text(
                    " Batter",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: data.items!.item!.first.batters!.batter!
                        .map((e) => Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(e.type!),
                            ))
                        .toList(),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  const Text(
                    " Topping",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Wrap(
                    children: data.items!.item!.first.topping!
                        .map((e) => Container(
                              margin: const EdgeInsets.only(left: 10, top: 10),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(e.type!),
                            ))
                        .toList(),
                  ),
                ],
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
