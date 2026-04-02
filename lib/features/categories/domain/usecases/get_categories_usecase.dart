import 'package:auction_clean_arch/core/network/result.dart';
import 'package:auction_clean_arch/features/categories/domain/entities/category_entity.dart';
import 'package:auction_clean_arch/features/categories/domain/repositories/category_repository.dart';

class GetCategoriesUseCase {
  final CategoryRepo repository;

  GetCategoriesUseCase(this.repository);

  Future<Result<List<CategoryEntity>>> call() async {
    return await repository.getCategories();
  }
}
