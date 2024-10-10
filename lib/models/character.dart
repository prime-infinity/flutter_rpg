import 'package:flutter_rpg/models/stats.dart';

class Character with Stats {
  //constructor
  Character({required this.name, required this.slogan, required this.id});

  //fields
  final String name;
  final String slogan;
  final String id;
  bool _isFav = false; //private field cannot be mutated from outside class

  //getters
  bool get isFav => _isFav;

  void toggleIsFav() {
    _isFav = !_isFav;
  }
}
