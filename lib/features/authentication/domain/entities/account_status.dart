enum AccountStatus {
  pending,
  active,
  suspended,
  deleted,
}

extension AccountStatusExtension on AccountStatus {
  String get value {
    switch (this) {
      case AccountStatus.pending:
        return 'pending';
      case AccountStatus.active:
        return 'active';
      case AccountStatus.suspended:
        return 'suspended';
      case AccountStatus.deleted:
        return 'deleted';
    }
  }

  static AccountStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'active':
        return AccountStatus.active;
      case 'suspended':
        return AccountStatus.suspended;
      case 'deleted':
        return AccountStatus.deleted;
      default:
        return AccountStatus.pending;
    }
  }
}
