import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

// ignore: must_be_immutable
class Report extends StatelessWidget {
  String report = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Report".text.make(),
      ),
      body: Builder(
        builder: (context) => Column(
          children: [
            TextFormField(
              onChanged: (value) {
                report = value;
              },
              maxLines: 10,
              scrollPhysics: ScrollPhysics(),
              decoration: InputDecoration(
                  labelText: "Report",
                  labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  hintText:
                      "Example - Peeky Blinders Season 1 Episode 10 has error",
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Vx.white),
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ).p(20),
            RaisedButton(
              onPressed: () async {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
                String token = await FirebaseMessaging().getToken();
                if (report != "") {
                  FirebaseFirestore.instance
                      .collection("reports")
                      .add({"report": report, "token": token}).then((value) {
                    context.showToast(
                      msg: "Thank You for Informing !!",
                      bgColor: Vx.black,
                      textColor: Vx.white,
                    );
                  });
                }
              },
              color: Vx.black,
              child: "Submit".text.make(),
            )
          ],
        ),
      ),
    );
  }
}
