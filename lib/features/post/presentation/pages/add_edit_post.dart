import 'package:auction_clean_arch/core/helpers/snackbar_helper.dart';
import 'package:auction_clean_arch/core/utils/enums.dart';
import 'package:auction_clean_arch/core/widgets/fullscrean_loader.dart';
import 'package:auction_clean_arch/features/categories/domain/entities/category_entity.dart';
import 'package:auction_clean_arch/features/categories/presentation/cubit/category_cubit.dart';
import 'package:auction_clean_arch/features/post/data/models/post_model.dart';
import 'package:auction_clean_arch/features/post/domain/entities/post_entity.dart';
import 'package:auction_clean_arch/features/post/presentation/cubit/add_update_cubit/add_update_post_cubit.dart';
import 'package:auction_clean_arch/features/post/presentation/cubit/add_update_cubit/add_update_post_state.dart';
import 'package:auction_clean_arch/features/post/presentation/cubit/post_images_cubit/post_images_cubit.dart';
import 'package:auction_clean_arch/features/post/presentation/widgets/custotextfield.dart';
import 'package:auction_clean_arch/features/post/presentation/widgets/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../features/category/presentation/category_cubit/category_cubit.dart';

class AddEditPost extends StatelessWidget {
  final PostActionType postAction;
  final PostEntity? post; // Add post parameter for edit mode
  const AddEditPost({super.key, required this.postAction, this.post});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddUpdatePostCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          postAction == PostActionType.create
              ? 'إضافة إعلان جديد'
              : "تعديل الاعلان",
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: cubit.formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    CustomTextFieldPost(
                      controller: cubit.name,
                      label: 'عنوان الإعلان',
                    ),
                    const SizedBox(height: 10),
                    CustomTextFieldPost(
                      minLines: 5,
                      maxLines: 10,
                      controller: cubit.description,
                      label: 'وصف الإعلان',
                    ),
                    const SizedBox(height: 10),
                    CustomTextFieldPost(
                      controller: cubit.price,
                      label: 'السعر',
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 10),
                    CustomTextFieldPost(
                      controller: cubit.address,
                      label: 'مكان المنتج',
                    ),
                    const SizedBox(height: 10),

                    DropdownButtonFormField<String>(
                      initialValue: cubit.productStatus,
                      decoration: const InputDecoration(
                        labelText: 'حالة المنتج',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: ProductStatus.newItem,
                          child: Text('جديد'),
                        ),
                        DropdownMenuItem(
                          value: ProductStatus.used,
                          child: Text('مستعمل'),
                        ),
                      ],
                      onChanged: (val) {
                        if (val != null) cubit.changeProductStatus(val);
                      },
                      validator: (val) => val == null || val.isEmpty
                          ? 'اختر حالة المنتج'
                          : null,
                    ),

                    const SizedBox(height: 16),
                    CategoryDropdown(),
                    // Category Dropdown - Simplified for now, ideally should be a separate widget that takes state
                    // InkWell(
                    //   // onTap: () => _openCategoryDialog(context, cubit),
                    //   child: Container(
                    //     padding: const EdgeInsets.symmetric(
                    //       horizontal: 14,
                    //       vertical: 16,
                    //     ),
                    //     // decoration: BoxDecoration(
                    //     //   color: Services.prefs?.getBool("isDark") == true
                    //     //       ? Colors.black.withOpacity(0.03)
                    //     //       : Colors.white.withOpacity(0.03),
                    //     //   borderRadius: BorderRadius.circular(12),
                    //     //   border: Border.all(
                    //     //     color: Services.prefs?.getBool("isDark") == true
                    //     //         ? Colors.white24
                    //     //         : Colors.black26,
                    //     //   ),
                    //     // ),
                    //     // child: Row(
                    //     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     //   children: [
                    //     //     Text(
                    //     //       state.selectedCategoryText,
                    //     //       style: const TextStyle(fontSize: 15),
                    //     //     ),
                    //     //     const Icon(Icons.arrow_drop_down),
                    //     //   ],
                    //     // ),
                    //   ),
                    // ),
                    const SizedBox(height: 16),

                    // Images
                    BlocBuilder<PostImagesCubit, PostImagesState>(
                      builder: (context, state) {
                        final postImagesCubit = context.read<PostImagesCubit>();

                        return SizedBox(
                          height: 100,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              ...postImagesCubit.serverImage
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                    int index = entry.key;
                                    var image = entry.value;
                                    return Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            child: Image.network(
                                              image.imageUrl ?? "",
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (
                                                    context,
                                                    error,
                                                    stackTrace,
                                                  ) => const Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 0,
                                          child: IconButton(
                                            onPressed: () {
                                              postImagesCubit
                                                  .deleteExistingImage(index);
                                            },
                                            icon: const Icon(
                                              Icons.delete_forever_sharp,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                              ...postImagesCubit.pickerImages
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                    int index = entry.key;
                                    var file = entry.value;
                                    return Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            child: Image.file(
                                              file,
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 0,
                                          child: IconButton(
                                            onPressed: () {
                                              postImagesCubit.deleteNewImage(
                                                index,
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.delete_forever_sharp,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    postImagesCubit.selectPostImage();
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(
                                      Icons.add_a_photo,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 16),

                    // if (state.status is BaseLoading)
                    //   const CircularProgressIndicator(),

                    // const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (cubit.formKey.currentState!.validate()) {
                          if (context.read<CategoryCubit>().selectedCatID ==
                              null) {
                            SnackbarHelper.showSnackbar("يرجى اختيار الفئة");
                            return;
                          }
                          if (postAction == PostActionType.create) {
                            cubit.addPosts(
                              context.read<PostImagesCubit>().pickerImages,
                              context.read<CategoryCubit>().selectedCatID!,
                            );
                          } else {
                            cubit.updatePosts(
                              context.read<PostImagesCubit>().pickerImages,
                              post!.id!,
                              context.read<PostImagesCubit>().deletedImageIds,
                              context.read<CategoryCubit>().selectedCatID!,
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        postAction == PostActionType.create
                            ? 'إضافة الإعلان'
                            : "تعديل الاعلان",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          BlocBuilder<AddUpdatePostCubit, AddUpdatePostState>(
            builder: (context, state) {
              if (state is Loading) {
                return const FullScreenLoader();
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  //   void _openCategoryDialog(BuildContext contex) {

  //     showDialog(
  //       context: context,
  //       builder: (_) => AlertDialog(
  //         title: const Text("اختر الفئة"),
  //         content: SizedBox(
  //           width: double.maxFinite,
  //           height: 350,
  //           child: ListView(
  //             children: categories.map((cat) {
  //               bool hasChildren =
  //                   cat.children != null && cat.children!.isNotEmpty;

  //               return hasChildren
  //                   ? ExpansionTile(
  //                       title: Text(cat.nameAr),
  //                       children: cat.children!.map((child) {
  //                         return ListTile(
  //                           title: Text(child.nameAr ?? ""),
  //                           onTap: () {
  //                             cubit.selectedCategory(cat, child);
  //                             Navigator.pop(context);
  //                           },
  //                         );
  //                       }).toList(),
  //                     )
  //                   : ListTile(
  //                       title: Text(cat.nameAr ?? ""),
  //                       onTap: () {
  //                         cubit.selectedCategory(cat, null);
  //                         Navigator.pop(context);
  //                       },
  //                     );
  //             }).toList(),
  //           ),
  //         ),
  //       ),
  //     );
  //   }
}
