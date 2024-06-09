class Campus {
  final String name;
  final String dane;

  Campus({required this.name, required this.dane});

  factory Campus.fromJson(Map<String, dynamic> json) {
    return Campus(
      name: json['nombre'],
      dane: json['dane'],
    );
  }
}
