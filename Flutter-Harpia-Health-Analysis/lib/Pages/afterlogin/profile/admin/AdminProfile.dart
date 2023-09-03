import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_harpia_health_analysis/core/ResponsiveDesign.dart';
import 'package:flutter_harpia_health_analysis/httprequest/HttpRequestAdmin.dart';
import 'package:flutter_harpia_health_analysis/httprequest/HttpRequestAdmin.dart';
import 'package:flutter_harpia_health_analysis/httprequest/HttpRequestUser.dart';
import 'package:flutter_harpia_health_analysis/util/PermissionUtils.dart';
import '../../../../model/user/Admin.dart';
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
                  _ProfileItem(
                    labelName: "Name",
                    labelValue: admin.name.isNotEmpty ? admin.name : unknowData,
                  ),
                  _ProfileItem(
                    labelName: "Lastname",
                    labelValue:
                        admin.lastname.isNotEmpty ? admin.lastname : unknowData,
                  ),
                  PermissionUtils.letRunForAdmin()
                      ? _ProfileItem(
                          labelName: "Username",
                          labelValue: admin.username.isNotEmpty
                              ? admin.username
                              : unknowData,
                        )
                      : Container(),
                  _UpdateProfileButton(admin: admin),
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

class _UpdateProfileButton extends StatelessWidget {
  late final Admin admin;

  _UpdateProfileButton({required this.admin});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AdminUpdateProfilePage(admin: admin)));
        },
        child: const Text("Update Profile"));
  }
}
