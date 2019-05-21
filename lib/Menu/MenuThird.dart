import 'package:flutter/material.dart';
import 'package:flutter_app/Menu/Menu.dart';
import 'package:flutter_app/PopupHepler.dart';

class MenuThird extends StatefulWidget{
  @override
  MenuThirdState createState() => new MenuThirdState();

}

class MenuThirdState extends State<MenuThird>{
  TabController tabController;
  BuildContext _context;
  List<String> items = List<String>.generate(100, (i) => "Item ${i + 1}");
  @override
  Widget build(BuildContext context) {
    this._context = context;
    return this.GetBody();
  }
  void SetTabController(TabController value){
    tabController = value;
  }

  Widget GetListView(){
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context,int index){
        String key = items[index];
        return Dismissible(
          key: Key(key),

          onDismissed: (direction){
            setState(() {
              items.removeAt(index);
            });
          },
          child: GestureDetector(
            child: Card(
              child: Container(child: Text(items[index]+(index%2 == 0?" chẵn":" lẻ")),alignment: Alignment.center,),
              elevation: 3,

            ),
            onTap: (){
              PopupHelper.showPopup(context,"Item clicked $index");
            },

          ),
        );
        return new GestureDetector(
          child: Card(
            child: Container(child: Text("Item $index"),alignment: Alignment.center,),
            elevation: 3,

          ),
          onTap: (){
            PopupHelper.showPopup(context,"Item clicked $index");
          },

        );
      },

    );
  }

  Widget GetGridView(){
    return GridView.builder(
      itemCount: 100,

      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(_context).orientation == Orientation.portrait?3:2,
        childAspectRatio: MediaQuery.of(_context).size.width /(MediaQuery.of(_context).size.height/2 ),

      ),
      itemBuilder: (BuildContext context,int index){
        return new GestureDetector(
          child: Card(
            child: Container(child: Text("Item $index"),alignment: Alignment.center,),
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          ),
          onTap: (){
            PopupHelper.showPopup(context,"Item clicked $index");
          },
        );
      },
    );
  }

  @override
  Widget GetBody() {
    // TODO: implement GetBody
    return TabBarView(
      controller: tabController,
      children: <Widget>[
        GetListView(),
        GetGridView(),
      ],
    );
  }
}