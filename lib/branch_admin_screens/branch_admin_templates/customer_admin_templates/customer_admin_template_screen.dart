import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/config_app.dart';
import '../../../customer_screens/provider/customer_provider.dart';
import '../../../globel_provider/globel_provider.dart';
import '../../../product_admin_screens/screens/Templates/temp_provider/temp_provider.dart';

// ignore: must_be_immutable
class CustomerAdminTemplateScreen extends StatefulWidget {
  CustomerAdminTemplateScreen({super.key, required this.size});
  // ignore: prefer_typing_uninitialized_variables
  Size size;

  @override
  State<CustomerAdminTemplateScreen> createState() => _CustomerAdminTemplateScreenState();
}

class _CustomerAdminTemplateScreenState extends State<CustomerAdminTemplateScreen> {
  @override
  Widget build(BuildContext context) {
    var customerProvider = Provider.of<CustomerProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(left: 100, top: 39, right: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              text('Templates', color: Colors.black, size: 32, fontWeight: FontWeight.w600),
            ],
          ),
          // ignore: prefer_const_constructors
          SizedBox(
            height: 63,
          ),
          SizedBox(
              width: widget.size.width,
              height: widget.size.height * 0.7,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('StandardsCopy')
                    .where('customerId', isEqualTo: customerProvider.customerId)
                    .snapshots(),
                builder: (BuildContext contex, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CupertinoActivityIndicator());
                  } else if (snapshot.hasData == false) {
                    return const Center(
                      child: Text(
                        'Data not found',
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  } else {
                    return GridView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return ItemTile(index, snapshot.data!.docs[index]['name'].toString(),
                            snapshot.data!.docs[index]['id'].toString());
                      },
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 20, mainAxisSpacing: 10, crossAxisCount: 5, mainAxisExtent: 240),
                    );
                  }
                },
              ))
        ],
      ),
    );
  }
}

class ItemTile extends StatelessWidget {
  final int index;
  final String tempName;
  final String tempId;

  const ItemTile(this.index, this.tempName, this.tempId, {super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<GlobelProvider>(context);
    var tempProvider = Provider.of<TempProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // itemNo == 0
        //       ? Expanded(
        //         child: Container(
        //             height: 240,
        //             color: Colors.white,
        //             // child:Center(child: Icon(Icons.add,color: Colors.black,)),
        //             child: Image.asset(
        //               "asset/images/Vector.png",
        //             ),
        //           ),
        //       )
        //       :
        Expanded(
          child: InkWell(
            onTap: () {
              provider.setPageIndex(1);
              provider.setmodelDataIndex(index);
              tempProvider.setstdName(tempName);
              tempProvider.setstdId(tempId);
            },
            child: Container(
              color: Colors.white,
              height: 240,
              child: Center(
                  child: Image.asset(
                "asset/images/haccp.png",
                fit: BoxFit.cover,
              )),
            ),
          ),
        ),

        text(tempName, size: 20, color: Colors.black)
        // text(myModel[index].title,size: 20,color: Colors.black)
      ],
    );
  }
}
