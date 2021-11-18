import 'package:dmarketing/models/store/Orders.dart';
import 'package:dmarketing/repository/store/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:dmarketing/helper/showtoast.dart';
import 'package:dmarketing/main.dart';
import 'package:dmarketing/models/Constant.dart';

import 'package:dmarketing/elements/CardWidgetOrder.dart';
import 'package:dmarketing/elements/PermissionDeniedWidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var orderProvider = Provider.of<Order>(context,listen: false);
    if(Constant.id!=null){
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_sharp,color: appColor,
                        size: width*0.08,),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Text(
                      translate("profile.order"),
                      style: GoogleFonts.cairo(
                        color: appColor,
                      ),
                    ),
                  ],
                ),
                Icon(Icons.storefront,color:appColor ,size: width*0.08,),
              ],
            ),
          ),
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            FutureBuilder(
              future: orderProvider.getOrders(),
              builder: (BuildContext context, AsyncSnapshot<List<OrdersModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  print(snapshot.error.toString());
                  return Center(
                    child: Text(
                      "error fetching",
                    ),
                  );
                }
                return !snapshot.hasData||snapshot.data.length==0?
                Center(child:Text(translate("myorder.empty",),
                  style: TextStyle(color: appColor),)):
                Container(
                  height: height,
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.all(10),
                  child: ListView.builder(
                      itemCount: snapshot.data.length,
                      shrinkWrap: true,
                      reverse: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (_, index) {
                        return CardWidgetOrder(
                          context: context,
                          amount: snapshot.data[index].amount,
                          complete: snapshot.data[index].complete,
                          marketPhone: snapshot.data[index].marketPhone,
                          orderPrice: snapshot.data[index].orderPrice,
                          orderNumber: snapshot.data[index].orderNumber,
                          productList: snapshot.data[index].productsList,
                          date: snapshot.data[index].date,
                          uploadId: snapshot.data[index].uploadId,
                          order_date:snapshot.data[index].order_date ,
                          tax:snapshot.data[index].tax ,
                          shipping_fees:snapshot.data[index].shipping_fees ,
                          discount:snapshot.data[index].discount ,
                          location: snapshot.data[index].location,
                        );
                      }),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RaisedButton(
                    child: Text(translate("myorder.add_another_order"),
                      style: GoogleFonts.cairo(color: colorWhite,
                          fontWeight: FontWeight.bold,fontSize: width*0.05),),
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder:
                          (context)=>MyApp()));
                    },
                    color: appColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)
                    ),
                    padding: EdgeInsets.only(left: 20,right: 20,top: 6,bottom: 6),
                  ),
                  SizedBox(height: height*0.04,),
                ],
              )
            ),
          ],
        ),
      );
    }else{
      return PermissionDeniedWidget();
    }
  }
}

