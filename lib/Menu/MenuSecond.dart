import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Menu/Menu.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
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
            obscureText: true,
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
              if(_txtName.value.text == "" || !_formKey.currentState.validate())
                return null;
              return showDialog(context: this.context,barrierDismissible: true,
                  child: CupertinoAlertDialog(
                    content: Text(_txtName.value.text),
                    actions: <Widget>[
                      FlatButton(
                        child: Icon(Icons.close),
                        onPressed: (){Navigator.of(context).pop();},
                      )
                    ],
                  ));
            },
          )
        ],
      ),
    );
  }
}

