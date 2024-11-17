import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../model/product/product.dart';
import '../model/product_category/product_category.dart';

class HomeController extends GetxController{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference productCollection;
  late CollectionReference categoryCollection;

  List<Product> products = [];
  List<Product> productShowInUi = [];
  List<ProductCategory> productCategory= [];


  Future<void> onInit() async{
    productCollection=firestore.collection('products');
    categoryCollection=firestore.collection('category');
    await fetchProducts();
    await fetchCategory();
    super.onInit();
  }

  fetchProducts() async{
    try {
      QuerySnapshot productSnapshot = await productCollection.get();
      final List<Product> retrieveProducts = productSnapshot.docs.map((doc) =>
          Product.fromJson(doc.data() as Map<String,dynamic>)).toList();
      products.clear();
      products.assignAll(retrieveProducts);
      productShowInUi.assignAll(products);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }finally{
      update();
    }
  }

  fetchCategory() async{
    try {
      QuerySnapshot categorySnapshot = await categoryCollection.get();
      final List<ProductCategory> retrieveCategory = categorySnapshot.docs.map((doc) =>
          ProductCategory.fromJson(doc.data() as Map<String,dynamic>)).toList();
      productCategory.clear();
      productCategory.assignAll(retrieveCategory);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }finally{
      update();
    }
  }

  filterByCategory(String category){
    productShowInUi.clear();
    productShowInUi = products.where((product)=> product.category == category).toList();
    update();
  }

  filterByBrand(List<String> brands){
    if(brands.isEmpty){
      productShowInUi=products;
    }else{
      List<String> lowerCaseBrands = brands.map((brand)=> brand.toLowerCase()).toList();
      productShowInUi = products.where((product) => lowerCaseBrands.contains(product.brand?.toLowerCase())).toList();
    }
    update();
  }

  sortByPrice({required bool ascending}){
    List<Product> sortedProducts= List<Product>.from(productShowInUi);
    sortedProducts.sort((a, b) => ascending ? a.price!.compareTo(b.price!) : b.price!.compareTo(a.price!));
    productShowInUi=sortedProducts;
    update();
  }

}