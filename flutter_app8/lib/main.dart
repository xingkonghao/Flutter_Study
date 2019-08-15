import 'package:flutter/material.dart';
import 'dart:math';
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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  State<StatefulWidget> createState() => MyhomePageState();
}
class MyhomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{
  TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: Text(widget.title),
        bottom: TabBar(tabs: [
          Tab(icon: Icon(Icons.system_update),text: '组合',),
          Tab(icon: Icon(Icons.cake),text: '自绘',),
        ],
        controller:_tabController
        ),
      ),
      body: TabBarView(
          children: [
        RowWidget(model: UpdateItemModel(
          appIcon: 'images/DD_icon.png',
          appName: 'Google Maps - Transit &Fond',
          appDate: '2019-8-15',
          appSize: '100',
          appDescription: '纯粹没事找事，瞎写点东西！！！',
          appVersion: 'Version 5.19',
        ),onPressed: (){},),
            Cake()
      ],
        controller: _tabController,
      ),
    );

  }
  @override
  void dispose(){
    _tabController.dispose();
    super.dispose();
  }
}
class UpdateItemModel {
  String appIcon;
  String appName;
  String appSize;
  String appDate;
  String appDescription;
  String appVersion;
  UpdateItemModel({this.appIcon,this.appName,this.appSize,this.appDate,this.appDescription,this.appVersion});
}
class RowWidget extends StatelessWidget {
  final UpdateItemModel model;
  RowWidget({Key key,this.model,this.onPressed}):super(key:key);
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildTopRow(context),
          buildBottomRow(context)
        ],
    );
  }



  Widget buildTopRow(BuildContext context){
    return Row(
      children: <Widget>[
        Padding(padding: EdgeInsets.all(10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(model.appIcon,width: 80,height: 80),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(model.appName,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 20,color: Color(0xFF8E8D92)),),
              Text(model.appDate,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 16,color: Color(0xFF8E8D92)),),
            ],
          ),
        ),

        Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
        child: FlatButton(
            highlightColor: Colors.blue[700],
            color: Color(0xFFF1F0F7),
            colorBrightness: Brightness.dark,
            onPressed: onPressed,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            child: Text('OPEN',style: TextStyle(color: Color(0xFF007AFE),fontWeight: FontWeight.bold),)

        ),
        )
      ],
    );

  }
  Widget buildBottomRow(BuildContext context){
    return Container(

      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(model.appDescription),
            Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text("${model.appVersion} . ${model.appSize} MB"),
            )


          ],
        ),
    );
  }
}

class WheelPainter extends CustomPainter{
  Paint getColoredPaint(Color color){
    Paint paint = Paint();
    paint.color = color;
    return paint;
  }
  @override
  void paint(Canvas canvas, Size size) {//绘制逻辑
    // TODO: implement paint
    double wheelsSize = min(size.width,size.height)/2;//饼图的尺寸
    double nbElem = 6;//分成6份
    double radius = (2 * pi) / nbElem;//半径
    //包裹饼图 这个圆形的矩形图
    Rect boundingRect = Rect.fromCircle(center: Offset(wheelsSize, wheelsSize),radius: wheelsSize);
    //每次画 1/6个圆弧
    canvas.drawArc(boundingRect, 0, radius, true, getColoredPaint(Colors.red));
    canvas.drawArc(boundingRect, radius, radius, true, getColoredPaint(Colors.orange));
    canvas.drawArc(boundingRect, radius*2, radius, true, getColoredPaint(Colors.green));
    canvas.drawArc(boundingRect, radius*3, radius, true,  getColoredPaint(Colors.blue));
    canvas.drawArc(boundingRect, radius*4, radius, true, getColoredPaint(Colors.pink));
    canvas.drawArc(boundingRect, radius*5, radius, true, getColoredPaint(Colors.purple));
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}

class Cake extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomPaint(
      size: Size(200, 200),
      painter: WheelPainter(),
    );
  }
}