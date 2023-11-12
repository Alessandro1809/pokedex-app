import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List pokedex = [];

  dynamic color(index) {
    dynamic setColor;
    switch (pokedex[index]["type"][0]) {
      case "Grass":
        setColor = Colors.greenAccent;
        break;
      case "Fire":
        setColor = Colors.redAccent;
        break;
      case "Water":
        setColor = Colors.blueAccent;
        break;
      case "Electric":
        setColor = Colors.amber;
        break;
      case "Poison":
        setColor = Colors.deepPurpleAccent;
        break;
      case "Rock":
        setColor = Colors.brown;
        break;
      case "Ground":
        setColor = Colors.brown;
        break;
      case "Psychic":
        setColor = Colors.indigo;
        break;
      case "Flighting":
        setColor = Colors.orange;
        break;
      case "Bug":
        setColor = Colors.lightGreenAccent;
        break;
      case "Ghost":
        setColor = Colors.deepPurple;
        break;
      case "Normal":
        setColor = Colors.white12;
        break;
      default:
        setColor = Colors.pinkAccent;
    }
    return setColor;
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      fetchPokeapi();
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 128, 64, 48),
          Color.fromARGB(255, 0, 0, 0)
        ], begin: Alignment.topRight, end: Alignment.bottomLeft),
      ),
      child: Stack(
        children: [
          Positioned(
              top: -50,
              right: -50,
              child: Image.asset("assets/pokeball.png",
                  width: 170, fit: BoxFit.fitWidth)),
          Positioned(
              top: 100,
              left: 20,
              child: Text(
                "Pokedex",
                style: TextStyle(
                    color: Colors.white70.withOpacity(0.6),
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              )),
          Positioned(
              top: 150,
              bottom: 0,
              width: width,
              child: Column(
                children: [
                  pokedex != null
                      ? Expanded(
                          child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 3 / 5),
                          itemCount: pokedex.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: InkWell(
                                child: SafeArea(
                                    child: Stack(
                                  children: [
                                    Container(
                                      width: width,
                                      margin: const EdgeInsets.only(top: 80),
                                      decoration: const BoxDecoration(
                                          color: Colors.black26,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25))),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                              top: 90,
                                              left: 15,
                                              child: Text(
                                                pokedex[index]["num"],
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    color: Colors.black87),
                                              )),
                                          Positioned(
                                              top: 130,
                                              left: 15,
                                              child: Text(
                                                pokedex[index]["name"],
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    color: Colors.white54),
                                              )),
                                          Positioned(
                                              top: 170,
                                              left: 15,
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 5,
                                                    bottom: 5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                20)),
                                                    color: Colors.black
                                                        .withOpacity((0.5))),
                                                child: Text(
                                                  pokedex[index]["type"][0],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                      color: color(index),
                                                      shadows: [
                                                        BoxShadow(
                                                            color: color(index),
                                                            offset:
                                                                Offset(0, 0),
                                                            spreadRadius: 1.0,
                                                            blurRadius: 15)
                                                      ]),
                                                ),
                                              ))
                                        ],
                                      ),
                                    ),
                                    Container(
                                        alignment: Alignment.topCenter,
                                        child: CachedNetworkImage(
                                          imageUrl: pokedex[index]["img"],
                                          height: 180,
                                          fit: BoxFit.fitHeight,
                                        ))
                                  ],
                                )),
                              ),
                            );
                          },
                        ))
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                ],
              ))
        ],
      ),
    ));
  }

  void fetchPokeapi() {
    var url = Uri.https('raw.githubusercontent.com',
        '/Biuni/PokemonGO-Pokedex/master/pokedex.json');

    http.get(url).then((value) {
      if (value.statusCode == 200) {
        var data = jsonDecode(value.body);
        pokedex = data["pokemon"];
        setState(() {});
        if (kDebugMode) {
          print(pokedex);
        }
      }
    }).catchError((e) {
      if (kDebugMode) {
        print(e);
      }
    });
  }
}
