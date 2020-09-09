class Food {
  String name;
  double quantity;
  String unit;
  Food({this.name, this.quantity, this.unit});
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['name'] = name;
    map['quantity'] = quantity;
    map['unit'] = unit;
    return map;
  }

  Food.fromMap(Map<String, dynamic> map) {
    this.name = map['name'];
    this.quantity = (map['quantity'].toDouble());
    this.unit = map['unit'];
  }
}
