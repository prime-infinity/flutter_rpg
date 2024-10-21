import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rpg/models/character.dart';

class FirestoreService {
  static final ref = FirebaseFirestore.instance
      .collection("characters")
      .withConverter(
          fromFirestore: Character.fromFirestore,
          toFirestore: (Character c, _) => c.toFirestore());

  //add a new character
  static Future<void> addCharacter(Character character) async {
    await ref.doc(character.id).set(character); //we can still use the ref.add()
  }

  //get character once
  static Future<QuerySnapshot<Character>> getCharactersOnce() {
    return ref.get();
  }

  //update a character
  static Future<void> updateCharacter(Character character) async {
    await ref.doc(character.id).update({
      //pass fields we want to update
      //we follow the same format as when saving
      'stats': character.statsAsMap,
      'points': character.points,
      'skills': character.skills.map((s) => s.id).toList(),
      'isFav': character.isFav,
    });
  }
}
