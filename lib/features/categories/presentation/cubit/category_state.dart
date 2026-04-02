part of 'category_cubit.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object?> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategorySuccess extends CategoryState {
  final List<CategoryEntity> categories;
  final CategoryEntity? selectedParent;
  final CategoryEntity? selectedChild;
  final CategoryEntity? selectedParentDropDown;
  final CategoryEntity? selectedChildDropDown;
  const CategorySuccess({
    required this.categories,
    this.selectedParent,
    this.selectedChild,
    this.selectedParentDropDown,
    this.selectedChildDropDown,
  });

  @override
  List<Object?> get props => [categories, selectedParent, selectedChild,selectedChildDropDown,selectedParentDropDown];


  /// This implementation uses a sentinel value to distinguish between:
  /// - parameters that are not provided (keep the current value)
  /// - parameters explicitly set to null (reset the value)
  ///
  /// This is especially useful when working with nullable fields in Bloc/Cubit states.
  CategorySuccess copyWith({
    Object? selectedParent = _sentinel,
    Object? selectedChild = _sentinel,
    Object? selectedParentDropDown = _sentinel,
    Object? selectedChildDropDown = _sentinel,
  }) {
    return CategorySuccess(
      categories: categories,
      selectedParent: identical(selectedParent, _sentinel)
          ? this.selectedParent
          : selectedParent as CategoryEntity?,
      selectedChild: identical(selectedChild, _sentinel)
          ? this.selectedChild
          : selectedChild as CategoryEntity?,
      selectedParentDropDown: identical(selectedParentDropDown, _sentinel)
          ? this.selectedParentDropDown
          : selectedParentDropDown as CategoryEntity?,
      selectedChildDropDown: identical(selectedChildDropDown, _sentinel)
          ? this.selectedChildDropDown
          : selectedChildDropDown as CategoryEntity?,
    );
  }

  static const _sentinel = Object();
}

class CategoryFailure extends CategoryState {
  final String message;

  const CategoryFailure(this.message);

  @override
  List<Object> get props => [message];
}
