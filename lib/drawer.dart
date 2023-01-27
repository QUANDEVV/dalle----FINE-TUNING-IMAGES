import 'package:flutter/material.dart';

class Drawers extends StatefulWidget {
  const Drawers({super.key});

  @override
  State<Drawers> createState() => _DrawersState();
}

class _DrawersState extends State<Drawers> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      
      backgroundColor: Color.fromARGB(255, 239, 222, 171),
      child: ListView(
        children: [
        DrawerHeader(
        decoration: BoxDecoration(color: Color.fromARGB(255, 237, 215, 149)),
        child: Text('hello'),
          
        )
        ],
      ),
      
    );
  }
}