import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_harpia_health_analysis/core/ResponsiveDesign.dart';
import 'package:flutter_harpia_health_analysis/httprequest/HttpRequestAdmin.dart';
import '../../../../Product/CustomButton.dart';
import '../../../../Product/CustomText.dart';
import '../../../../model/user/Admin.dart';
import '../../../../util/ProductColor.dart';
import '../ProfilUpdatedCubit.dart';
import 'AdminUpdateProfilePage.dart';

class AdminProfile extends StatefulWidget {
  int adminId;

  AdminProfile({required this.adminId});

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  late Admin admin;
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
            builder: (context) => AdminUpdateProfilePage(admin: admin)));
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
                  CustomTextWithSizeBox(
                      space: spaceHeight,
                      text1: "Username",
                      text2: admin.username.isNotEmpty
                          ? admin.username
                          : unknowData),
                  CustomTextWithSizeBox(
                      space: spaceHeight,
                      text1: "Username",
                      text2: admin.name.isNotEmpty ? admin.name : unknowData),
                  CustomTextWithSizeBox(
                      space: spaceHeight,
                      text1: "Username",
                      text2: admin.lastname.isNotEmpty
                          ? admin.lastname
                          : unknowData),
                  /*  _ProfileItem(
                    labelName: "Username",
                    labelValue:
                        admin.username.isNotEmpty ? admin.username : unknowData,
                  ),
                  _ProfileItem(
                    labelName: "Name",
                    labelValue: admin.name.isNotEmpty ? admin.name : unknowData,
                  ),
                  _ProfileItem(
                    labelName: "Lastname",
                    labelValue:
                        admin.lastname.isNotEmpty ? admin.lastname : unknowData,
                  ),*/
                  // _UpdateProfileButton(admin: admin),
                  CustomButton(text: "Update Profile", action: updateProfile),
                ],
              ),
            ),
    );
  }

  retrieveData() async {
    if (isLoading) {
      admin = await HttpRequestAdmin.findById(widget.adminId);
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
