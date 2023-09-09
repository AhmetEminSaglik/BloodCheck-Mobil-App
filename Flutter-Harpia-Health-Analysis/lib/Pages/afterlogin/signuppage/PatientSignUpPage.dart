import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/httprequest/HttpRequestPatient.dart';
import 'package:flutter_harpia_health_analysis/model/userrole/EnumUserRole.dart';
import 'package:flutter_harpia_health_analysis/util/CustomAlertDialog.dart';
import '../../../Product/FormCustomInput.dart';
import '../../../business/factory/UserFactory.dart';
import '../../../core/ResponsiveDesign.dart';
import '../../../httprequest/HttpRequestDoctor.dart';
import '../../../httprequest/ResponseEntity.dart';
import '../../../model/enums/diabetic/EnumDiabeticType.dart';
import '../../../model/user/Doctor.dart';
import '../../../model/user/Patient.dart';
import '../../../model/user/User.dart';
import '../../../util/CustomLog.dart';
import '../../../util/ProductColor.dart';
import 'dart:convert';

CustomLog log = CustomLog(className: "PatientSignUpPage");

class PatientSignUpPage extends StatefulWidget {
  const PatientSignUpPage({Key? key}) : super(key: key);

  @override
  State<PatientSignUpPage> createState() => _PatientSignUpPageState();
}

final _formKey = GlobalKey<FormState>();

class DoctorPicklistItem {
  int index;
  int id;
  String name;

  DoctorPicklistItem(
      {required this.index, required this.id, required this.name});

  @override
  String toString() {
    return 'DoctorPicklistItem{index: $index, id: $id, name: $name}';
  }
}

class _PatientSignUpPageState extends State<PatientSignUpPage> {
  TextEditingController tfUsername = TextEditingController();
  TextEditingController tfPassword = TextEditingController();
  TextEditingController tfName = TextEditingController();
  TextEditingController tfLastname = TextEditingController();

  _DiabeticTypeDropdownMenuButton diabeticTypeDropDownMenu =
      _DiabeticTypeDropdownMenuButton();
  _DoctorDropdownMenuButton doctorDropDownMenu = _DoctorDropdownMenuButton();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProductColor.bodyBackground,
      body: Padding(
        padding: EdgeInsets.only(
            left: ResponsiveDesign.getScreenWidth() / 25,
            right: ResponsiveDesign.getScreenWidth() / 25,
            top: ResponsiveDesign.getScreenWidth() / 10,
            bottom: ResponsiveDesign.getScreenWidth() / 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    diabeticTypeDropDownMenu,
                    doctorDropDownMenu,
                    FormInputTextField(
                      hintText: "Username",
                      controller: tfUsername,
                      obscure: false,
                      compulsoryArea: false,
                    ),
                    FormInputTextField(
                      hintText: "Password",
                      controller: tfPassword,
                      obscure: true,
                      compulsoryArea: false,
                    ),
                    FormInputTextField(
                      hintText: "Name",
                      controller: tfName,
                      obscure: false,
                      compulsoryArea: false,
                    ),
                    FormInputTextField(
                      hintText: "Lastname",
                      controller: tfLastname,
                      obscure: false,
                      compulsoryArea: false,
                    ),
                    _SignUpButton(
                      formKey: _formKey,
                      tfUsername: tfUsername,
                      tfPassword: tfPassword,
                      tfName: tfName,
                      tfLastname: tfLastname,
                      selectedDiabeticType: diabeticTypeDropDownMenu,
                      selectedDoctorId: doctorDropDownMenu,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _DoctorDropdownMenuButton extends StatefulWidget {
  int selectedDoctorId = 0;
  List<Doctor> doctorList = [];
  List<DoctorPicklistItem> items = [
    DoctorPicklistItem(index: 0, id: 0, name: "Select Doctor")
  ];

  @override
  State<_DoctorDropdownMenuButton> createState() =>
      _DoctorDropdownMenuButtonState();
}

class _DoctorDropdownMenuButtonState extends State<_DoctorDropdownMenuButton> {
  @override
  void initState() {
    super.initState();
    retriveDoctorList();
  }

  void retriveDoctorList() async {
    // isLoading = true;
    setState(() {});
    var resp = await HttpRequestDoctor.getDoctorList();
    // isLoading = false;
    setState(() {
      widget.doctorList = resp;
      int index = 0;
      resp.forEach((element) {
        index++;
        widget.items.add(
          DoctorPicklistItem(
              index: index,
              id: element.id,
              name: "${element.name} ${element.lastname}"),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ResponsiveDesign.getScreenWidth() / 1.5,
      child: Container(
        margin:
            EdgeInsets.only(bottom: ResponsiveDesign.getScreenHeight() / 25),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: Container(
          color: ProductColor.white,
          child: Padding(
            padding: EdgeInsets.only(
                left: ResponsiveDesign.getScreenWidth() / 30,
                right: ResponsiveDesign.getScreenWidth() / 30),
            child: Center(
              child: DropdownButtonHideUnderline(
                child: DropdownButtonFormField<int>(
                  // style: ButtonStyle(backgroundColor: Colors.red),
                  decoration: InputDecoration(enabledBorder: InputBorder.none),
                  iconSize: ResponsiveDesign.getScreenWidth() / 15,
                  value: widget.selectedDoctorId,
                  items: widget.items
                      .map((e) => DropdownMenuItem(
                            value: e.index,
                            child: Text(e.name,
                                style: TextStyle(
                                    fontSize:
                                        ResponsiveDesign.getScreenWidth() /
                                            23)),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      widget.selectedDoctorId = value!;
                      if (widget.selectedDoctorId > 0) {
                        validateItemWithAlertDialog(
                            selectedItemIndex: widget.selectedDoctorId);
                      }
                    });
                  },
                  validator: (data) {
                    if (data == null || data == 0) {
                      return "Select Doctor";
                    }

                    return null;
                  },
                  isExpanded: true,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void validateItemWithAlertDialog({required int selectedItemIndex}) async {
    var result = await showDialog(
        context: context,
        builder: (builder) => CustomAlertDialog.getAlertDialogValidateProcess(
            context: context,
            title: "Doctor Validation",
            msg: "Are you sure you want to select",
            selectedItemName: widget.items[selectedItemIndex].name,
            roleId: EnumUserRole.DOCTOR.roleId));
    if (result == null || !result) {
      setState(() {
        widget.selectedDoctorId = 0;
      });
    }
    // ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar.getSnackBar("result : $isConfirmed"));
  }
}

class _DiabeticTypeDropdownMenuButton extends StatefulWidget {
  int selectedDiabeticTypeValue = 0;

  _DiabeticTypeDropdownMenuButton();

  @override
  State<_DiabeticTypeDropdownMenuButton> createState() =>
      _DiabeticTypeDropdownMenuButtonState();
}

class _DiabeticTypeDropdownMenuButtonState
    extends State<_DiabeticTypeDropdownMenuButton> {
  final items = [
    0,
    EnumDiabeticType.TIP_1.id,
    EnumDiabeticType.TIP_2.id,
    EnumDiabeticType.HIPOGLISEMI.id,
    EnumDiabeticType.HIPERGLISEMI.id
  ];

  DropdownMenuItem<int> buildMenuItem(int id) => DropdownMenuItem(
      value: id,
      child: Text(
        id > 0 ? EnumDiabeticType.getTypeName(id) : "Select Diabetic Type",
        style: TextStyle(fontSize: ResponsiveDesign.getScreenWidth() / 23),
      ));

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ResponsiveDesign.getScreenWidth() / 1.5,
      child: Container(
        margin:
            EdgeInsets.only(bottom: ResponsiveDesign.getScreenHeight() / 25),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: Container(
          color: ProductColor.white,
          child: Padding(
            padding: EdgeInsets.only(
                left: ResponsiveDesign.getScreenWidth() / 30,
                right: ResponsiveDesign.getScreenWidth() / 30),
            child: Center(
              child: DropdownButtonHideUnderline(
                child: DropdownButtonFormField<int>(
                  decoration: InputDecoration(enabledBorder: InputBorder.none),
                  iconSize: ResponsiveDesign.getScreenWidth() / 15,
                  value: widget.selectedDiabeticTypeValue,
                  items: items.map(buildMenuItem).toList(),
                  onChanged: (value) {
                    setState(() {
                      widget.selectedDiabeticTypeValue = value!;
                      if (widget.selectedDiabeticTypeValue > 0) {
                        validateItemWithAlertDialog(
                            selectedItemIndex:
                                widget.selectedDiabeticTypeValue);
                      }
                    });
                  },
                  validator: (data) {
                    if (data == null || data == 0) {
                      return "Select Diabetic Type";
                    }

                    return null;
                  },
                  isExpanded: true,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void validateItemWithAlertDialog({required int selectedItemIndex}) async {
    log.info("SELECTED ITEM : ${widget.selectedDiabeticTypeValue}");
    var result = await showDialog(
        context: context,
        builder: (builder) => CustomAlertDialog.getAlertDialogValidateProcess(
            context: context,
            title: "Diabetic Type Validation",
            msg: "Are you sure you want to select",
            selectedItemName: EnumDiabeticType.getTypeName(selectedItemIndex),
            roleId: EnumUserRole.PATIENT.roleId));
    if (result == null || !result) {
      /*ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackBar.getSnackBar("result : $result"));*/

      setState(() {
        widget.selectedDiabeticTypeValue = 0;
      });
    }
    log.info("SELECTED NO ANSWER  ITEM : ${widget.selectedDiabeticTypeValue}");
  }
}

class _SignUpButton extends StatelessWidget {
  final TextEditingController tfUsername, tfPassword, tfName, tfLastname;
  final _DiabeticTypeDropdownMenuButton selectedDiabeticType;
  final _DoctorDropdownMenuButton selectedDoctorId;
  GlobalKey<FormState> formKey;

  _SignUpButton(
      {required this.formKey,
      required this.tfUsername,
      required this.tfPassword,
      required this.tfName,
      required this.tfLastname,
      required this.selectedDiabeticType,
      required this.selectedDoctorId}); //({super.key /*,required this.screenInfo*/});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: ResponsiveDesign.getScreenWidth() / 1.5,
        height: ResponsiveDesign.getScreenHeight() / 15,
        child: ElevatedButton(
            onPressed: () {
              _signUpProcess(context, selectedDiabeticType, selectedDoctorId);
            },
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateColor.resolveWith((states) => Colors.pink),
                foregroundColor:
                    MaterialStateColor.resolveWith((states) => Colors.white)),
            child: Text("Sign Up",
                style: TextStyle(
                    fontSize: ResponsiveDesign.getScreenWidth() / 20))));
  }

  void resetPageInputs(
      List<TextEditingController> list,
      _DoctorDropdownMenuButton doctorDropDown,
      _DiabeticTypeDropdownMenuButton diabeticDropDown) {
    list.forEach((e) => e.text = "");
    // doctorDropDown.selectedDoctorId = 0;
    // diabeticDropDown.selectedDiabeticTypeValue = 0;
  }

  void _signUpProcess(
      BuildContext context,
      _DiabeticTypeDropdownMenuButton diabeticTypeDropDownMenu,
      _DoctorDropdownMenuButton doctorDropdownMenu) async {
    bool controlResult = formKey.currentState!.validate();
    if (controlResult) {
      String username = tfUsername.text;
      String pass = tfPassword.text;
      String name = tfName.text;
      String lastname = tfLastname.text;
      int diabeticTypeId = diabeticTypeDropDownMenu.selectedDiabeticTypeValue;
      int doctorId =
          doctorDropdownMenu.items[doctorDropdownMenu.selectedDoctorId].id;

      var request = HttpRequestPatient();
      Patient patient = Patient(
          id: 0,
          roleId: EnumUserRole.PATIENT.roleId,
          name: name,
          lastname: lastname,
          username: username,
          password: pass,
          diabeticTypeId: diabeticTypeId,
          doctorId: doctorId);
      request.signUp(patient).then((resp) async {
        // debugPrint(resp.body);
        Map<String, dynamic> jsonData = json.decode(resp.body);
        // log.info("res.body : ${resp.body}");
        var respEntity = ResponseEntity.fromJson(jsonData);
        if (!respEntity.success) {
          showAlertDialogInvalidUsername(
              context: context, msg: respEntity.message);
        } else {
          User user = UserFactory.createUser(respEntity.data);
          showAlertDialogDoctorSignUpSuccessfully(
              context: context, msg: respEntity.message);
          List<TextEditingController> list = [
            tfUsername,
            tfPassword,
            tfName,
            tfLastname
          ];
          resetPageInputs(list, doctorDropdownMenu, diabeticTypeDropDownMenu);
        }
      });
    }
  }

  void showAlertDialogInvalidUsername(
      {required BuildContext context, required String msg}) {
    showDialog(
        context: context,
        builder: (builder) => CustomAlertDialog.getAlertDialogUserSignUp(
            success: false,
            context: context,
            title: "Sign-Up",
            subTitle: "Failed :",
            msg: msg,
            roleId: EnumUserRole.PATIENT.roleId));
  }

  void showAlertDialogDoctorSignUpSuccessfully(
      {required BuildContext context, required String msg}) {
    showDialog(
        context: context,
        builder: (builder) => CustomAlertDialog.getAlertDialogUserSignUp(
            success: true,
            context: context,
            title: "Sign-Up",
            subTitle: "Successfull",
            msg: msg,
            roleId: EnumUserRole.PATIENT.roleId));
  }
}
