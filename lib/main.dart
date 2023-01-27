

import 'package:dalle/drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}




class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FocusNode _focusNode = FocusNode();
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        drawer: Drawers(),
        appBar: AppBar(
        title: Text('DALLE FINETUNING',
        style: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w400
        ),),
        backgroundColor: Color.fromARGB(255, 16, 16, 17),
        ),



     body: 
     Padding(
     padding: const EdgeInsets.only(left:8.0),
     child: Column(
     mainAxisAlignment: MainAxisAlignment.start,
      
     children: [

      SizedBox(height: 20,),

      Text('Generate Unique Photos',
      style: GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      fontSize: 20,
       ),),

      
      
       SizedBox(height: 20,),



       Padding(
         padding: const EdgeInsets.only(left:0.0),
         child: GestureDetector(
          onTap: () {
          FocusScope.of(context).unfocus();
          _controller.clear();
           },
           child: SizedBox(
           height: 50,
           width: 320,
          
           child: TextField(
           focusNode: _focusNode,
           controller: _controller,
           decoration: InputDecoration(
           label: Text('search your images'),
           labelStyle: TextStyle(color: Colors.black),
           enabledBorder: OutlineInputBorder(
           borderSide: BorderSide(color: Colors.black),
           borderRadius: BorderRadius.all(Radius.circular(10))
               ),
            focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            ),
               ),
               ),
            ),
       ), 

         SizedBox(height: 20,),

         Row(
          children: [
          Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),

          color: Colors.black12
         ),
         ),
         SizedBox(width: 20,),
         Container(
         height: 100,
         width: 100,
         decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(4),
         color: Colors.black12
         ),
         )
          ],
         )
        //  Container(
        //  height: 100,
        //  width: 100,
        //  decoration: BoxDecoration(
        //  color: Colors.red
        //  ),
        //  ),
        //  Container(
        //  height: 100,
        //  width: 100,
        //  decoration: BoxDecoration(
        //  color: Colors.red
        //  ),
        //  )










      ],
      ),
    )


    );
  }
}