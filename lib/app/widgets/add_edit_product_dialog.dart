import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/product_model.dart';
import '../modules/home/controllers/home_controller.dart';
import '../modules/home/controllers/manager_controller.dart';
import 'custom_input_decoration.dart';

class AddEditProductDialog extends GetView<ManagerController> {
  @override
  AddEditProductDialog({required this.existingProduct});
  Product existingProduct;

  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
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
                initialValue: existingProduct.title,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is mandatory';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  existingProduct.title = newValue!;
                },
                decoration: customInputDecoration('title'),
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                initialValue: existingProduct.price.toString(),
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
                  existingProduct.price = double.parse(newValue!);
                },
                decoration: customInputDecoration('price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                initialValue: existingProduct.description,
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
                  existingProduct.description = newValue!;
                },
                decoration: customInputDecoration('description'),
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
                                child:
                                    Image.network(mC.imageUrlController.text),
                              ),
                      );
                    },
                  ),
                  Expanded(
                    child: TextFormField(
                      /* initialValue: productWithFavorite.imageUrl, */
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
                        existingProduct.imageUrl = newValue!;
                      },
                      decoration: customInputDecoration('image URL'),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      padding: EdgeInsets.only(right: 35),
                      onPressed: () {
                        controller.clearInitialValue();
                        Get.back();
                      },
                      icon: Icon(
                        Icons.skip_previous,
                        size: 55,
                        color: Colors.blue.shade200,
                      )),
                  IconButton(
                      padding: EdgeInsets.only(right: 35),
                      onPressed: () {
                        controller.newProduct = existingProduct;
                        print(
                            'before saved ${controller.newProduct.isFavorite}');
                        controller.saveFormKey();
                        controller.clearInitialValue();
                      },
                      icon: Icon(
                        Icons.data_saver_on_rounded,
                        size: 55,
                        color: Colors.blue.shade200,
                      )),
                ],
              ),
              SizedBox(
                height: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
