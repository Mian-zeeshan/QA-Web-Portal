import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qa_application/customer_screens/add_branch_admin/provider/branch_provider.dart';
import 'package:qa_application/globel_provider/add_user_provider.dart';
import 'package:qa_application/globel_provider/globel_provider.dart';
import 'package:qa_application/globel_components/templates_components/template_component_provider/template_component_provider.dart';
import 'package:qa_application/globel_provider/edit_question_provider.dart';

import '../branch_admin_screens/assignment_template/assign_template.dart';
import '../branch_admin_screens/branch_admin_templates/customer_admin_templates/customer_admin_add_question.dart';
import '../branch_admin_screens/branch_admin_templates/customer_admin_templates/customer_admin_template_screen.dart';
import '../branch_admin_screens/branch_admin_templates/personal_templates/branch_admin_template_screen.dart';
import '../branch_admin_screens/branch_admin_templates/personal_templates/personal_add_question.dart';
import '../branch_admin_screens/branch_admin_user/branch_admin_user.dart';
import '../branch_admin_screens/provider/branch_admin_provider.dart';
import '../customer_screens/add_branch_admin/add_branch_admin.dart';
import '../customer_screens/branches/branch_screen.dart';

import '../customer_screens/customer_templates/admin_templates/add_question.dart';
import '../customer_screens/customer_templates/admin_templates/customer_templates.dart';
import '../customer_screens/customer_templates/personal_template/personal_add_question.dart';
import '../customer_screens/customer_templates/personal_template/template_screen.dart';
import '../product_admin_screens/add_customer/customer_screen.dart';
import '../product_admin_screens/screens/add_admin_user/user_page.dart';
import '../globel_provider/role_provider.dart';

import '../product_admin_screens/screens/templates/add_question.dart';
import '../product_admin_screens/screens/templates/add_temp.dart';
import '../product_admin_screens/screens/templates/template_screen.dart';
import '../product_admin_screens/screens/templates_criteria/criteria.dart';
import 'constant/color_constant.dart';

class AppConfig {
  // ignore: prefer_typing_uninitialized_variables
  var size;
  AppConfig({required this.size});
  late var productAdminPagesList = [
    Template(
      size: size,
    ),
    AddTemplate(
      size: size,
    ),
    AddQuestion(
      size: size,
    ),
    UserScreen(
      size: size,
    ),
    CustomerScreen(
      size: size,
    ),
    CriteriaTemplates(
      size: size,
    )
  ];

  late var customerAdminPageList = [
    BranchScreen(
      size: size,
    ),
    BranchAdmin(
      size: size,
    ),
    CustomerTemplate(size: size),
    CustomerAddQuestion(size: size),
    PersonalTemplateScreen(size: size),
    PersonalAddQuestion(size: size),
  ];
  late var branchAdminPageList = [
    CustomerAdminTemplateScreen(size: size),
    CustomerAdminAddQuestion(size: size),
    BranchAdminPersonalTemplateScreen(size: size),
    BranchAdminPersonalAddQuestion(size: size),
    BranchAdminUser(size: size),
    AssignTemplate(
      size: size,
    )
  ];




  static Widget inspectionUserDropdownlist(context) {
    var branchProvider = Provider.of<BranchProvider>(context, listen: false);
    // final provider = Provider.of<screenprovider>(context);
    return Container(
      // width: 200,
      // height: 50,
      color: const Color(0xFFF2F1F1),

      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .where('userRole', isEqualTo: 'brancAdminUser')
            .where('branchid', isEqualTo: branchProvider.branchId.toString())
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (snapshot.hasData == false) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          return Consumer<BranchAdminProvider>(
            builder: (context, value, child) {
              return DropdownButtonFormField<String>(
                dropdownColor: Colors.white,
                isDense: true,
                hint: text('Choose',
                    size: 16.0, fontfamily: 'SofiaPro', fontWeight: FontWeight.w400, color: Colors.black),
                value: value.inspectionUserName,
                icon: const Icon(
                  Icons.arrow_downward,
                  color: Colors.black,
                ),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'This Field Required*';
                  }
                  return null;
                },
                onChanged: (String? newValue) {
                  value.setinspectionUserName(newValue!);
                },
                items: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

                  return DropdownMenuItem<String>(
                    value: data['userEmail'],
                    child: Text(
                      data['userEmail'],
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
              );
            },
          );
        },
      ),
    );
  }

  static Widget templateDropdownlist(context) {
    var branchProvider = Provider.of<BranchProvider>(context, listen: false);
    // final provider = Provider.of<screenprovider>(context);
    return Container(
      // width: 200,
      // height: 50,
      color: const Color(0xFFF2F1F1),

      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('BranchAdminStandardsCopy')
            .where('branchid', isEqualTo: branchProvider.branchId
                // loginProvider.crunntUserId.toString()
                )
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (snapshot.hasData == false) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          return Consumer<BranchAdminProvider>(
            builder: (context, value, child) {
              return DropdownButtonFormField<String>(
                dropdownColor: Colors.white,
                isDense: true,
                hint: text('Choose',
                    size: 16.0, fontfamily: 'SofiaPro', fontWeight: FontWeight.w400, color: Colors.black),
                value: value.templateName,
                icon: const Icon(
                  Icons.arrow_downward,
                  color: Colors.black,
                ),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'This Field Required*';
                  }
                  return null;
                },
                onChanged: (String? newValue) {
                  value.settemplateName(newValue!);
                },
                items: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

                  return DropdownMenuItem<String>(
                    value: data['name'],
                    child: Text(
                      data['name'],
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
              );
            },
          );
        },
      ),
    );
  }

  static Widget rolesList(context) {
    // final provider = Provider.of<screenprovider>(context);
    return Container(
      // width: 200,
      // height: 50,
      color: const Color(0xFFF2F1F1),

      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Roles').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (snapshot.hasData == false) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          return Consumer<RoleProvider>(
            builder: (context, value, child) {
              return DropdownButtonFormField<String>(
                dropdownColor: Colors.white,
                isDense: true,
                hint: text('Choose',
                    size: 16.0, fontfamily: 'SofiaPro', fontWeight: FontWeight.w400, color: Colors.black),
                value: value.roleListValue,
                icon: const Icon(
                  Icons.arrow_downward,
                  color: Colors.black,
                ),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'This Field Required*';
                  }
                  return null;
                },
                onChanged: (String? newValue) {
                  value.setroleListValue(newValue!);
                },
                items: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

                  return DropdownMenuItem<String>(
                    value: data['role_name'],
                    child: Text(
                      data['role_name'],
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
              );
            },
          );
        },
      ),
    );
  }

  static Widget customerList(context) {
    return Container(
      // width: 200,
      // height: 50,
      color: const Color(0xFFF2F1F1),

      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Customers').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (snapshot.hasData == false) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          return Consumer<AddUserProvider>(
            builder: (context, value, child) {
              return DropdownButtonFormField<String>(
                dropdownColor: Colors.white,
                isDense: true,
                hint: text('Choose',
                    size: 16.0, fontfamily: 'SofiaPro', fontWeight: FontWeight.w400, color: Colors.black),
                value: value.customerListValue,
                icon: const Icon(
                  Icons.arrow_downward,
                  color: Colors.black,
                ),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'This Field Required*';
                  }
                  return null;
                },
                onChanged: (String? newValue) {
                  // await   getcustomerName(newValue!,context);
                  value.setcustomerListValue(newValue!);
                },
                items: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                  // value.setcustomerId(data['customer_id'].toString());

                  return DropdownMenuItem<String>(
                    value: data['customer_name'],
                    child: Text(
                      data['customer_name'],
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
              );
            },
          );
        },
      ),
    );
  }

  static Future<Widget> messageDialogBox(BuildContext context, String title, String message) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
        );
      },
    );
  }

  static Widget branchList(context) {
    return Container(
      // width: 200,
      // height: 50,
      color: Colors.black,

      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Branch')
            .where('customer_id', isEqualTo: 'FZIGRZ1O4cbKHrv1VnXXL0OH0Ub2'
                // loginProvider.crunntUserId.toString()
                )
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (snapshot.hasData == false) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          return Consumer<BranchProvider>(
            builder: (context, value, child) {
              return DropdownButtonFormField<String>(
                isDense: true,
                hint: const Text('Choose'),
                value: value.branchName,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'This Field Required*';
                  }
                  return null;
                },
                onChanged: (String? newValue) {
                  value.setBranchName(newValue!);
                },
                items: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                  String id = data['branch_id'];
                  value.setBranchId(id);
                  return DropdownMenuItem<String>(
                    value: data['branch_name'],
                    child: Text(data['branch_name']),
                  );
                }).toList(),
              );
            },
          );
        },
      ),
    );
  }

  static Widget dataTypesListComponent(context) {
    // final provider = Provider.of<screenprovider>(context);
    return Container(
      // width: 200,
      // height: 50,
      color: const Color(0xFFF2F1F1),

      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('CheckListDataTypes').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (snapshot.hasData == false) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          return Consumer<TemplateComponentProvider>(
            builder: (context, value, child) {
              return DropdownButtonFormField<String>(
                dropdownColor: Colors.white,
                isDense: true,
                hint: text('Choose',
                    size: 16.0, fontfamily: 'SofiaPro', fontWeight: FontWeight.w400, color: Colors.black),
                value: value.dataTypeValue,
                icon: const Icon(
                  Icons.arrow_downward,
                  color: Colors.black,
                ),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.black),

                // validator: (value) {
                //   if(value?.isEmpty ?? true){
                //     return'This Field Required*';
                //   }
                //   return null;
                // },
                onChanged: (String? newValue) {
                  value.setDataTypeValue(newValue!);
                },
                items: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

                  return DropdownMenuItem<String>(
                    value: data['name'],
                    child: Text(
                      data['name'],
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
              );
            },
          );
        },
      ),
    );
  }

  static Widget dataTypesDropDownWidget(context) {
     final provider = Provider.of<EditQuestionProvider>(context);
    return Container(
      // width: 200,
      // height: 50,
      color: const Color(0xFFF2F1F1),

      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('CheckListDataTypes').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (snapshot.hasData == false) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          return Consumer<TemplateComponentProvider>(
            builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.only(left: 30,right: 30),
                child: DropdownButtonFormField<String>(
                  dropdownColor: Colors.white,
              
                  isDense: true,
                  hint: text('Choose',
                      size: 16.0, fontfamily: 'SofiaPro', fontWeight: FontWeight.w400, color: Colors.black),
                  value: value.dataTypeValue,
                  icon: const Icon(
                    Icons.arrow_downward_outlined,
                    color: Colors.black,
                  ),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(enabledBorder: InputBorder.none),
                  // validator: (value) {
                  //   if(value?.isEmpty ?? true){
                  //     return'This Field Required*';
                  //   }
                  //   return null;
                  // },
                  onChanged: (String? newValue) {
                    // provider.setnumericTypeQuestionOptionsLength(0);
                    // provider.setoptionsTypeQuestionOptionsLength(0);

                    value.setDataTypeValue(newValue!);
                  },
                  items: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              
                    return DropdownMenuItem<String>(
                      value: data['name'],
                      child: Row(
                        children: [
                          data['name'] == 'Options'
                              ? Image.asset(
                                  "asset/images/newoption.png",
                                )
                              : data['name'] == 'Boolean'
                                  ? Image.asset(
                                      "asset/images/newboolean.png",
                                    )
                                  : Image.asset(
                                      "asset/images/numeric.png",
                                    ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            data['name'],
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          );
        },
      ),
    );
  }


}

//custom text widget component
Text text(
  text, {
  color = Colors.black,
  size = 14.0,
  fontWeight = FontWeight.normal,
  fontfamily = '',
  maxLines = 2,
}) {
  return Text(
    text,
    maxLines: 2,
    softWrap: false,
    style: TextStyle(color: color, fontSize: size, fontWeight: fontWeight, fontFamily: fontfamily),
  );
}

Widget textField(
  String hint,
  controller, {
  maxLines = 1,
  isPassword = false,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(0),
    child: TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return hint;
        }
        return null;
      },
      style: TextStyle(color: Colors.white),
      obscureText: isPassword,
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        fillColor: secondaryColor,
        filled: true,
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
      ),
    ),
  );
}

Widget textFieldForDialogBox(
  String hint,
  controller, {
  maxLines = 1,
  isPassword = false,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(0),
    child: TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return hint;
        }
        return null;
      },
      style: TextStyle(color: Colors.black),
      obscureText: isPassword,
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        fillColor: Color(0xFFF2F1F1),
        hintText: hint,
        hintStyle:
            TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: Color(0xFFABAAAA), fontFamily: 'SofiaPro'),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFF2F1F1))),
      ),
    ),
  );
}

showSnackBar(context, message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: text(
    message,
  )));
}
