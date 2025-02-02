enum EnumUserProp {
  ID(name: "id"),
  ROLE_ID(name: "roleId"),
  NAME(name: "name"),
  LASTNAME(name: "lastname"),
  USERNAME(name: "username"),
  PASSWORD(name: "password"),
  TOKEN(name: "token");

  final String name;

  const EnumUserProp({required this.name});
}
