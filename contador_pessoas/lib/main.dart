import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(title: "Contador de Pessoas", home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _people = 0;
  String _info = "pode entrar";

  void _changePeople(int delta) {
    setState(() {
      _people += delta;

      if(_people < 0){
        _info = "Mundo Invertido";
      }else if(_people <= 10){
         _info = "Pode entrar";
      }else{
        _info = "Lotada";
      }

    });


  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "images/5547.jpg",
          fit: BoxFit.cover,
          height: 1000.0,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Pessoas: $_people",
              style: TextStyle(
                  color: Colors.blueAccent, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: FlatButton(
                      child: Text(
                        "+1",
                        style:
                            TextStyle(fontSize: 40.0, color: Colors.blueAccent),
                      ),
                      onPressed: () {
                        _changePeople(1);
                      },
                    )),
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: FlatButton(
                      child: Text(
                        "-1",
                        style:
                            TextStyle(fontSize: 40.0, color: Colors.blueAccent),
                      ),
                      onPressed: () {
                        _changePeople(-1);
                      },
                    ))
              ],
            ),
            Text(
              "Pessoas: $_info",
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0),
            ),
          ],
        )
      ],
    );
  }
}
