import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'secret.dart';
import 'dart:convert';

void main() {
  runApp(const FactsAPI());
}

class FactsAPI extends StatefulWidget {
  const FactsAPI({Key? key}) : super(key: key);

  @override
  State<FactsAPI> createState() => _FactsAPIState();
}

class _FactsAPIState extends State<FactsAPI> {
  String getData = "wait..";
  List<dynamic> dynamicValuesList = [];
  Future fetchdata() async {
    http.Response response;
    response = await http.get(
        Uri.parse(
          "https://random-quote-fact-joke-api.p.rapidapi.com/fact",
        ),
        headers: {
          'X-RapidAPI-Key': secret,
          'X-RapidAPI-Host': 'random-quote-fact-joke-api.p.rapidapi.com'
        });

    if (response.statusCode == 200) {
      setState(() {
        getData = response.body;
        dynamicValuesList = json.decode(getData).values.toList();
      });
    } else {
      return const CircularProgressIndicator();
    }
  }

  @override
  void initState() {
    super.initState();
    fetchdata();
  }

  void _refreshData() {
    setState(() {
      fetchdata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text(
              'Random Cool Facts',
            ),
            centerTitle: true,
            backgroundColor: Colors.amber[800],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  width: double.infinity,
                  height: 0,
                ),
                Image.asset(
                  'assets/backgroundfacts.jpg',
                  height: 250,
                ),
                Container(
                  margin: const EdgeInsets.all(25.0),
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent)),
                  child: Text(
                    dynamicValuesList.isNotEmpty
                        ? dynamicValuesList[2].replaceAll(".", ".\n")
                        : "",
                    style: const TextStyle(
                        fontSize: 15, fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  child: ElevatedButton(
                    onPressed: () {
                      _refreshData();
                    },
                    child: const Text("Click Here for next Random Cool Fact"),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}


//dynamicValuesList.isNotEmpty ? dynamicValuesList[2] : "",