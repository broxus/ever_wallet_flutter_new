enum ChooseNetworkScreenNextStep {
  createWallet('createWallet'),
  importSeed('importSeed');

  const ChooseNetworkScreenNextStep(this.value);

  final String value;

  static ChooseNetworkScreenNextStep? byValue(String? text) {
    if (text == ChooseNetworkScreenNextStep.createWallet.value) {
      return ChooseNetworkScreenNextStep.createWallet;
    } else if (text == ChooseNetworkScreenNextStep.importSeed.value) {
      return ChooseNetworkScreenNextStep.importSeed;
    }
    return null;
  }
}
