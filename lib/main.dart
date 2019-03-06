import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:poke_flutter_app/pokemon.dart';
import 'package:poke_flutter_app/pokemon_detail.dart';


void main()=>runApp(MaterialApp(
  title: "Poke app",
  home: HomePage(),
  debugShowCheckedModeBanner: false,
));

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var url = "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  PokeHub pokehub;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchData();

  }

  fetchData() async{
    var res = await http.get(url);
    var decodedJson = jsonDecode(res.body);
    pokehub = PokeHub.fromJson(decodedJson);
    print(pokehub.toJson());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Poke app"),
        backgroundColor: Colors.cyan,
      ),
      body: pokehub == null
          ?Center(child: CircularProgressIndicator(),
      )
      : GridView.count(crossAxisCount: 2,
      children: pokehub.pokemon
          .map( (poke) => Padding(
        padding: const EdgeInsets.all(2.0),
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>PokeDetail(
              pokemon: poke,
            )));
          },
          child: Hero(
            tag: poke.img,
            child: Card(
        elevation: 3.0,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: 100.0,
                width: 100.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(poke.img)),
                ),
              ),
              Text(poke.name, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),)
            ],
        ),
      ),
          ),)
      )).toList()),
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: Colors.cyan,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
