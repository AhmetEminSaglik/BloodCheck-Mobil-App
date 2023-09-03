import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_harpia_health_analysis/Product/CustomButton.dart';
import 'package:flutter_harpia_health_analysis/core/ResponsiveDesign.dart';
import 'package:flutter_harpia_health_analysis/httprequest/HttpRequestDoctor.dart';
import 'package:flutter_harpia_health_analysis/util/PermissionUtils.dart';
import '../../../../Product/CustomText.dart';
import '../../../../model/user/Doctor.dart';
import '../../../../util/ProductColor.dart';
import '../ProfilUpdatedCubit.dart';
import 'DoctorUpdateProfilePage.dart';

class DoctorProfile extends StatefulWidget {
  int doctorId;

  DoctorProfile({required this.doctorId});

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
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
            builder: (context) => DoctorUpdateProfilePage(doctor: doctor)));
  }

  @override
  Widget build(BuildContext context) {
    retrieveData();
    return Scaffold(
      backgroundColor: ProductColor.bodyBackground,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.only(
                left: ResponsiveDesign.getScreenWidth() / 20,
                right: ResponsiveDesign.getCertainWidth() / 20,
                top: ResponsiveDesign.getScreenHeight() / 40,
              ),
              child: Column(
                children: [
                  renderPage(),
                  PermissionUtils.letRunForDoctor()
                      ? CustomTextWithSizeBox(
                          space: spaceHeight,
                          text1: "Username",
                          text2: doctor.username.isNotEmpty
                              ? doctor.username
                              : unknowData,
                        )
                      : Container(),
                  CustomTextWithSizeBox(
                      space: spaceHeight,
                      text1: "Name",
                      text2: doctor.name.isNotEmpty ? doctor.name : unknowData),
                  CustomTextWithSizeBox(
                    space: spaceHeight,
                    text1: "Lastname",
                    text2: doctor.lastname.isNotEmpty
                        ? doctor.lastname
                        : unknowData,
                  ),
                  CustomTextWithSizeBox(
                      space: spaceHeight,
                      text1: "Specialization",
                      text2: doctor.specialization),
                  CustomTextWithSizeBox(
                      space: spaceHeight,
                      text1: "Graduate",
                      text2: doctor.graduate),
                  PermissionUtils.letRunForDoctor()
                      ? CustomButton(
                          action: () {
                            updateProfile();
                          },
                          text: "Update Profile",
                        )
                      : Container(),
                  /* ? _ProfileItem(
                          labelName: "Username",
                          labelValue: doctor.username.isNotEmpty
                              ? doctor.username
                              : unknowData,
                        )
                      : Container(),
                  _ProfileItem(
                    labelName: "Name",
                    labelValue:
                        doctor.name.isNotEmpty ? doctor.name : unknowData,
                  ),
                  _ProfileItem(
                    labelName: "Lastname",
                    labelValue: doctor.lastname.isNotEmpty
                        ? doctor.lastname
                        : unknowData,
                  ),
                  _ProfileItem(
                    labelName: "Specialization",
                    labelValue: doctor.specialization.isNotEmpty
                        ? doctor.specialization
                        : unknowData,
                  ),
                  _ProfileItem(
                    labelName: "Graduate",
                    labelValue: doctor.graduate.isNotEmpty
                        ? doctor.graduate
                        : unknowData,
                  ),*/
                ],
              ),
            ),
    );
  }

  retrieveData() async {
    if (isLoading) {
      doctor = await HttpRequestDoctor.findById(widget.doctorId);
      setState(() {
        isLoading = false;
      });
    }
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
/*
class _UpdateProfileButton extends StatelessWidget {
  late final Doctor doctor;

  _UpdateProfileButton({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      DoctorUpdateProfilePage(doctor: doctor)));
        },
        child: const Text("Update Profile"));
  }
}*/
