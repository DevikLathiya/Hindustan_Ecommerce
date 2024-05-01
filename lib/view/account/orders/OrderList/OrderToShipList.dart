import 'package:amazy_app/controller/order_controller.dart';
import 'package:amazy_app/model/Order/Package.dart';
import 'package:amazy_app/utils/styles.dart';
import 'package:amazy_app/view/account/orders/OrderList/widgets/NoOrderPlacedWidget.dart';
import 'package:amazy_app/view/account/orders/OrderList/widgets/OrderToShipReceiveWidget.dart';
import 'package:amazy_app/widgets/custom_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderToShipListScreen extends StatelessWidget {
  final OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    orderController.getToShipOrders();

    return Obx(
      () {
        if (orderController.isToShipOrderLoading.value) {
          return Center(
            child: CustomLoadingWidget(),
          );
        } else {
          if (orderController.toShippedOrderListModel.value.packages == null ||
              orderController.toShippedOrderListModel.value.packages.length ==
                  0) {
            return NoOrderPlacedWidget();
          }
          return Container(
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return Divider(
                  color: AppStyles.appBackgroundColor,
                  height: 5,
                  thickness: 5,
                );
              },
              itemCount:
                  orderController.toShippedOrderListModel.value.packages.length,
              itemBuilder: (context, index) {
                Package package = orderController
                    .toShippedOrderListModel.value.packages[index];
                return OrderToShipReceiveWidget(
                  package: package,
                );
              },
            ),
          );
        }
      },
    );
  }
}
