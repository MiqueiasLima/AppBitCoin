import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BitCoin extends StatefulWidget {
  const BitCoin({Key? key}) : super(key: key);

  @override
  _BitCoinState createState() => _BitCoinState();
}

class _BitCoinState extends State<BitCoin> {

  String url = "https://blockchain.info/ticker";
  String priceBRL = "";

  _atualizarPreco() async {

    http.Response response = await http.get(url);
    print(response.body);
    Map<String,dynamic> preco = json.decode(response.body);

    this.setState(() {

      priceBRL = preco["BRL"]["buy"].toString();

    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.all(16),
            child: Image.asset("imagens/bitcoin.png"),),
            Padding(padding: EdgeInsets.all(16),
            child: Text("R\$ ${priceBRL}",style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),)),
            ElevatedButton(onPressed: _atualizarPreco, child: Text("Atualizar"),style: ElevatedButton.styleFrom(
              primary: Colors.orange,
              onPrimary: Colors.white,
            ),)
          ],
        ),
      ),
    );
  }
}
