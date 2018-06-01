import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(new MainScreen());

class MainScreen extends StatefulWidget {
  @override
  MainScreenState createState() {
    return new MainScreenState();
  }
}
class MainScreenState extends State<MainScreen> {
  final String url = "https://pokeapi.co/api/v2/pokemon";
  List data;
  List images = new List();
  Future<String> getPokemons() async {
    var response = await http.get(Uri.encodeFull(url));
    setState(() {
          var resBody = json.decode(response.body);
          data = resBody["results"];
        });
        return "succes";
  }
  @override
  void initState() {
      // TODO: implement initState
      super.initState();
      this.getPokemons();
    }
  @override
  Widget build(BuildContext context) {
      // TODO: implement build
      return new MaterialApp(
        title: "Pokedex",
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text("Pokedex"),
            backgroundColor: Colors.redAccent,
          ),
          body: new ListView.builder(
            itemCount: data == null? 0: data.length,
            itemBuilder: (BuildContext context, int index){
              return new Container(
                child: new Center(
                  child: new Column(
                    children: <Widget>[
                      new Text(data[index]['name']),
                      new Image.network('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/'+ (index+1).toString() +'.png')
                    ],
                  ),
                ),
              );
            },
          )
        ),
      );
    }
}