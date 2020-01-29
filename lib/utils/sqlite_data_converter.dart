class SQLiteDataConverter { 
  static bool readBool(int sqliteBool){
    if (sqliteBool == 0) return false;

    if (sqliteBool == 1) return true;

    if (sqliteBool < 0 || sqliteBool > 1) throw FormatException("SQLite bool is either 0 or 1 -- found $sqliteBool instead");

    return null;
  }
}