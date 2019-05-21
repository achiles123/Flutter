import 'package:flutter/material.dart';
import 'package:flutter_app/Menu/Menu.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_app/PopupHepler.dart';
import 'package:intl/intl.dart';

class MenuSecond extends Menu{
  GlobalKey<FormState> _formKey;
  TextEditingController _txtName;
  @override
  Widget GetBody() {
    _formKey = new GlobalKey<FormState>();
    _txtName = new TextEditingController();
    // TODO: implement GetBody
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _txtName,
            autofocus: true,
            autovalidate: true,
            keyboardType: TextInputType.numberWithOptions(),
            validator: (value){
              var result = int.tryParse(value);
              if(result != null && result < 0) {
                return "Số phải lớn hơn 0";
              }
            },
            cursorColor: Colors.red,
            style: TextStyle(color: Colors.red),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
              border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
              hintText: "Type here",
              prefixIcon: Icon(Icons.short_text),
              suffixText: "haha",
              fillColor: Colors.red,
            ),

          ),
          DateTimePickerFormField(
            inputType: InputType.both,
            editable: false,
            format: DateFormat("yyyy-MM-dd HH:mm:ss"),
            initialDate: DateTime(2019,1,1),

          ),
          RaisedButton(
            child: Text("Submit"),
            onPressed: (){
              if(_txtName.text == "" || !_formKey.currentState.validate())
                return null;
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailScreen(message:_txtName.text)));
            },
          )
        ],
      ),
    );
  }
}

class DetailScreen extends StatelessWidget{
  String message;
  DetailScreen({@required String this.message}){
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiet"),
        leading: new Container(),
      ),
      body: Text(message),
      floatingActionButton: FloatingActionButton(onPressed: (){Navigator.of(context).pop();},child: Icon(Icons.arrow_back),tooltip: "Tro lai",),
    );
  }

}

