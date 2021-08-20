import 'package:accord/constant/accord_labels.dart';
import 'package:accord/models/order.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/screens/widgets/error_displayer.dart';
import 'package:accord/utils/exposer.dart';
import 'package:accord/utils/time_calculator.dart';
import 'package:accord/viewModel/order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderListView extends StatelessWidget {
  const OrderListView({Key key}) : super(key: key);
  static const double imageHeight = 70.0;
  static const double imageWidth = 65.0;

  _orderItemsBuilder({OrderItem orderItem}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          orderItem.bookImage,
                          height: imageHeight,
                          width: imageWidth,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            orderItem.bookName,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[900]),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            orderItem.bookAuthor,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[600],
                                fontStyle: FontStyle.italic),
                          ),
                          Text(
                            "Rs. ${orderItem.bookPrice}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                          Text(
                            ("x${orderItem.quantity}"),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: Color(0xff247BA0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  _orderListView({Order order}) {
    // total number of items in current order.
    final int totalItemInOrder = order.orderItems
        .map((item) => int.parse(item.quantity))
        .fold(0, (previousValue, element) => previousValue + element);

    // overall price of items in current order.
    final int overallPriceOfOrder = order.orderItems
        .map((item) => int.parse(item.totalPrice))
        .fold(0, (previousValue, element) => previousValue + element);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0.0),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order ${order.orderID}",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.grey[800]),
          ),
          Text(
            "Placed On ${TimeCalculator.dateFormatter(givenTime: order.createAt)}",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: Colors.grey[400]),
          ),
          Divider(
            height: 0,
            thickness: 0.5,
            indent: 0,
            endIndent: 0,
            color: Colors.grey[300],
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: order.orderItems.length,
            itemBuilder: (context, index) {
              return _orderItemsBuilder(
                orderItem: order.orderItems[index],
              );
            },
          ),
          SizedBox(
            height: 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "${totalItemInOrder} ${totalItemInOrder > 1 ? "Items" : "Item"},",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(
                width: 3,
              ),
              Text(
                "${AccordLabels.total}: ",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(
                width: 3,
              ),
              Text(
                "Rs. ${overallPriceOfOrder}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff247BA0),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    OrderViewModel orderViewModel = context.read<OrderViewModel>();

    // fetch order data only if [orders] is null.
    orderViewModel.orders ?? orderViewModel.fetchOrders();

    return RefreshIndicator(
        onRefresh: () => orderViewModel.fetchOrders(),
        child: Consumer<OrderViewModel>(
          builder: (context, orderViewModel, child) {
            switch (orderViewModel.data.status) {
              case Status.LOADING:
                return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                );
              case Status.COMPLETE:
                List<Order> orders = orderViewModel.orders;

                return ListView.builder(
                  itemCount: orders.isEmpty ? 1 : orders.length,
                  itemBuilder: (context, index) {
                    return orders.isNotEmpty
                        ? _orderListView(
                            order: orders[index],
                          )
                        : Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(top: 20),
                            width: MediaQuery.of(context).size.width,
                            child: CustomText(
                              textToShow: "You have not ordered any books yet.",
                              fontSize: 18,
                              letterSpacing: -1,
                              fontWeight: FontWeight.w500,
                              textColor: Colors.black45,
                            ),
                          );
                  },
                );
              case Status.ERROR:
                return ErrorDisplayer(
                  error: orderViewModel.data.message,
                  retryOption: () {
                    orderViewModel.resetOrders();
                    orderViewModel.fetchOrders();
                  },
                );
              default:
                return null;
            }
          },
        ));
  }
}
