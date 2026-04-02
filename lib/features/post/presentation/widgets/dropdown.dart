import 'package:auction_clean_arch/features/categories/domain/entities/category_entity.dart';
import 'package:auction_clean_arch/features/categories/presentation/cubit/category_cubit.dart';
import 'package:auction_clean_arch/features/post/presentation/cubit/add_update_cubit/add_update_post_cubit.dart';
import 'package:auction_clean_arch/features/post/presentation/cubit/add_update_cubit/add_update_post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryDropdown extends StatelessWidget {
  // final List<CategoryModel> categories;

  const CategoryDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategorySuccess) {
          String selectedText = "اختر الفئة";

          if (state.selectedParentDropDown != null) {
            selectedText = state.selectedChildDropDown != null
                ? "${state.selectedParentDropDown!.nameAr} → ${state.selectedChildDropDown!.nameAr}"
                : state.selectedParentDropDown!.nameAr;
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Text(
              //   "الفئة",
              //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              // ),
              // const SizedBox(height: 6),

              // ------ UI -------
              InkWell(
                onTap: () => _openDialog(context, state.categories),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.03),
                    //  Services.prefs?.getBool("isDark") == true
                    //     ? Colors.black.withOpacity(0.03)
                    //     : Colors.white.withOpacity(0.03),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.black26,
                      //  Services.prefs?.getBool("isDark") == true
                      //     ? Colors.white24
                      //     : Colors.black26,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(selectedText, style: const TextStyle(fontSize: 15)),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),

              // if (selectedId != null) ...[
              //   const SizedBox(height: 10),
              //   Text("ID المختار: $selectedId"),
              // ]
            ],
          );
        }
        // else if(state is CategoryFailure)
        else {
          return SizedBox();
        }
      },
    );
  }

  void _openDialog(BuildContext context, List<CategoryEntity> categories) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("اختر الفئة"),
        content: SizedBox(
          width: double.maxFinite,
          height: 350,
          child: ListView(
            children: categories.map((catParent) {
              bool hasChildren =
                  catParent.children != null && catParent.children!.isNotEmpty;

              return hasChildren
                  ? ExpansionTile(
                      // leading: const Icon(Icons.arrow_drop_down),
                      title: Text(catParent.nameAr),
                      children: catParent.children!.map((catChild) {
                        return ListTile(
                          // leading: const Icon(Icons),
                          title: Text(catChild.nameAr),
                          onTap: () {
                            context
                                .read<CategoryCubit>()
                                .changeSelectedCategoryDropDown(
                                  catChild,
                                  catParent,
                                );
                            // (cat, child);
                            Navigator.pop(context);
                          },
                        );
                      }).toList(),
                    )
                  : ListTile(
                      // leading: const Icon(Icons.circle_outlined),
                      title: Text(catParent.nameAr),
                      onTap: () {
                        context
                            .read<CategoryCubit>()
                            .changeSelectedCategoryDropDown(null, catParent);

                        Navigator.pop(context);
                      },
                    );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
