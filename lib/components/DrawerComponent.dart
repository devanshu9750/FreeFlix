import 'package:FreeFlix/screens/drawer/Report.dart';
import 'package:FreeFlix/screens/drawer/Starred.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class DrawerComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SafeArea(
      child: Column(
        children: [
          ListTile(
            title: "Free Flix".text.size(22).make().pOnly(left: 10),
          ),
          Divider(
            thickness: 1,
            height: 10,
            color: Colors.white,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Starred(),
              ));
            },
            child: ListTile(
              title: "Starred".text.size(18).make(),
              leading: Icon(Icons.star_border),
            ),
          ),
          ListTile(
            title: "Request".text.size(18).make(),
            leading: Icon(Icons.request_page_outlined),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Report(),
              ));
            },
            child: ListTile(
              title: "Report a Problem".text.size(18).make(),
              leading: Icon(Icons.report),
            ),
          )
        ],
      ),
    ));
  }
}
