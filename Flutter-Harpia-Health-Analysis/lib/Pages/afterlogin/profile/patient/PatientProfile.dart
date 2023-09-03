import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/profile/ProfilUpdatedCubit.dart';
import 'package:flutter_harpia_health_analysis/Product/CustomButton.dart';
import 'package:flutter_harpia_health_analysis/Product/CustomText.dart';
import 'package:flutter_harpia_health_analysis/core/ResponsiveDesign.dart';
import 'package:flutter_harpia_health_analysis/httprequest/HttpRequestPatient.dart';
import 'package:flutter_harpia_health_analysis/model/enums/diabetic/EnumDiabeticType.dart';
import '../../../../model/user/Doctor.dart';
import '../../../../model/user/Patient.dart';
import '../../../../util/ProductColor.dart';
import 'PatientUpdateProfilePage.dart';

class PatientProfile extends StatefulWidget {
  int patientId;

  PatientProfile({required this.patientId});

  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  late Patient patient;
  late Doctor doctor;
  bool isLoading = true;
  final String unknowData = "Unknown Data";
  final double spaceHeight = ResponsiveDesign.getScreenHeight() / 40;

  renderPage() {
    return BlocBuilder<ProfilUpdatedCubit, bool>(
      builder: (builder, isUpdated) {
        if (isUpdated) {
          isLoading = isUpdated;
          retrieveData();
          context.read<ProfilUpdatedCubit>().setFalse();
        }
        return Container();
      },
    );
  }

  void updateProfile() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PatientUpdateProfilePage(
                  patient: patient,
                )));
  }

  @override
  Widget build(BuildContext context) {
    retrieveData();
    return Scaffold(
      backgroundColor: ProductColor.bodyBackground,
      body: SingleChildScrollView(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.only(
                  left: ResponsiveDesign.getScreenWidth() / 20,
                  right: ResponsiveDesign.getCertainWidth() / 20,
                  top: ResponsiveDesign.getScreenHeight() / 20,
                ),
                child: Column(
                  children: [
                    renderPage(),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: ResponsiveDesign.getScreenHeight() / 25),
                      child: Column(children: [
                        CustomTextWithSizeBox(
                            space: spaceHeight,
                            text1: "Username",
                            text2: patient.username.isNotEmpty
                                ? patient.username
                                : unknowData),
                        CustomTextWithSizeBox(
                            space: spaceHeight,
                            text1: "Name",
                            text2: patient.name.isNotEmpty
                                ? patient.name
                                : unknowData),
                        CustomTextWithSizeBox(
                          space: spaceHeight,
                          text1: "Lastname",
                          text2: patient.lastname.isNotEmpty
                              ? patient.lastname
                              : unknowData,
                        ),
                        CustomTextWithSizeBox(
                            space: spaceHeight,
                            text1: "Doctor",
                            text2: doctor.lastname),
                        CustomTextWithSizeBox(
                            space: spaceHeight,
                            text1: "Diabetic Type",
                            text2: EnumDiabeticType.getTypeName(
                                patient.diabeticTypeId)),
                      ]),
                    ),
                    CustomButton(text: "Update Profile", action: updateProfile),
                    /*            _ProfileItem(
                      labelName: "Username",
                      labelValue: patient.username.isNotEmpty
                          ? patient.username
                          : unknowData,
                    ),
                    _ProfileItem(
                      labelName: "Name",
                      labelValue:
                          patient.name.isNotEmpty ? patient.name : unknowData,
                    ),
                    _ProfileItem(
                      labelName: "Lastname",
                      labelValue: patient.lastname.isNotEmpty
                          ? patient.lastname
                          : unknowData,
                    ),
                    _ProfileItem(
                        labelName: "Diabetic Type",
                        labelValue:
                            EnumDiabeticType.getTypeName(patient.diabeticTypeId)),
                    _ProfileItem(
                        labelName: "Doctor",
                        labelValue: "${doctor.name} ${doctor.lastname}"),*/

                    /*_UpdateProfileButton(
                      patient: patient,
                    )*/
                  ],
                ),
              ),
      ),
    );
  }

  retrieveData() async {
    if (isLoading) {
      patient = await HttpRequestPatient.findPatientById(widget.patientId);
      doctor =
          await HttpRequestPatient.findResponsibleDoctorByPatientId(patient.id);
      setState(() {
        isLoading = false;
      });
    }
  }
}

class _ProfileItem extends StatelessWidget {
  final String labelName;
  final String labelValue;
  final Color labelNameColor = ProductColor.black;
  final Color labelValueColor = ProductColor.black;
  final double fontSize = ResponsiveDesign.getCertainHeight() / 40;

  _ProfileItem({required this.labelName, required this.labelValue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: ResponsiveDesign.getScreenHeight() / 100),
      child: Row(
        children: [
          _ProfileItemDesignedText(
              color: labelNameColor, text: "$labelName : ", fontSize: fontSize),
          _ProfileItemDesignedText(
              color: labelValueColor, text: labelValue, fontSize: fontSize),
        ],
      ),
    );
  }
}

class CustomTextWithSizeBox extends StatelessWidget {
  final String text1;
  final String text2;
  final double space;

  CustomTextWithSizeBox(
      {required this.text1, required this.text2, required this.space});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(text1: text1, text2: text2),
        SizedBox(
          height: space,
        )
      ],
    );
  }
}

class _ProfileItemDesignedText extends StatelessWidget {
  final Color color;
  final String text;
  final double fontSize;

  const _ProfileItemDesignedText(
      {required this.color, required this.text, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize, color: color),
    );
  }
}
