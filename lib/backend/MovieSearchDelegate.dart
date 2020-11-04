import 'package:FreeFlix/screens/movies/MoviesDetails.dart';
import 'package:flutter/material.dart';

class MovieSearchDelegate extends SearchDelegate<String> {
  static Map data = {};

  @override
  TextStyle get searchFieldStyle => TextStyle(color: Colors.grey);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return super
        .appBarTheme(context)
        .copyWith(primaryColor: Color.fromRGBO(31, 31, 31, 1));
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () {
      query="";
    })];
  }

  @override
  Widget buildLeading(BuildContext context) {
   return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Map> finalData = [];
    data.keys.forEach((element) {
      if (query != "" && element.toLowerCase().contains(query.toLowerCase())) {
        Map temp = data[element];
        temp['title'] = element;
        finalData.add(temp);
      }
    });
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: finalData.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => MoviesDetails(
                data: finalData[index],
              ),
            ));
          },
          child: Card(
            color: Color.fromRGBO(31, 31, 31, 1),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),side: BorderSide(color: Colors.white,width: 1)),
            child: ListTile(
              title: Text(finalData[index]['title']),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Map> finalData = [];
    data.keys.forEach((element) {
      if (query != "" && element.toLowerCase().contains(query.toLowerCase())) {
        Map temp = data[element];
        temp['title'] = element;
        finalData.add(temp);
      }
    });
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: finalData.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => MoviesDetails(data: finalData[index],
              ),
            ));
          },
          child: Card(
            color: Color.fromRGBO(31, 31, 31, 1),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),side: BorderSide(color: Colors.white,width: 1)),
            child: ListTile(
              title: Text(finalData[index]['title']),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
        ),
      ),
    );
  }
}
