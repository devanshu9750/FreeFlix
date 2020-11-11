import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';

class Report extends StatelessWidget {
  String prb="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Report".text.make(),
      ),
      body: VStack([
        
         TextFormField(
              onChanged: (value) {
                prb = value;
              },
              maxLines: 5,
              scrollPhysics: ScrollPhysics(),
              decoration: InputDecoration(
                  // labelText: "Report Your Problem ",
                  hintText: "Eg.  Anime- (Dubbed)My hero acaademia Season 2  episode 1 ",
                  contentPadding: EdgeInsets.all(10),
                  enabledBorder: OutlineInputBorder(
                    gapPadding: 20,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ).p(20),
      ]).scrollVertical(),
    );
  }
}
