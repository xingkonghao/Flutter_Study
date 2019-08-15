import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
//void main() => runApp(new MyApp());
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      title: 'Startup Name Generator',
//      theme: new ThemeData(
//        primaryColor: Colors.white,
//      ),
//      home: new RandomWords(),
//    );
//  }
//}
//
//
//class RandomWords extends StatefulWidget {
//  @override
//  createState() => new RandomWordsState();
//}
//class RandomWordsState extends State<RandomWords> {
//  final _suggestions = <WordPair>[];
//  final _save = new Set<WordPair>();
//  final TextStyle _biggerFont = new TextStyle(fontSize: 18.0);
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text('Startup Name Generator'),
//        actions: <Widget>[
//          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved),
//        ],
//      ),
//      body: _buildSuggestions(),
//    );
//  }
//  void _pushSaved(){
//    Navigator.of(context).push(
//      new MaterialPageRoute(builder: (context){
//        final titles = _save.map(
//                (pair){
//              return new ListTile(
//                  title: new Text(
//                    pair.asPascalCase,
//                    style: _biggerFont,
//                  ),
//              );
//            },
//        );
//        final divided = ListTile.divideTiles(
//            context: context,
//            tiles: titles
//        ).toList();
//        return new Scaffold(
//          appBar: new AppBar(
//            title: new Text("Saved Suggestions"),
//          ),
//          body: new ListView(children:divided,),
//        );
//      },
//      ),
//    );
//  }
//  Widget _buildSuggestions(){
//    return new ListView.builder(
//      padding: const EdgeInsets.all(16.0),
//      itemBuilder: (context,i){
//        if (i.isOdd) return new Divider();
//        final index = i ~/ 2;
//        if (index >= _suggestions.length) {
//          _suggestions.addAll(generateWordPairs().take(10));
//        }
//        return _buildRow(_suggestions[index]);
//      },
//    );
//  }
//
//  Widget _buildRow(WordPair pair){
//    final alreadySaved = _save.contains(pair);
//    return new ListTile(
//      title: new Text(pair.asPascalCase,style: _biggerFont,),
//      trailing: new Icon(
//        alreadySaved ? Icons.favorite : Icons.favorite_border,
//        color: alreadySaved ? Colors.red : null,
//      ),
//      onTap: (){
//        setState(() {
//          if (alreadySaved){
//            _save.remove(pair);
//          }else{
//            _save.add(pair);
//          }
//        });
//      },
//    );
//
//  }
//}
//void main() {
//  runApp(new MaterialApp(
//    title: 'Flutter Tutorial',
////    home: new Counter(),
//  home: MyScaffold(),
//  ));
//}

class CounterDisplay extends StatelessWidget {
  CounterDisplay({this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return new Text('Count: $count');
  }
}

class CounterIncrementor extends StatelessWidget {
  CounterIncrementor({this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return new RaisedButton(
      onPressed: onPressed,
      child: new Text('Increment'),
    );
  }
}

class Counter extends StatefulWidget {
  @override
  _CounterState createState() => new _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  void _increment() {
    setState(() {
      ++_counter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Row(children: <Widget>[
      new CounterIncrementor(onPressed: _increment),
      new CounterDisplay(count: _counter),
    ]);
  }
}

class MyAppBar extends StatelessWidget{
  MyAppBar({this.title});
  final Widget title;
  @override
  Widget build(BuildContext context){
    return new Container(
      height: 100.0,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: new BoxDecoration(color: Colors.blue[500]),
      child: new Row(
        children: <Widget>[
          new IconButton(icon: new Icon(Icons.menu),
              tooltip: 'Navigation menu',
              onPressed: null,
          ),
          new Expanded(
            child: title,
          ),
          new IconButton(icon: new Icon(Icons.search),
              tooltip: 'Search',
              onPressed: null,
          ),

        ],
      ),
    );
  }
}

class MyScaffold extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Material(
      child: new Column(
        children: <Widget>[
          new MyAppBar(
            title: new Text(
              'Example Title',
              style: Theme.of(context).primaryTextTheme.title,
            ),
          ),
          new Expanded(child: new Center(
            child: new Text('Hello world'),
          )),
        ],
      ),
    );
  }

}

//购物车
class Product {
  Product({this.name});
  final String name;
}
typedef void CartChangeCallBack(Product product,bool inCart);

class ShoppingListItem extends StatelessWidget{
  ShoppingListItem({this.product,this.inCart,this.onCartChanged});
  final Product product;
  final bool inCart;
  final CartChangeCallBack onCartChanged;

  Color _getColor(BuildContext context){
    return inCart ? Colors.black54 : Theme.of(context).primaryColor;
  }

  TextStyle _getTextStyle(BuildContext context){
    if(!inCart) return null;
    return new TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListTile(
      onTap: (){
        onCartChanged(product,!inCart);
      },
      leading: new CircleAvatar(
        backgroundColor: _getColor(context),
        child: new Text(product.name[0]),
      ),
    );
  }
}
class _shoppingListState extends State<ShoppingList>{
  Set<Product> _shoppingCart = new Set<Product>();
  void _handleCartChanged(Product product,bool inCart){
    setState(() {
      if(inCart){
        _shoppingCart.add(product);
      }else{
        _shoppingCart.remove(product);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Shoppint List'),
      ),
      body: new ListView(
        padding: new EdgeInsets.symmetric(vertical: 8.0),
        children:widget.products.map((Product product){
          return new ShoppingListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChanged: _handleCartChanged,
          );
        }).toList(),
      ),
    );
  }
}
class ShoppingList extends StatefulWidget{
  ShoppingList({Key key,this.products}) : super(key: key);
  final List<Product> products;
  @override
  _shoppingListState createState() => new _shoppingListState();
}

//void main() {
//  runApp(new MaterialApp(
//    title: 'Shopping App',
//    home: new ShoppingList(
//      products: <Product>[
//        new Product(name: 'Eggs'),
//        new Product(name: 'Flour'),
//        new Product(name: 'Chocolate chips'),
//      ],
//    ),
//  ));
//}
//void main() {
//  runApp(new MaterialApp(
//    title:'Shoping List',
//    home: new ShoppingList(
//      products: <Product>[
//        new Product(name:'Eggs'),
//        new Product(name:'Flour'),
//        new Product(name:'Chocolate chips'),
//      ],
//    ),
//  ));
//}

//tabbar
class TabbedAppBarSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new DefaultTabController(
        length: choices.length,
        child: new Scaffold(
          appBar: new AppBar(
            title: const Text('Tabbed AppBar'),
            bottom: new TabBar(
              isScrollable: true,
              tabs: choices.map((Choice choice) {
                return new Tab(
                  text: choice.title,
                  icon: new Icon(choice.icon),
                );
              }).toList(),
            ),
          ),
          body: new TabBarView(
            children: choices.map((Choice choice) {
              return new Padding(
                padding: const EdgeInsets.all(16.0),
                child: new ChoiceCard(choice: choice),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}


const List<Choice> choices = const <Choice>[
  const Choice(title: 'CAR', icon: Icons.directions_car),
  const Choice(title: 'BICYCLE', icon: Icons.directions_bike),
  const Choice(title: 'BOAT', icon: Icons.directions_boat),
  const Choice(title: 'BUS', icon: Icons.directions_bus),
  const Choice(title: 'TRAIN', icon: Icons.directions_railway),
  const Choice(title: 'WALK', icon: Icons.directions_walk),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({ Key key, this.choice }) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return new Card(
      color: Colors.white,
      child: new Center(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Icon(choice.icon, size: 128.0, color: textStyle.color),
            new Text(choice.title, style: textStyle),
          ],
        ),
      ),
    );
  }
}
class BasicAppBarSample extends StatefulWidget {
  @override
  _BasicAppBarSampleState createState() => new _BasicAppBarSampleState();
}

class _BasicAppBarSampleState extends State<BasicAppBarSample> {
  Choice _selectedChoice = choices[0]; // The app's "state".

  void _select(Choice choice) {
    setState(() { // Causes the app to rebuild with the new _selectedChoice.
      _selectedChoice = choice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Basic AppBar'),
          actions: <Widget>[
            new IconButton( // action button
              icon: new Icon(choices[0].icon),
              onPressed: () { _select(choices[0]); },
            ),
            new IconButton( // action button
              icon: new Icon(choices[1].icon),
              onPressed: () { _select(choices[1]); },
            ),
            new PopupMenuButton<Choice>( // overflow menu
              onSelected: _select,
              itemBuilder: (BuildContext context) {
                return choices.skip(2).map((Choice choice) {
                  return new PopupMenuItem<Choice>(
                    value: choice,
                    child: new Text(choice.title),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: new Padding(
          padding: const EdgeInsets.all(16.0),
          child: new ChoiceCard(choice: _selectedChoice),
        ),
      ),
    );
  }
}

class Choice {
  const Choice({ this.title, this.icon });
  final String title;
  final IconData icon;
}



void main() {
  runApp(new BasicAppBarSample());
}