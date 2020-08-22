class Measurement {
  DateTime date;
  double weight;
  double arm;
  double waist;
  double neck;
  double hip;
  double height;
  Measurement(
      {this.weight,
      this.arm,
      this.hip,
      this.height,
      this.date,
      this.neck,
      this.waist});
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['date'] = date ?? DateTime.now();
    map['weight'] = weight;
    map['neck'] = neck;
    map['waist'] = waist;

    map['arm'] = arm;
    map['hip'] = hip;
    map['height'] = height;

    return map;
  }

  Measurement.fromMap(Map<String, dynamic> map) {
    if (map != null) {
      this.date = (map['date'].toDate());
      this.weight = map['weight'];
      this.arm = map['arm'];
      this.waist = map['waist'];

      this.neck = map['neck'];
      this.hip = map['hip'];
      this.height = map['height'];
    }
  }
}
