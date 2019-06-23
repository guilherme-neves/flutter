import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?format=json&key=566bdd84";

void main() async {
  print(getData());

  runApp(MaterialApp(home: Home()));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final realController = TextEditingController();
  final dollarController = TextEditingController();
  //final realController = TextEditingController();

  double dollar;
  double reais;

  void _realChanged(String text){
    double real = double.parse(text);
    dollarController.text = (real/this.dollar).toStringAsPrecision(5);
  }

  void _dollarChanged(String text){
     double dollar = double.parse(text);
     realController.text = (dollar * this.dollar).toStringAsPrecision(5);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("Conversor"),
          backgroundColor: Colors.amber,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
             child: FutureBuilder<Map>(
            future: getData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                      child: Text('Carrgando Dados...',
                          style: TextStyle(color: Colors.black, fontSize: 25.0),
                          textAlign: TextAlign.center));
                default:
                  if (snapshot.hasError) {
                    return Center(
                        child: Text('Error Carregar dados',
                            style:
                                TextStyle(color: Colors.amber, fontSize: 25.0),
                            textAlign: TextAlign.center));
                  } else {
                    dollar =
                        snapshot.data["results"]["currencies"]["USD"]["buy"];
                    reais =
                        snapshot.data["results"]["currencies"]["EUR"]["buy"];

                    return Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Icon(Icons.monetization_on,
                              size: 150.0, color: Colors.amber),
                          buildTextField("Reais", "R\$",realController,_realChanged ),
                          Divider(),
                          buildTextField("Dollar", "\$",dollarController,_dollarChanged)
                        ],
                      ),
                    );
                  }
              }
            })));
  }
//Criando o botão
  Widget buildTextField(String label, String prefix,TextEditingController c, Function f) {
    return TextField(
      controller: c ,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.amber),
          border: OutlineInputBorder(),
          prefixStyle: TextStyle(color: Colors.amber),
          prefixText: prefix,
        ),
        style: TextStyle(
          color: Colors.amber,
          fontSize: 25.0,
        ),
    onChanged: f,);
  }
}
