import 'package:auction_clean_arch/core/network/result.dart';
import 'package:auction_clean_arch/features/categories/domain/entities/category_entity.dart';

abstract class CategoryRepo {
  Future<Result<List<CategoryEntity>>> getCategories();
}
