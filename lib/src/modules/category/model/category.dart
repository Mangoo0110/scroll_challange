class Category {
  final String id;
  final String name;
  final String? description;
  final String? imageUrl;
  final bool isActive;

  const Category({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    this.isActive = true,
  });

  Category copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    bool? isActive,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      isActive: isActive ?? this.isActive,
    );
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'isActive': isActive,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Category &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.imageUrl == imageUrl &&
        other.isActive == isActive;
  }

  @override
  int get hashCode {
    return Object.hash(id, name, description, imageUrl, isActive);
  }

  @override
  String toString() {
    return 'Category(id: $id, name: $name, isActive: $isActive)';
  }
}
