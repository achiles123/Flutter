import 'package:flutter/material.dart';
import 'package:flutter_app/Menu/Menu.dart';
import 'package:flutter_app/PopupHepler.dart';

class MenuThird extends StatefulWidget{
  TabController tabController;
  @override
  MenuThirdState createState() => new MenuThirdState();
  void SetTabController(TabController tabController){
    this.tabController = tabController;
  }

}

class MenuThirdState extends State<MenuThird> with TickerProviderStateMixin {
  BuildContext _context;
  List<String> items = List<String>.generate(100, (i) => "Item ${i + 1}");
  Animation<double> _animation;
  AnimationController _animationController;
  PopupHelper _popup;

  @override
  void initState(){
    super.initState();
    _animationController = new AnimationController(vsync: this,duration: Duration(seconds: 2));
    _animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    this._context = context;
    _popup = new PopupHelper(context);
    return this.GetBody();
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
              _popup.ShowPopup(message:"Item clicked $index");
            },

          ),
        );
      },

    );
  }

  Widget GetGridView(){
    var animation = Tween(begin: 0.0,end: 2*3.14).animate(_animationController);
    return GridView.builder(
      itemCount: 100,

      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(_context).orientation == Orientation.portrait?3:2,
        childAspectRatio: MediaQuery.of(_context).size.width /(MediaQuery.of(_context).size.height/2 ),

      ),
      itemBuilder: (BuildContext context,int index){
        return AnimatedBuilder(
            animation:animation ,
            child: GestureDetector(
                child: Card(
                    child: Container(child: Text("Item $index"),alignment: Alignment.center,),
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                 ),
                onTap: (){
                  _popup.ShowPopup(message:"Item clicked $index");
                },
            ),
            builder: (context,child){
              return Transform.rotate(angle: animation.value,child: child,);
            });

      },
    );
  }

  @override
  Widget GetBody() {
    // TODO: implement GetBody
    return TabBarView(
      controller: this.widget.tabController,
      children: <Widget>[
        GetListView(),
        GetGridView(),
      ],
    );
  }
}
