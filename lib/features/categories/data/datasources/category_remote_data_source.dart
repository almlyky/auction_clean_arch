import 'package:auction_clean_arch/core/network/dio_client.dart';
import 'package:auction_clean_arch/features/categories/data/models/category_model.dart';

abstract class CategoryRemote {
  Future<List<CategoryModel>> getCategories();
}

class CategoryRemoteImpl implements CategoryRemote {
  final DioClient dioClient;
  CategoryRemoteImpl(this.dioClient);
  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await dioClient.get("categories");
    // Assuming API follows standard response wrapper: { data: [...] }
    final List<dynamic> data = response.data['data'];
    return data.map((json) => CategoryModel.fromJson(json)).toList();
  }
}
