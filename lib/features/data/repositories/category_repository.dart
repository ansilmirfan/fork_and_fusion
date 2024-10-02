import 'package:fork_and_fusion/features/data/data_source/firebase/firebase_services.dart';
import 'package:fork_and_fusion/features/data/model/category_model.dart';
import 'package:fork_and_fusion/features/domain/entity/category.dart';
import 'package:fork_and_fusion/features/domain/repository/category_repo.dart';

class CategoryRepository extends CategoryRepo {
  final FirebaseServices _dataSource = FirebaseServices();
  @override
  Future<List<CategoryEntity>> getAllCategory() async {
    final data = await _dataSource.getAll('category');
    return data.map((element) => CategoryModel.fromMap(element)).toList();
  }
}
