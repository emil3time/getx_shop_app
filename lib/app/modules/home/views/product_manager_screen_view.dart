import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:getx_shop_app/app/model/product_model.dart';
import 'package:getx_shop_app/app/modules/home/controllers/home_controller.dart';
import 'package:getx_shop_app/app/modules/home/controllers/manager_controller.dart';
import 'package:getx_shop_app/app/widgets/product_manager_item.dart';

class ProductManagerScreenView extends GetView<ManagerController> {
  ProductManagerScreenView({Key? key}) : super(key: key);
  var homeController = Get.put(HomeController());
  var formKey = GlobalKey<FormState>();

  saveFormKey() {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    formKey.currentState!.save();
    homeController.dummyList.add(newProduct);
    print(newProduct.imageUrl);
    print(newProduct.price);
    print(newProduct.title);
    print(newProduct.description);
  }

  validateFormKey(String value) {
    if (value == null || value.isEmpty) {
      return Text('This field is mandatory');
    }
    return null;
  }

  var newProduct = Product(
    description: '',
    id: DateTime.now().toString(),
    title: '',
    imageUrl: '',
    price: 0.0,
  );

  @override
  Widget build(BuildContext context) {
    print('build');
    Get.put<ManagerController>(ManagerController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Products manager',
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.defaultDialog(
                  title: 'Edit/Add product',
                  content: Form(
                    key: formKey,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      height: 380,
                      width: 300,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field is mandatory';
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                newProduct = Product(
                                    description: newProduct.description,
                                    id: newProduct.id,
                                    title: newValue!,
                                    imageUrl: newProduct.imageUrl,
                                    price: newProduct.price);
                              },
                              decoration: InputDecoration(
                                label: Text('title'),
                                contentPadding: EdgeInsets.only(
                                  left: 8.0,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                    width: 1.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.blue.shade100,
                                    width: 2.0,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.red.shade200,
                                    width: 2.0,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.blue.shade100,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field is mandatory';
                                }
                                if (double.tryParse(value) == null) {
                                  return 'Please enter a valid number';
                                }
                                if (double.parse(value) <= 0) {
                                  return 'Please enter price graater then 0';
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                newProduct = Product(
                                    description: newProduct.title,
                                    id: newProduct.id,
                                    title: newProduct.title,
                                    imageUrl: newProduct.imageUrl,
                                    price: double.parse(newValue!));
                              },
                              decoration: InputDecoration(
                                label: Text('price'),
                                contentPadding: EdgeInsets.only(left: 8.0),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                    width: 1.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.blue.shade100,
                                    width: 2.0,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.red.shade200,
                                    width: 2.0,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.blue.shade100,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field is mandatory';
                                }
                                //Todo lenght
                                if (value.length < 1) {
                                  return 'Please add more details to description';
                                }
                                if (value.length > 500) {
                                  return 'Description has more than 500 signs';
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                newProduct = Product(
                                    id: newProduct.id,
                                    title: newProduct.title,
                                    description: newValue!,
                                    imageUrl: newProduct.imageUrl,
                                    price: newProduct.price);
                              },
                              decoration: InputDecoration(
                                label: Text('description'),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 12),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                    width: 1.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.blue.shade100,
                                    width: 2.0,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.red.shade200,
                                    width: 2.0,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.blue.shade100,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              maxLines: 3,
                              keyboardType: TextInputType.multiline,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                GetBuilder<ManagerController>(
                                  builder: (mC) {
                                    return Container(
                                      height: 100,
                                      width: 100,
                                      margin: EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                        width: 2,
                                        color: Colors.blue.shade200,
                                      )),
                                      child: mC.imageUrlController.text.isEmpty
                                          ? Text('Enter a URL')
                                          : FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Image.network(mC.url),
                                            ),
                                    );
                                  },
                                ),
                                Expanded(
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'This field is mandatory';
                                      }
                                      if (!value.startsWith('http') ||
                                          !value.startsWith('https')) {
                                        return 'Please enter a valid URL';
                                      }
                                      if (!value.endsWith('jpg') && //true
                                          !value.endsWith('png') && //false
                                          !value.endsWith('jpeg')) {
                                        //false
                                        print(value.endsWith('jpg'));
                                        print(value.endsWith('png'));
                                        print(value.endsWith('jpeg'));

                                        return 'Please enter a valid URL2';
                                      }

                                      return null;
                                    },
                                    onSaved: (newValue) {
                                      newProduct = Product(
                                          description: newProduct.description,
                                          id: newProduct.id,
                                          title: newProduct.title,
                                          imageUrl: newValue!,
                                          price: newProduct.price);
                                    },
                                    decoration: InputDecoration(
                                      label: Text('image URL'),
                                      contentPadding:
                                          EdgeInsets.only(left: 8.0),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade300,
                                          width: 1.0,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.blue.shade100,
                                          width: 2.0,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.red.shade200,
                                          width: 2.0,
                                        ),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.blue.shade100,
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.url,
                                    controller: controller.imageUrlController,
                                    onFieldSubmitted: (_) {
                                      controller.updateUrlController();
                                    },
                                    onEditingComplete: () {
                                      controller.updateOnEditingComplete();
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                  padding: EdgeInsets.only(right: 35),
                                  onPressed: () {
                                    saveFormKey();
                                  },
                                  icon: Icon(
                                    Icons.data_saver_on_rounded,
                                    size: 55,
                                    color: Colors.blue.shade200,
                                  )),
                            ),
                            SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                      ),
                    ),
                  ));
            },
            icon: Icon(
              Icons.add,
              size: 33,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Obx(() => ListView.builder(
                itemCount: homeController.dummyList.length,
                itemBuilder: (_, i) => ProductManagerItem(
                  productData: homeController.dummyList[i],
                ),
              )),
        ),
      ),
    );
  }
}
