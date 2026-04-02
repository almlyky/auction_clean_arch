import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'category_entity.g.dart';

@HiveType(typeId: 0)
class CategoryEntity extends HiveObject {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String nameAr;
  @HiveField(2)
  final String nameEn;
  @HiveField(3)
  final int? parentId;
  @HiveField(4)
  final List<CategoryEntity>? children;

  CategoryEntity({
    this.id,
    required this.nameAr,
    required this.nameEn,
    this.parentId,
    this.children,
  });

  @override
  List<Object?> get props => [id, nameAr, nameEn, parentId, children];
}
