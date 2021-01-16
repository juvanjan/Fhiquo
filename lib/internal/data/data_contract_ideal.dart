// ignore_for_file: non_constant_identifier_names
class DataContract {

  //*********************************//
  //             QUOTES              //
  //*********************************//

  static String QUOTES_TABLE_NAME = "quote";
  static String QUOTES_COLUMN_NAME_ID = "id";
  static String QUOTES_COLUMN_NAME_ORIGIN = "origin_id";
  static String QUOTES_COLUMN_NAME_QUOTE = "quote";
  static String QUOTES_COLUMN_NAME_COMMENT = "comment";
  static String QUOTES_COLUMN_NAME_AUTHORS = "author_id";
  static String QUOTES_COLUMN_NAME_TAG_IDS = "tag_ids";
  static String QUOTES_COLUMN_NAME_PRIVATE = "private";
  static String QUOTES_COLUMN_NAME_DELETED = "deleted";
  static String QUOTES_COLUMN_NAME_DATE_CREATED = "date_created";
  static String QUOTES_COLUMN_NAME_DATE_MODIFIED = "date_modified";
  static String QUOTES_COLUMN_NAME_DATE_DELETED = "date_deleted";

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
        DataContract.QUOTES_COLUMN_NAME_DATE_MODIFIED + " TEXT," +
        DataContract.QUOTES_COLUMN_NAME_DATE_DELETED + " TEXT)";

  static final String SQL_DELETE_QUOTES =
      "DROP TABLE IF EXISTS " + DataContract.QUOTES_TABLE_NAME;

  //*********************************//
  //             TAGS                //
  //*********************************//

  static String TAGS_TABLE_NAME = "tag";
  static String TAGS_COLUMN_NAME_ID = "id";
  static String TAGS_COLUMN_NAME_NAME = "name";

  static String SQL_CREATE_TAGS =
        "CREATE TABLE " + DataContract.TAGS_TABLE_NAME + " (" +
                DataContract.TAGS_COLUMN_NAME_ID + " INTEGER," +
                DataContract.TAGS_COLUMN_NAME_NAME + " TEXT)";

  static String SQL_DELETE_TAGS =
        "DROP TABLE IF EXISTS " + DataContract.TAGS_TABLE_NAME;

  //*********************************//
  //             AUTHORS             //
  //*********************************//

  static String AUTHORS_TABLE_NAME = "author";
  static String AUTHORS_COLUMN_NAME_ID = "id";
  static String AUTHORS_COLUMN_NAME_NAME= "name";


  static String SQL_CREATE_AUTHORS =
    "CREATE TABLE " + DataContract.AUTHORS_TABLE_NAME + " (" +
        DataContract.AUTHORS_COLUMN_NAME_ID + " INTEGER PRIMARY KEY," +
        DataContract.AUTHORS_COLUMN_NAME_NAME + " TEXT)";

  static final String SQL_DELETE_AUTHORS =
      "DROP TABLE IF EXISTS " + DataContract.AUTHORS_TABLE_NAME;

  //*********************************//
  //             ORIGINS             //
  //*********************************//

  static String ORIGINS_TABLE_NAME = "origin";
  static String ORIGINS_COLUMN_NAME_ID = "id";
  static String ORIGINS_COLUMN_NAME_NAME= "name";


  static String SQL_CREATE_ORIGINS =
    "CREATE TABLE " + DataContract.ORIGINS_TABLE_NAME + " (" +
        DataContract.ORIGINS_COLUMN_NAME_ID + " INTEGER PRIMARY KEY," +
        DataContract.ORIGINS_COLUMN_NAME_NAME + " TEXT)";

  static final String SQL_DELETE_ORIGINS =
      "DROP TABLE IF EXISTS " + DataContract.ORIGINS_TABLE_NAME;

}