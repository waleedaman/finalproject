class AppState{
  String mode;
  AppState({
    this.mode = ""
  });
  @override
  String toString() {
    return 'AppState: {mode: $mode}';
  }
}