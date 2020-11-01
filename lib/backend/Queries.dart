import 'package:firebase_database/firebase_database.dart';

class Queries {
  static Map<String, Stream<Event>> queries = {
    "bollywood": FirebaseDatabase.instance
        .reference()
        .child("movies")
        .orderByChild("type")
        .equalTo(0)
        .onValue,
    "hollywood": FirebaseDatabase.instance
        .reference()
        .child("movies")
        .orderByChild("type")
        .equalTo(1)
        .onValue,
    "subAnime": FirebaseDatabase.instance.reference().child("anime").onValue
  };
}
