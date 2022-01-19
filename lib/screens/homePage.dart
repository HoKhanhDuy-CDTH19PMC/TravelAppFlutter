import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import '../api.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
     Iterable ds = [];
  bool isUpdate = true;

  @override
  Widget build(BuildContext context) {
     Widget detailsSite(int index){
  return Center(

  child: ListView(children: [

    
      Image.network(
                ds.elementAt(index)["img"].toString(),
                fit: BoxFit.cover,
                
              ),
 Text(ds.elementAt(index)["location"].toString(),style:TextStyle(fontSize: 17,color: Colors.cyan)),

  
  ],),
  );
}
    if (isUpdate == true) {
      API(url: "http://10.0.2.2:8000/api/danh-sach-dia-danh")
          .getDataString()
          .then((value) {
        ds = json.decode(value);
        isUpdate = false;
        setState(() {});
      });
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Stack(
        children: [
          ImageSlideshow(
            width: double.infinity,
            height: 200,
            initialPage: 0,
            indicatorColor: Colors.red,
            indicatorBackgroundColor: Colors.black,
            children: [
              Image.network(
                "https://nichetravel.com.vn/wp-content/uploads/2020/08/travel-world.jpg",
                fit: BoxFit.cover,
              ),
              Image.network(
                "https://cdn-2.tstatic.net/tribunnews/foto/bank/images/gaya-traveling-orang-indonesia-kamu-masuk-yang-mana-nih.jpg",
                fit: BoxFit.cover,
              ),
              Image.network(
                "https://cdn.kibrispdr.org/data/gambar-orang-traveling-0.jpg",
                fit: BoxFit.cover,
              ),
            ],
            onPageChanged: (value) {
              print('Page changed: $value');
            },
            autoPlayInterval: 3000,
            isLoop: true,
          ),
          Positioned(
              width: MediaQuery.of(context).size.width,
              top: MediaQuery.of(context).size.width *
                  0.06, //TRY TO CHANGE THIS **0.30** value to achieve your goal
              child: Container(
                margin: EdgeInsets.all(0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 0,
                      ),
                      Text("Traveling TD",
                          style: TextStyle(
                              fontSize: 29,
                              color: Colors.white,
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.bold)),
                      Align(
                        alignment: Alignment.center,
                        child: TextField(
                          style: TextStyle(color: Colors.white, fontSize: 17),
                          decoration: const InputDecoration(
                            fillColor: Colors.black26,
                            filled: true,
                            border: OutlineInputBorder(),
                            hintText: 'Bạn cần tìm gì ??',
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceEvenly, // use whichever suits your need
                            children: <Widget>[
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Color(0x61000000),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.place_rounded,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Color(0x61000000),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.home,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Color(0x61000000),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.image,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          )),
                    
                    ]),
              )
              ),
            
           
         Container(
          
    margin: EdgeInsets.fromLTRB(0, 180, 0, 0),
child: GridView.count(
        crossAxisCount: 2,
        children: new List<Widget>.generate(ds.length, (index) {
          return new GridTile(
            child: new Card(
              
              child:  Center(
                child:Column(
children: [
InkWell(
  child:   Container(
  
                 width: 180,
               height: 150,
                  padding:EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Image.network(
                ds.elementAt(index)["img"].toString(),
                fit: BoxFit.cover,
                
              ),
              
                ),
                onTap: (){
                      Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        detailsSite(index),
                  ),
                );
                },
),
                 Container(
                   margin:EdgeInsets.fromLTRB(0, 10, 0, 0),
                   child:Column(children: [
                Text(ds.elementAt(index)["name"].toString(),style:TextStyle(fontSize: 17,color: Colors.cyan)),
                Text(ds.elementAt(index)["description"].toString(),style:TextStyle(fontSize: 13,color: Colors.black54)),
                   ],)
                  
                 )
                ],
                )
              
              )
              
            ),
          );
        })),
        //       child:       GridView.count(
        //   // Create a grid with 2 columns. If you change the scrollDirection to
        //   // horizontal, this produces 2 rows.
        //   crossAxisCount: 2,
        //   // Generate 100 widgets that display their index in the List.
        //   children: List.generate(4, (index) {
        //     return Center(
              
        // child:Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //   Image.network('https://cdn.kibrispdr.org/data/gambar-orang-traveling-0.jpg',scale: 1,fit: BoxFit.fill,),
        // ],)
          
        //     );
        //   }),
        // ),
            
         ),
        
         
        ],
      ),
      
      ),
    );
  }
}
