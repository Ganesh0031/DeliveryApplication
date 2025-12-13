import 'dart:convert';
import 'package:http/http.dart';


import '../Repository/RestAdapterRepository.dart';
import '../Response/CategoriesListResponse.dart';
import '../Views/MVPView.dart';

abstract class CategoriesListGetView extends MVPView {
  void showCategoriesListDataGetResponse(List<CategoriesListResponse> response);
}

abstract class CategoriesListGetOps {
  void getCategoriesListData(String category);
  void onCategoriesListDataReceived(List<CategoriesListResponse> response);
}

class CategoriesListPresenter implements CategoriesListGetOps {
  CategoriesListGetView categoriesListGetView;
  late RestAdapterRepository _adapterRepository;

  CategoriesListPresenter(this.categoriesListGetView) {
    _adapterRepository = RestAdapterRepository();
  }
  @override
  void getCategoriesListData(String category) {
    categoriesListGetView.showLoading();

    _adapterRepository.get("products/category/$category").then((res) {


      List jsonList = res as List;

      List<CategoriesListResponse> data =
      jsonList.map((json) => CategoriesListResponse.fromJson(json)).toList();

      onCategoriesListDataReceived(data);
    }).catchError((error) {
      print("API Error: $error");
      categoriesListGetView.hideLoading();
    });
  }

  @override
  void onCategoriesListDataReceived(
      List<CategoriesListResponse> response) {
    categoriesListGetView.hideLoading();
    categoriesListGetView.showCategoriesListDataGetResponse(response);
  }
}
