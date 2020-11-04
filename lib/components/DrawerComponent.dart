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
          Divider(thickness: 1,height: 10,color: Colors.white,),
          ListTile(title: "Request".text.size(18).make(),leading: Icon(Icons.request_page_outlined),),
          ListTile(title: "Report".text.size(18).make(),leading: Icon(Icons.report),)

        ],
      ),
    ));
  }
}
