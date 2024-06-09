class Group {
  final String id;
  final String name;
  final String numGroup;

  Group({required this.id, required this.name, required this.numGroup});

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'],
      name: json['nombre'],
      numGroup: json['numGrupo']
    );
  }
}