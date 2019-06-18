class Combo{
  final String group_code;
  final String group_name;
  final List<Map<String,dynamic>> items;

  Combo({this.group_code,this.group_name,this.items});

  factory Combo.parseJson(Map<String,dynamic> json){
    return Combo(
      group_code: json["group_code"],
      group_name: json["group_name"],
      items: json["items"],
    );
  }
}