import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: new Column(
        children: <Widget>[
          Text.rich(
          TextSpan(
         children: <TextSpan>[
      TextSpan(text: '顽疾昨天的种种因果，做好当下要做好的事情，规划好未来需要做的事情',style:blackStyle),
        TextSpan(text: '没什么不刻意放弃的，也没什么不能抓住的',style: redStyle),
        TextSpan(text: '不要在乎暂时的得失，路还很长，眼光要放远一点',style: blackStyle),
        TextSpan(text: '内心的强大最重要，它是一切的基石',style: redStyle)
        ])),
          FlatButton(
            child: Text('flatButton'),
            textColor: Colors.white,
            color: Colors.orange,
            onPressed: () => print('FlatActionButton pressed'),
          ),
          FloatingActionButton(
          child: Text('FloatingActionButton'),
          onPressed: () => print('FloatingActionButton pressed'),

          ),
          RaisedButton(
            child: Text('RaisedButton'),
            onPressed: () => print('RaiseButton pressed'),
          ),
          FadeInImage.assetNetwork(
              placeholder: 'images/loading.gif',
              image:buzihuo,
              fit: BoxFit.cover,
              width: 200,
              height: 200,

          )
        ],
      )
    );
  }
}
const String buzihuo = 'http://img4.dwstatic.com/5253wzry/1707/363958993588/363959036503.jpeg';
TextStyle blackStyle = TextStyle(fontWeight: FontWeight.normal,fontSize: 20,color: Colors.orange);
TextStyle redStyle = TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.red);
