class Calculate {
  double weight = 0.0;
  double height = 0.0;

  double calculateBmi(double weight, double height) {
    this.weight = weight;
    this.height = height;
    double bmi = this.weight / (this.height * this.height);
    return double.parse(bmi.toStringAsFixed(2));
  }

  String output(double input) {
    String res = "";
    //This function displays the output. If you are over weight, under weight or just fine I guess.
    if (input <= 18.5) {
      res = "Under weight";
    } else if (input >= 18.5 && input <= 24.5) {
      res = "Healthy weight";
    } else if (input >= 25.0 && input <= 29.9) {
      res = "Over weight";
    } else if (input >= 30) {
      res = "Obese";
    }
    return res.toString();
  }

  double calculateBMIImperial(double weight, double height) {
    this.weight = weight;
    this.height = height;
    double bmi = (this.weight / (this.height * this.height)) * 703;
    return bmi;
  }
}
