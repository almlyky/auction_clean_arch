import 'package:auction_clean_arch/core/theme/app_colors.dart';
import 'package:auction_clean_arch/core/utils/enums.dart';
import 'package:auction_clean_arch/features/categories/domain/entities/category_entity.dart';
import 'package:auction_clean_arch/features/categories/presentation/cubit/category_cubit.dart';
import 'package:auction_clean_arch/features/post/presentation/cubit/post_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../features/category/presentation/category_cubit/category_cubit.dart';
// import '../../../features/post/presentation/cubit/post_cubit/post_cubit.dart';

class Categories extends StatelessWidget {
  const Categories({
    super.key,
    required this.categories,
    this.selectedCategory,
    required this.typeCategory,
  });
  final List<CategoryEntity> categories;
  final CategoryEntity? selectedCategory;
  final TypeCategory typeCategory;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length + 1,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final bool isAll = index == 0;
          bool isSelected = false;
          if (isAll) {
            isSelected = selectedCategory == null;
            return CategoryCard(
              isAll: isAll,
              isSelected: isSelected,
              typeCategory: typeCategory,
            );
          }

         
          isSelected = selectedCategory?.id == categories[index - 1].id;
          return CategoryCard(
            isAll: isAll,
            category: categories[index - 1],
            isSelected: isSelected,
            typeCategory: typeCategory,
          );
        },
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.isAll,
    this.category,
    required this.isSelected,
    required this.typeCategory,
  });

  final bool isAll;
  final bool isSelected;
  final CategoryEntity? category;
  final TypeCategory typeCategory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        if (isAll) {
          context.read<CategoryCubit>().changeSelectedCategory(
            categoryEntity: null,
            typeCategory: typeCategory,
          );
          if (typeCategory == TypeCategory.parent) {
            // emit(success.copyWith(selectedParent: null));
            context.read<PostCubit>().fetchPosts();
          } else {
            final state = context.read<CategoryCubit>().state;

            if (state is CategorySuccess) {
              final selectedParent = state.selectedParent;
              context.read<PostCubit>().fetchPostsByCategory(
                selectedParent!.id!,
              );
            }

            // emit(success.copyWith(selectedChild: null));
          }
        } else {
          context.read<CategoryCubit>().changeSelectedCategory(
            categoryEntity: category!,
          );
          context.read<PostCubit>().fetchPostsByCategory(category!.id!);
        }
      },
      child: Container(
        // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.grey[200],
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: Colors.blueAccent.withOpacity(0.3),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
          ],
        ),
        child: Center(
          child: Text(
            isAll ? "الكل" : category!.nameAr,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
