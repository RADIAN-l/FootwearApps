import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lab_assignment_client/pages/product_description_page.dart';


import '../controller/home_controller.dart';
import '../widgets/drop_down_bttn.dart';
import '../widgets/multi_select_drop_down.dart';
import '../widgets/product_card.dart';
import 'login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return RefreshIndicator(
        onRefresh: () async{
          ctrl.fetchProducts();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Footware Store', style: TextStyle(fontWeight: FontWeight.bold),),
            actions: [
              IconButton(onPressed: () {
                final box = GetStorage();
                box.erase();
                Get.offAll(LoginPage());
              }, icon: Icon(Icons.logout)),
            ],
          ),
          body: Column(
            children: [
              SizedBox(
                height: 50,
                child: Flexible(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: ctrl.productCategory.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            ctrl.filterByCategory(ctrl.productCategory[index].name ?? '');
                          },
                          child: Padding(padding: EdgeInsets.all(6),
                            child: Chip(label: Text(ctrl.productCategory[index].name ?? 'null')
                            ),
                          ),
                        );
                      }
                  ),
                ),
              ),
              Row(
                children: [
                  Flexible(
                    child: DropDownBttn(
                        items: ['Price: Low to High', 'Price: High to Low'],
                        selectedItemText: 'Sort',
                        onSelected: (selected) {
                          ctrl.sortByPrice(ascending: selected == 'Price: Low to High' ? true : false );
                        }),
                  ),
                  Flexible(
                      child: MultiSelectDropDown(
                        items: ['Apex', 'Bata', 'Lotto'],
                        onSelectionChanged: (selectedItems) {
                          ctrl.filterByBrand(selectedItems);
                        },
                      )
                  )

                ],
              ),
              Expanded(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: .8,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8
                    ),
                    itemCount: ctrl.productShowInUi.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        name: ctrl.productShowInUi[index].name ?? 'No Name',
                        imageUrl:ctrl.productShowInUi[index].image ?? 'url',
                        price: ctrl.productShowInUi[index].price ?? 00,
                        offer: '30% off',
                        onTap: () {
                          Get.to(ProductDescriptionPage(),arguments: {'data':ctrl.productShowInUi[index]});
                        },
                      );
                    }
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
