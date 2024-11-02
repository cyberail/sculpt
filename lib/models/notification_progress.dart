// ignore_for_file: public_member_api_docs, sort_constructors_first
class NotificationProgress {
  final int maxProgress;
  final int progress;

  NotificationProgress(this.maxProgress, this.progress);

  NotificationProgress copyWith({
    int? maxProgress,
    int? progress,
  }) {
    return NotificationProgress(
      maxProgress ?? this.maxProgress,
      progress ?? this.progress,
    );
  }
}
