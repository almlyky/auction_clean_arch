import 'package:auction_clean_arch/core/errors/exceptions.dart';
import 'package:auction_clean_arch/core/errors/failures.dart';
import 'package:auction_clean_arch/core/errors/handle_result_reop.dart';
import 'package:auction_clean_arch/core/network/result.dart';
import 'package:auction_clean_arch/features/categories/data/datasources/category_remote_data_source.dart';
import 'package:auction_clean_arch/features/categories/data/models/category_model.dart';
import 'package:auction_clean_arch/features/categories/domain/entities/category_entity.dart';
import 'package:auction_clean_arch/features/categories/domain/repositories/category_repository.dart';

class CategoryRepoImpl implements CategoryRepo {
  final CategoryRemote remoteDataSource;

  CategoryRepoImpl(this.remoteDataSource);
  CategoryEntity _mapModelToEntity(CategoryModel model) {
    return CategoryEntity(
      id: model.id,
      nameAr: model.nameAr,
      nameEn: model.nameEn,
      parentId: model.parentId,
      children: model.children
          ?.map((childModel) => _mapModelToEntity(childModel))
          .toList(),
    );
  }

  @override
  Future<Result<List<CategoryEntity>>> getCategories() async {
    return handleResult(
      remoteCall: () => remoteDataSource.getCategories(),
      mapper: (data) => data.map((model) => _mapModelToEntity(model)).toList(),
    );
  }
}
