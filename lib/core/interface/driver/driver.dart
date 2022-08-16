abstract class Driver {
  bool get isWork;
  Stream<double> get forceStream;
  double get force;
  Future<void> addFuelStream(Stream<double> fuelStream);
  Future<void> stop();
  void start();
}
