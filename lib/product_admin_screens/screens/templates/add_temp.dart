import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/config_app.dart';




class AddTemplate extends StatefulWidget {
  AddTemplate({super.key, required this.size});
  // ignore: prefer_typing_uninitialized_variables
  Size size;

  @override
  State<AddTemplate> createState() => _AddTemplateState();
}

class _AddTemplateState extends State<AddTemplate> {
  TextEditingController nameController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Padding(
        padding: const EdgeInsets.only(left: 100, right: 100),
        // ignore: prefer_const_constructors
        child: SizedBox(
          height: widget.size.height * 0.88,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    children: [
                      text('Add Template', color: Colors.black, size: 24, fontWeight: FontWeight.w600),
                    ],
                  ),
                  const SizedBox(
                    height: 37,
                  ),
                  text('a.   Enter the name of the template',
                      color: const Color(0xff333333), size: 20, fontWeight: FontWeight.w500),
                  // ignore: prefer_const_constructors
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                         Expanded(
                          flex: 5,
                          child: TextField(
                            controller: nameController,
                            // ignore: prefer_const_constructors
                            decoration: InputDecoration(
                              hintText: 'Type the name here',
                              hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xffD1D1D1)),
                              enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffD1D1D1))),
                            ),
                          ),
                        ),
                        Expanded(flex: 4, child: Container())
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 41,
                  ),
                  text('b.   Add cover image for your template.',
                      color: const Color(0xff333333), size: 20, fontWeight: FontWeight.w500),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, top: 19),
                    child: Image.asset('asset/images/uploadimage.png'),
                  ),
                  const SizedBox(
                    height: 41,
                  ),
                  text('c.   Add the categories in your template.',
                      color: const Color(0xff333333), size: 20, fontWeight: FontWeight.w500),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, top: 18),
                    child: Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Expanded(
                          flex: 5,
                          child: TextField(
                            // ignore: prefer_const_constructors
                            decoration: InputDecoration(
                              hintText: 'Type the category here...',
                              prefixIcon: Icon(
                                Icons.search,
                                color: Color(0xffA4A4A4),
                              ),
                              hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xffD1D1D1)),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xffD1D1D1))),
                            ),
                          ),
                        ),
                        Expanded(flex: 4, child: Container())
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                  right: 0,
                  bottom: 0,
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(border: Border.all(color: const Color(0xff333333))),
                        width: 188,
                        height: 48,
                        child: MaterialButton(
                            child: Center(
                              child: text('Discard', size: 18.0, fontWeight: FontWeight.w500, color: const Color(0xff171717)),
                            ),
                            onPressed: () {}),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      SizedBox(
                        width: 188,
                        height: 48,
                        child: MaterialButton(
                          onPressed: () {
                          addStandard(nameController.text.toLowerCase().toString(),context);

                          },
                          color: const Color(0xffCBE500),
                          child: Center(
                            child: text('Save', size: 18.0, fontWeight: FontWeight.w500, color: const Color(0xff171717)),
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }
     addStandard(String val, context) {
    var uuid = const Uuid().v4();
    FirebaseFirestore.instance.collection('Standards').doc(uuid).set({'name': val,
    'id':uuid}).then((value) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text("Insert"),
            content: Text("Successfuly Insert"),
          );
        },
      );
    });
  }
}
