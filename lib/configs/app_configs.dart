class AppConfigs {
  static const String appName = 'Real Agent';

  ///DEV

  ///STAGING
  static const envName = "Staging";
  static const webUrl = "https://www.themoviedb.org";
  static const baseUrl = "https://api.themoviedb.org";
  static const socketUrl = 'wss://socket.themoviedb.org'; //Todo: change this

  ///PRODUCTION

  ///Paging
  static const pageSize = 20;
  static const pageSizeMax = 1000;

  ///Local
  static const appLocal = 'vi_VN';
  static const appLanguage = 'en';

  ///DateFormat

  static const dateAPIFormat = 'dd/MM/yyyy';
  static const dateDisplayFormat = 'dd/MM/yyyy';

  static const dateTimeAPIFormat =
      "MM/dd/yyyy'T'hh:mm:ss.SSSZ"; //Use DateTime.parse(date) instead of ...
  static const dateTimeDisplayFormat = 'dd/MM/yyyy HH:mm';

  ///Date range
  static final identityMinDate = DateTime(1900, 1, 1);
  static final identityMaxDate = DateTime.now();
  static final birthMinDate = DateTime(1900, 1, 1);
  static final birthMaxDate = DateTime.now();

  ///Font
  static const fontFamily = 'Roboto';

  ///Max file
  static const maxAttachFile = 5;
}

class FirebaseConfig {
  //Todo
}

class DatabaseConfig {
  //Todo
  static const int version = 1;
}

class MovieAPIConfig {
  static const String APIKey = '225bfef87cdccb35373c0d4625e7895b';
  static const String v4AccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyMjViZmVmODdjZGNjYjM1MzczYzBkNDYyNWU3ODk1YiIsIm5iZiI6MTc1NTk3Nzc3Mi4zNDUsInN1YiI6IjY4YWExODJjYjYzZDI2MWNlNDQ0ODhjMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.YL9GLay9iqsJgeovDFniSNWfcaMOg2jRNSR74_UDsDU';
}

class UpGraderAPIConfig {
  static const String APIKey = '';
}
