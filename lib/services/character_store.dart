import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/services/firestore_service.dart';

class CharacterStore extends ChangeNotifier {
  final List<Character> _characters = [];

  get characters => _characters;

  //add character
  void addCharacter(Character character) {
    print("adding to firestore");
    FirestoreService.addCharacter(character);
    _characters.add(character);
    notifyListeners(); //self explan
  }

  //initially fetch characters
  void fetchCharactersOnce() async {
    if (characters.length == 0) {
      print("fetching from firestore");
      final snapShot = await FirestoreService.getCharactersOnce();
      for (var doc in snapShot.docs) {
        _characters.add(doc.data());
      }
      notifyListeners();
    }
  }
}
/**
    Character(
        name: "Klara", slogan: "Kapumf!", vocation: Vocation.wizard, id: "1"),
    Character(
        id: '2',
        name: 'Jonny',
        vocation: Vocation.junkie,
        slogan: 'Light me up...'),
    Character(
        id: '3',
        name: 'Crimson',
        vocation: Vocation.raider,
        slogan: 'Fire in the hole!'),
    Character(
        id: '4',
        name: 'Shaun',
        vocation: Vocation.ninja,
        slogan: 'Alright then gang.'),
   */