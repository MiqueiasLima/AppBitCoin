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

  Future<dynamic> atualizarPreco() async {
    http.Response response = await http.get(url);
    Map<String,dynamic> preco = json.decode(response.body);
    if (preco.containsKey('BRL')) {
      return preco["BRL"]["buy"].toString();
    } else {
      return 'not found brl buy';
    }
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
              child: FutureBuilder(
                future: atualizarPreco(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    String price = snapshot.data;
                    return Text("R\$ $price", 
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('error');
                  } else {
                    return SizedBox(
                      child: CircularProgressIndicator(color: Colors.orange),
                      width: 40,
                      height: 40,
                    );
                  }
                },
              )
            ),
            ElevatedButton(onPressed: atualizarPreco, child: Text("Atualizar"),style: ElevatedButton.styleFrom(
              primary: Colors.orange,
              onPrimary: Colors.white,
            ),)
          ],
        ),
      ),
    );
  }
}
