import 'package:auction_clean_arch/core/constant/app_const.dart';
import 'package:auction_clean_arch/core/di/dependency_injection.dart';
import 'package:auction_clean_arch/core/utils/enums.dart';
import 'package:auction_clean_arch/features/categories/data/models/category_model.dart';
import 'package:auction_clean_arch/features/categories/domain/entities/category_entity.dart';
import 'package:auction_clean_arch/features/categories/domain/usecases/get_categories_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final GetCategoriesUseCase _getCategoriesUseCase;

  CategoryCubit(this._getCategoriesUseCase) : super(CategoryInitial()) {
    getCategories();
  }

  final _categoryBox = getIt<Box<CategoryEntity>>();
  int? selectedCatID;
  Map<int, CategoryEntity> getCategoryById = {};

  Future<void> getCategories() async {
    emit(CategoryLoading());
    List<CategoryEntity> categories = [];
    if (_categoryBox.isNotEmpty) {
      categories = _categoryBox.values.toList();
      emit(CategorySuccess(categories: categories));
    } else {
      final result = await _getCategoriesUseCase();
      if (result.isSuccess) {
        categories = result.data!;
        _categoryBox.addAll(result.data!);
        emit(CategorySuccess(categories: result.data!));
      } else {
        emit(CategoryFailure(result.failure!.message));
      }
    }

    if (categories.isNotEmpty) {
      for (var cat in categories) {
        getCategoryById[cat.id!] = cat;
        if (cat.children!.isNotEmpty) {
          for (var child in cat.children!) {
            getCategoryById[child.id!] = child;
          }
        }
      }
    }
  }

  void changeSelectedCategory({
    CategoryEntity? categoryEntity,
    TypeCategory? typeCategory,
  }) {
    if (state is CategorySuccess) {
      final success = (state as CategorySuccess);
      if (categoryEntity == null) {
        if (typeCategory == TypeCategory.parent) {
          emit(success.copyWith(selectedParent: null));
        } else {
          emit(success.copyWith(selectedChild: null));
        }
      } else if (categoryEntity.children?.isNotEmpty == true ||
          categoryEntity.parentId == null) {
        emit(success.copyWith(selectedParent: categoryEntity));
      } else {
        emit(success.copyWith(selectedChild: categoryEntity));
      }
    }
  }

  void changeSelectedCategoryDropDown(
    CategoryEntity? child,
    CategoryEntity? parent,
  ) {
    if (state is CategorySuccess) {
      final success = (state as CategorySuccess);
      selectedCatID = child?.id ?? parent!.id;
      print(selectedCatID);
      emit(
        success.copyWith(
          selectedParentDropDown: parent,
          selectedChildDropDown: child,
        ),
      );
    }
  }

  void setSelectedCategoryDropDown(int catId) {
    CategoryEntity categoryEntity = getCategoryById[catId]!;
    if (state is CategorySuccess) {
      final success = (state as CategorySuccess);

      CategoryEntity parent;
      CategoryEntity? child;

      if (categoryEntity.parentId == null) {
        parent = categoryEntity;
        child = null;
      } else {
        child = categoryEntity;
        parent = getCategoryById[categoryEntity.parentId]!;
      }
      selectedCatID = child?.id ?? parent.id;
      emit(
        success.copyWith(
          selectedParentDropDown: parent,
          selectedChildDropDown: child,
        ),
      );
    }
  }
}
