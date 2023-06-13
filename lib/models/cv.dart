class CV {
  int? id;
  late int data;
  late int km;
  late String tipus;
  late int concepte;
  late int quantitat;

  CV({
    this.id,
    required this.data,
    required this.km,
    required this.tipus,
    required this.concepte,
    required this.quantitat,
  });

  // Convert a CV into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'data': data,
      'km': km,
      'tipus': tipus,
      'concepte': concepte,
      'quantitat': quantitat,
    };
  }

  // Convert a Map to a CV object
  CV.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    data = map['data'];
    km = map['km'];
    tipus = map['tipus'];
    concepte = map['concepte'];
    quantitat = map['quantitat'];
  }
}
