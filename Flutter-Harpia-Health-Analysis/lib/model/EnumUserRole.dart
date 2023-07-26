enum EnumUserRole {
  ADMIN(roleId: 1),
  HEALTHCARE_PERSONEL(roleId: 2),
  PATIENT(roleId: 3);

  final int roleId;
  const EnumUserRole({required this.roleId});
}
