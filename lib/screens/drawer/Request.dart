import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

// ignore: must_be_immutable
class Request extends StatelessWidget {
  String request = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Request".text.make(),
      ),
      body: Builder(
        builder: (context) => Column(
          children: [
            TextFormField(
              onChanged: (value) {
                request = value;
              },
              maxLines: 10,
              scrollPhysics: ScrollPhysics(),
              decoration: InputDecoration(
                  labelText: "Request",
                  labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  hintText: "Example - Peeky Blinders Series",
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
                if (request != "") {
                  FirebaseFirestore.instance
                      .collection("requests")
                      .add({"request": request, "token": token}).then((value) {
                    context.showToast(
                      msg: "Request Sent !!",
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
