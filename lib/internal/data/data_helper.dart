import 'dart:async';
import 'package:fhiquo/internal/data/data_contract.dart';
import 'package:fhiquo/internal/data/quote.dart';
import 'package:fhiquo/internal/data/tag.dart';
import 'package:sqflite/sqflite.dart';

class DataHelper {
  static final DataHelper _instance = new DataHelper.internal();
  factory DataHelper() => _instance;
	static Database _database;
	static int get version => 1;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

	DataHelper.internal();

  initDB() async {
		//Directory documentsDirectory = await getApplicationDocumentsDirectory();
		//join(documentsDirectory.path, "TestDB.db");

		String path = "/data/data/fhiquo.poc/db/TestQDB.db";
    return await openDatabase(path, version: version, onOpen: (db) {}, onCreate: onCreate);
  }

	void onCreate(Database db, int version) async {
    await db.execute(DataContract.SQL_CREATE_QUOTES);
		print("Quotes DB created.");
    await db.execute(DataContract.SQL_CREATE_TAGS);
		print("Tags DB created.");
		await insertDefaultTags(db);
		print("Default tags inserted.");
		await insertDefaultQuotes(db);
		print("Default quotes inserted.");
  }

	Future<void> insertDefaultTags(Database db) async {
		await insertTagInternal(Tag.createTag(1, "ADVICE"), db);
		await insertTagInternal(Tag.createTag(2, "WISDOM"), db);
		await insertTagInternal(Tag.createTag(3, "INSPIRATION"), db);
		await insertTagInternal(Tag.createTag(4, "PHILOSOPHY"), db);
		await insertTagInternal(Tag.createTag(5, "POETRY"), db);
		await insertTagInternal(Tag.createTag(6, "DREAMS"), db);
	}

	Future<void> insertDefaultQuotes(Database db) async {
		await insertQuoteInternal(Quote.createQuote(0,
      "Ralph Waldo Emerson",
      "Journals of Ralph Waldo Emerson",
      "Make your own Bible. Select and collect all the words and sentences that in all your reading have been to you like the blast of triumph out of Shakspear, Seneca, Moses, John, and Paul.",
      "Entry from July 1836\n\nRalph Waldo Emerson (1803 – 1882) was an American essayist, lecturer, philosopher, and poet. In his early writings, Emerson spelled Shakespeare as Shakspear.",
      [1,2]), db);

    await insertQuoteInternal(Quote.createQuote(1,
      "Seneca",
      "Letters from a Stoic",
      "Each day, too, acquire something which will help you to face poverty, or death, and other ills as well. After running over a lot of different thoughts, pick out one to be digested thoroughly that day. This is what I do myself; out of the many bits I have been reading I lay hold of one.",
      "In Letter II\n\nSeneca (c. 4 BC – AD 65) was a Roman statesman, Stoic philosopher, and dramatist.",
      [1,2]), db);

    await insertQuoteInternal(Quote.createQuote(2,
      "Marcus Aurelius",
      "Meditations",
      "When you wake up in the morning, tell yourself: the people I deal with today will be meddling, ungrateful, arrogant, dishonest, jealous and surly. They are like this because they can\'t tell good from evil. But I have seen the beauty of good, and the ugliness of evil, and have recognized that the wrongdoer has a nature related to my own - not of the same blood and birth, but the same mind, and possessing a share of the divine. And so none of them can hurt me. No one can implicate me in ugliness. Nor can I feel angry at my relative, or hate him. We were born to work together like feet, hands and eyes, like the two rows of teeth, upper and lower. To obstruct each other is unnatural. To feel anger at someone, to turn your back on him: these are unnatural.",
      "In Book 2, entry 1\n\nMarcus Aurelius (121 – 180) was Roman emperor and a Stoic philosopher.",
      [1,3,4]), db);

    await insertQuoteInternal(Quote.createQuote(2,
      "Leo Tolstoy",
      "The Law of Love and the Law of Violence",
      "The most important and necessary human deeds, for both doer and recipient, are those of which he does not see the results.",
      "Lev Tolstoy (1828 – 1910) was a Russian count and writer.",
      [3,4]), db);

    await insertQuoteInternal(Quote.createQuote(2,
      "William Butler Yeats",
      "The Wind Among the Reeds",
      "Had I the heavens\' embroidered cloths,\nEnwrought with golden and silver light,\nThe blue and the dim and the dark cloths\nOf night and light and the half−light,\nI would spread the cloths under your feet:\nBut I, being poor, have only my dreams;\nI have spread my dreams under your feet;\nTread softly because you tread on my dreams.",
      "William Butler Yeats (1865 –1939) was an Irish poet. The Wind Among The Reeds, published in 1899, was his third volume of poetry.",
      [5,6]), db);
	}


	Future<List<Quote>> readQuotes() async {
  	Database _db = await database;
		var res = await _db.query(DataContract.QUOTES_TABLE_NAME);
		List<Quote> list = res.isNotEmpty ? res.map((c) => Quote.fromMap(c)).toList() : null;
		return list;
  }

  Future<int> insertQuote(Quote quote) async {
		Database db = await database;
		return await insertQuoteInternal(quote, db);
	}

	Future<int> insertQuoteInternal(Quote quote, Database db) async {
  	var map = quote.toMap();
    return await db.insert(DataContract.QUOTES_TABLE_NAME, map);
  }

	Future<int> updateQuote(Quote quote) async {
		Database _db = await database;
    return await _db.update(DataContract.QUOTES_TABLE_NAME, quote.toMap(), where: DataContract.QUOTES_COLUMN_NAME_ID + ' = ?', whereArgs: [quote.id]);
  }

	Future<int> deleteQuote(Quote quote) async {
		Database _db = await database;
	  return await _db.delete(DataContract.QUOTES_TABLE_NAME, where: DataContract.QUOTES_COLUMN_NAME_ID + ' = ?', whereArgs: [quote.id]);
  }

  Future<List<Map<String, dynamic>>> readTags() async {
		Database _db = await database;
    return _db.query(DataContract.TAGS_TABLE_NAME);
  }

	Future<int> insertTag(Tag tag) async {
  	Database db = await database;
    return await insertTagInternal(tag, db);
  }

	Future<int> insertTagInternal(Tag tag, Database db) async {
    return await db.insert(DataContract.TAGS_TABLE_NAME, tag.toMap());
  }

	Future<int> updateTag(Tag tag) async {
  	Database _db = await database;
    return await _db.update(DataContract.TAGS_TABLE_NAME, tag.toMap(), where: DataContract.QUOTES_COLUMN_NAME_ID + ' = ?', whereArgs: [tag.id]);
  }

	Future<int> deleteTag(Tag tag) async {
  	Database _db = await database;
	  return await _db.delete(DataContract.TAGS_TABLE_NAME, where: DataContract.QUOTES_COLUMN_NAME_ID + ' = ?', whereArgs: [tag.id]);
  }

}