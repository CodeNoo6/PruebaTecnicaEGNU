class InfoGroupResponse {
  final String id;
  final String name;
  final String campus;
  final String institution;
  final String municipality;
  final String numGroup;

  InfoGroupResponse({
    required this.id,
    required this.name,
    required this.campus,
    required this.institution,
    required this.municipality,
    required this.numGroup
  });

  factory InfoGroupResponse.fromJson(Map<String, dynamic> json) {
    return InfoGroupResponse(
      id: json['id'],
      name: json['nombre'],
      campus: json['sede'],
      institution: json['institución'],
      municipality: json['municipio'],
      numGroup: json['numGrupo'],
    );
  }
}
