class Character {
  //constructor
  Character({required this.name, required this.slogan, required this.id});

  //fields
  final String name;
  final String slogan;
  final String id;
  bool _isFav = false; //private field cannot be mutated from outside class

  void toggleIsFav() {
    _isFav = !_isFav;
  }
}
