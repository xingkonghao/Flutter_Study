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
      home: MyHomePage(title: 'Flutter Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(length: 3, child:Scaffold(
      body: TabBarView(children: [
        ParallelWidget(),
        TapToTopWidget(),
        ScrollNotiWidget()
      ]),
      bottomNavigationBar: TabBar(
        tabs: [
          Tab(icon: Icon(Icons.home),text: "视差",),
          Tab(icon: Icon(Icons.rss_feed),text: "Notification",),
          Tab(icon: Icon(Icons.perm_identity),text: "Controller",)
        ],
        unselectedLabelColor: Colors.blueGrey,
        labelColor: Colors.blue,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Colors.red,
      ),
    )
    );
  }

}

class ParallelWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text('CustomScrollView Demo'),
              floating: true,
              flexibleSpace: FadeInImage.assetNetwork(placeholder: 'images/loading.gif', image: luna,fit: BoxFit.cover,
                width: 200,
                height: 300,
              ),
              expandedHeight: 300,
            ),

            SliverList(delegate: SliverChildBuilderDelegate(
                (context,index)=> ListTile(title: Text('Item #$index'),),
              childCount: 100,
            ))
          ],
    );
  }
}
class TapToTopWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomePageHomeState2();
}
// scrollController 点击 回到顶部
class _MyHomePageHomeState2 extends State<TapToTopWidget>{
  ScrollController _scrollController;
  bool isToTop = false;
  @override
  void initState(){
    _scrollController = ScrollController();
    _scrollController.addListener((){
      if (_scrollController.offset > 1000){
        setState(() {
          isToTop = true;
        });
      }else if(_scrollController.offset < 300){
        setState(() {
          isToTop = false;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  return MaterialApp(
      title: 'ScrollController Demo',
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              child:RaisedButton(onPressed: (isToTop?(){
                if (isToTop)
                {//
                  _scrollController.animateTo(.0, duration: Duration(milliseconds: 200), curve: Curves.ease);
                }
              }:null),
                child: Text('Top'),
              )  ,
              height: 40,
            ),
            Expanded(child:  ListView.builder(
                itemBuilder: (context,index)=> ListTile(title: Text('Index :$index')),
                itemCount: 100,
                controller: _scrollController
            ) ,
            )

          ],
        ),
      ),

  );
  }

  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }
}
class ScrollNotiWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification){
        if(scrollNotification is ScrollStartNotification){
          print('scroll start');
        }else if(scrollNotification is ScrollEndNotification)
        {
          print('Scroll end');
        }else if(scrollNotification is ScrollUpdateNotification)
        {
          print('scroll scrolling');
        }
      },
      child: ListView.builder(itemBuilder: (context,index)=>ListTile(title:Text('index $index')),
        itemCount: 30,
      ),

    );
  }
}
const String luna = 'http://img5.imgtn.bdimg.com/it/u=100434531,1815181664&fm=26&gp=0.jpg';