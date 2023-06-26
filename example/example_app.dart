import 'package:flutter/material.dart';
import 'package:htkc_utils/htkc_utils.dart';

void main() async {
    runApp(const HTKCExample());
}

class HTKCExample extends StatefulWidget {
  const HTKCExample({super.key});

  @override
  State<HTKCExample> createState() => _HTKCExampleState();
}

class _HTKCExampleState extends State<HTKCExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: customAppBar(
        context,
        title: 'HTKC Example',
        bgColor: Colors.white,
        action: true,
        actionTitle: '+ New',
        isDialog: true,
        actionWidget: CustomAlertDialog(child: const Center(child: Text('Action Widget Clicked'))),
       child: Card(
         clipBehavior: Clip.antiAlias,
         child: Wrap(
           direction: Axis.horizontal,
           spacing: 8.0, // gap between adjacent chips
           runSpacing: 4.0, // gap between lines
           children: <Widget>[
             Chip(
               avatar: CircleAvatar(
                   backgroundColor: Colors.blue.shade900, child: Text('AH')),
               label: Text('Hamilton'),
             ),
             Chip(
               avatar: CircleAvatar(
                   backgroundColor: Colors.blue.shade900, child: Text('ML')),
               label: Text('Lafayette'),
             ),
             Chip(
               avatar: CircleAvatar(
                   backgroundColor: Colors.blue.shade900, child: Text('HM')),
               label: Text('Mulligan'),
             ),
             Chip(
               avatar: CircleAvatar(
                   backgroundColor: Colors.blue.shade900, child: Text('JL')),
               label: Text('Laurens'),
             ),
           ],
         ),
       ),
    ));
  }
}
