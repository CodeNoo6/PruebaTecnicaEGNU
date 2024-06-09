class Municipality {
  final String name;
  final String dane;

  Municipality({required this.name, required this.dane});

  factory Municipality.fromJson(Map<String, dynamic> json) {
    return Municipality(
      name: json['nombre'],
      dane: json['dane'],
    );
  }
}
