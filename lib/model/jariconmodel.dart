class JarIconModel {
  final int id;
  final String url;

  JarIconModel({required this.id, required this.url});

  // Factory constructor to create an instance from JSON
  factory JarIconModel.fromJson(Map<String, dynamic> json) {
    return JarIconModel(id: json['id'], url: json['url']);
  }

  // Convert object to JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'url': url};
  }
}
