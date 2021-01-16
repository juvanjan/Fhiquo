// ignore_for_file: non_constant_identifier_names
class DataContract {

  static String QUOTES_TABLE_NAME = "Quotes";
  static String QUOTES_COLUMN_NAME_ID = "_id";
  static String QUOTES_COLUMN_NAME_ORIGIN = "Origin";
  static String QUOTES_COLUMN_NAME_QUOTE = "Quote";
  static String QUOTES_COLUMN_NAME_COMMENT = "Comment";
  static String QUOTES_COLUMN_NAME_AUTHORS = "Authors";
  static String QUOTES_COLUMN_NAME_TAG_IDS = "TagIds";
  static String QUOTES_COLUMN_NAME_PRIVATE = "Private";
  static String QUOTES_COLUMN_NAME_DELETED = "Deleted";
  static String QUOTES_COLUMN_NAME_DATE_CREATED = "DateCreated";
  static String QUOTES_COLUMN_NAME_LAST_EDITED = "LastEdited";
  static String QUOTES_COLUMN_NAME_DATE_DELETED = "DateDeleted";

  static String SQL_CREATE_QUOTES =
    "CREATE TABLE " + DataContract.QUOTES_TABLE_NAME + " (" +
        DataContract.QUOTES_COLUMN_NAME_ID + " INTEGER PRIMARY KEY," +
        DataContract.QUOTES_COLUMN_NAME_QUOTE + " TEXT," +
        DataContract.QUOTES_COLUMN_NAME_AUTHORS + " TEXT," +
        DataContract.QUOTES_COLUMN_NAME_ORIGIN + " TEXT," +
        DataContract.QUOTES_COLUMN_NAME_COMMENT + " TEXT," +
        DataContract.QUOTES_COLUMN_NAME_TAG_IDS + " TEXT," +
        DataContract.QUOTES_COLUMN_NAME_PRIVATE + " INTEGER," +
        DataContract.QUOTES_COLUMN_NAME_DELETED + " INTEGER," +
        DataContract.QUOTES_COLUMN_NAME_DATE_CREATED + " TEXT," +
        DataContract.QUOTES_COLUMN_NAME_LAST_EDITED + " TEXT," +
        DataContract.QUOTES_COLUMN_NAME_DATE_DELETED + " TEXT)";

  static final String SQL_DELETE_QUOTES =
      "DROP TABLE IF EXISTS " + DataContract.QUOTES_TABLE_NAME;


  static String TAGS_TABLE_NAME = "Tags";
  static String TAGS_COLUMN_NAME_ID = "Id";
  static String TAGS_COLUMN_NAME_NAME = "Name";

  static String SQL_CREATE_TAGS =
        "CREATE TABLE " + DataContract.TAGS_TABLE_NAME + " (" +
                DataContract.TAGS_COLUMN_NAME_ID + " INTEGER," +
                DataContract.TAGS_COLUMN_NAME_NAME + " TEXT)";

  static String SQL_DELETE_TAGS =
        "DROP TABLE IF EXISTS " + DataContract.TAGS_TABLE_NAME;
}