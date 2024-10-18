sealed class AppLinksData {}

class EmptyAppLinksData extends AppLinksData {}

class BrowserAppLinksData extends AppLinksData {
  BrowserAppLinksData(this.url);

  final Uri url;
}
