class AppState{
  String mode;
  bool authMode;
  String userName;
  int userId;
  int openProjectId;
  AppState({
    this.mode = "",
    this.authMode = false,
    this.userName = "",
    this.userId = -1,
    this.openProjectId = -1,
  });
  @override
  String toString() {
    return 'AppState: {mode: $mode,authMode: $authMode}';
  }
}