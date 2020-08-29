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
      if (map['weight'] != null) {
        this.weight = map['weight'].toDouble();
        this.arm = map['arm'].toDouble() ?? null;
        this.waist = map['waist'].toDouble() ?? null;

        this.neck = map['neck'].toDouble() ?? null;
        this.hip = map['hip'].toDouble() ?? null;
        this.height = map['height'].toDouble() ?? null;
      } else {
        this.weight = null;
        this.arm = null;
        this.waist = null;

        this.neck = null;
        this.hip = null;
        this.height = null;
      }
    }
  }
}
