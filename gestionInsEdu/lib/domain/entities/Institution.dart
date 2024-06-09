class Institution {
  final String name;
  final String dane;

  Institution({required this.name, required this.dane});

  factory Institution.fromJson(Map<String, dynamic> json) {
    return Institution(
      name: json['nombre'],
      dane: json['dane'],
    );
  }
}
