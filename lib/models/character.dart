import 'package:flutter_rpg/models/stats.dart';
import 'package:flutter_rpg/models/vocation.dart';

class Character with Stats {
  //constructor
  Character(
      {required this.name,
      required this.slogan,
      required this.vocation,
      required this.id});

  //fields
  final Vocation vocation;
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
