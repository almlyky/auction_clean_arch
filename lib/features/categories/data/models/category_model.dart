import 'package:hive/hive.dart';
// part 'category_model.g.dart';

// @HiveType(typeId: 0)
class CategoryModel extends HiveObject {
  // @HiveField(0)
  final int? id;
  // @HiveField(1)
  final String nameAr;
  // @HiveField(2)
  final String nameEn;
  // @HiveField(3)
  final int? parentId;
  // @HiveField(4)
  final List<CategoryModel>? children;

  CategoryModel({
    this.id,
    required this.nameAr,
    required this.nameEn,
    this.parentId,
    this.children,
  });
 
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    List<CategoryModel>? childrenList;
    if (json['children'] != null) {
      childrenList = <CategoryModel>[];
      json['children'].forEach((v) {
        childrenList!.add(CategoryModel.fromJson(v));
      });
    }

    return CategoryModel(
      id: json['id'],
      nameAr: json['name_ar'],
      nameEn: json['name_en'],
      parentId: json['parent_id'],
      children: childrenList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_ar': nameAr,
      'name_en': nameEn,
      'parent_id': parentId,
      'children': children?.map((v) => v.toJson()).toList(),
    };
  }
}
