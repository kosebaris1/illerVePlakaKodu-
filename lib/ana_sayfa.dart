import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'il.dart';
import 'ilce.dart';


class AnaSayfa extends StatefulWidget{
  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  List<Il> iller=[];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _jsonCozumle();
    });

  }
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("İller Ve İlceler"),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: iller.length,
          itemBuilder: _listeOgesiniOlustur,

      ),

    );
  }
   Widget _listeOgesiniOlustur(BuildContext context, int index) {
    return Card(
      child: ExpansionTile(
        leading: Icon(
            Icons.location_city,
          color: Colors.indigo,
        ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
              iller[index].isim,
            style: TextStyle(
              color: Colors.deepPurpleAccent
            ),
          ),
          Text(iller[index].plakaKodu)
        ],
      ),
  //    trailing: ,
        children: iller[index].ilceler.map((ilce){
          return ListTile(
            leading: Icon(Icons.location_on,
              color: Colors.indigo,

            ),
            title: Text(ilce.isim),

          );
     }).toList(),
      ),
    );
   }

   void _jsonCozumle() async{
    String jsonString= await rootBundle.loadString("assets/il.json");
    Map<String,dynamic> illerMap=json.decode(jsonString);
    for( String plakaKodu in illerMap.keys){
      Map<String,dynamic> ilMap=illerMap[plakaKodu];
      String ilIsmi=ilMap["name"];
      Map<String,dynamic> ilcelerMap=ilMap["districts"];

       List<Ilce> tumIlceler=[];

      for(String ilceKodu in ilcelerMap.keys){
         Map<String,dynamic> ilceMap=ilcelerMap[ilceKodu];
         String ilceIsmi=ilceMap["name"];
         Ilce ilce=Ilce(ilceIsmi);
         tumIlceler.add(ilce);

      }
// deneme
      Il il=Il(ilIsmi,plakaKodu,tumIlceler);
      iller.add(il);
      setState(() {

      });
    }
   }


}