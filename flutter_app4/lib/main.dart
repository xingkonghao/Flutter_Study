import 'package:flutter/material.dart';

void main() {

  ShoppingCart.withCode(name:'张三')..booking = [Item('苹果',10.0,2),Item('香蕉', 9.0,3)]
      ..printInfo();
  ShoppingCart(name: '李四')..booking = [Item('苹果',10.0,4),Item('香蕉',9.0,6)]..printInfo();

}


class Meta {
  double price;
  String name;
  int count;
  Meta(this.name,this.price,this.count);
}
abstract class PrintHelper{
  printInfo() => print(getInfo());
  getInfo();
}
class Item extends Meta {
  Item(name,price,count) : super(name,price,count);
  Item operator+(Item item) => Item(name + item.name,price*count + item.price*count,count+count);
}
class ShoppingCart extends Meta with PrintHelper{
  String code;
  DateTime date;
  List<Item>booking;
  double get price => booking.reduce((value,element)=>value + element).price;
  int get count => booking.reduce((value,element)=>value + element).count;
  ShoppingCart({name}) : this.withCode(name:name, code:null);
  ShoppingCart.withCode({name,this.code}): date = DateTime.now(),super(name,0.0,0);
  add(item) {
    booking.add(item);
  };
  @override
  getInfo() => '''
    用户名：$name
    优惠吗：${code??"没有"}
    总价：$price
    商品总数：$count
    日期：$date
    
  ''';
}