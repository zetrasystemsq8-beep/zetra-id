enum AccountStatus {
  pending('pending'),
  active('active'),
  suspended('suspended'),
  deleted('deleted');

  final String value;

  const AccountStatus(this.value);

  static AccountStatus fromString(String value) {
    return AccountStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => AccountStatus.pending,
    );
  }

  String toDisplayString() {
    return value[0].toUpperCase() + value.substring(1);
  }
}
