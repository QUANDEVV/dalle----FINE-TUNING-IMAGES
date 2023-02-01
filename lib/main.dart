

// ignore_for_file: unnecessary_null_comparison, unused_field

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dalle/API/api.dart';
import 'package:dalle/drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';


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
  
  late String _imageUrl = "";
  final _promptController = TextEditingController();
  var url = Uri.parse('https://api.openai.com/v1/images/generations');


  

  void _generateImage() async {
    // Replace the OpenAI API endpoint with your own API endpoint
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': 'image-alpha-001',
        'prompt': _promptController.text,
        'num_images': 1,
        'size': '1024x1024',
      }),
    );

    final responseJson = jsonDecode(response.body);
    setState(() {
      _imageUrl = responseJson['data'][0]['url'];
    });
  }

void _downloadImage() async {
    try {
      final response = await http.get(Uri.parse(_imageUrl));
      if (response.statusCode == 200) {
        final directory = await getApplicationDocumentsDirectory();
        final file = File('${directory.path}/generated_image.png');
        await file.writeAsBytes(response.bodyBytes);

        // Save image to photo gallery
        final result = await ImageGallerySaver.saveImage(response.bodyBytes);
        print(result);

        if (result) {
          print('Image saved to photo gallery');
        } else {
          print('Failed to save image to photo gallery');
        }
      } else {
        print('Response status code: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }





   
  FocusNode _focusNode = FocusNode();
 
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
       SingleChildScrollView(
       child: Padding(
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
            _promptController.clear();
             },
             child: SizedBox(
             height: 50,
             width: 320,
            
             child: TextField(
          
             focusNode: _focusNode,
             controller: _promptController,
             decoration: InputDecoration(
             suffixIcon: GestureDetector(
             onTap: _generateImage,
             child: IconTheme( data: IconThemeData(color: Colors.orange), child:Icon(Icons.send))),
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
     
          //  SizedBox(height: 20,),
     
           Row(
           children: [
         
           Container(
           padding: EdgeInsets.all(16),
           child: _imageUrl != null
            ? Row(
           children: [
           Container(
           width: 150,
           height: 150,
           decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(15.0),
           image: DecorationImage(
           image: NetworkImage(_imageUrl),
           fit: BoxFit.fill,
           ),
           ),
           ),
           SizedBox(width: 20,),
           Container(
           width: 150,
           height: 150,
           decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(15.0),
           image: DecorationImage(
           image: NetworkImage(_imageUrl),
           fit: BoxFit.fill,
           ),
           ),
           ),
           ],
           )
           : Container(
            child: Text('no image'),
           ),
              ),
            // ),
           ],
           
           ),

           Row(
           children: [
           _imageUrl  != null ? 
           TextButton(
           onPressed: _downloadImage,
           child: Text('Download')) : Container(),
            ],
           )
        ],
        ),
         ),
     )


    );
  }
}