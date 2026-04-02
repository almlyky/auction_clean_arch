enum TypeCategory { parent, child }

enum PostActionType { create, update }

enum PostCardMode { public, owner }

class ProductStatus {
  static const String newItem = 'new';
  static const String used = 'used';
}

class PostStatus {
  static const String available = 'available';
  static const String sold = 'sold';
}
