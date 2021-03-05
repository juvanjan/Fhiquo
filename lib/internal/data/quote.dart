import 'dart:convert';

import 'package:fhiquo/internal/data/data_contract.dart';
import 'package:fhiquo/internal/helpers/data_converter.dart';
import 'package:fhiquo/internal/locale/app_localizations.dart';
import 'package:flutter/cupertino.dart';

Quote clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Quote.fromMap(jsonData);
}

String clientToJson(Quote data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Quote {
  int id;
  String author;
  String origin;
  String body;
  String comment;
  Set<int> tags;
  DateTime dateCreated;
  DateTime lastEdited;
  DateTime dateDeleted;
  bool deleted;
  bool private;
  bool isAd = false;
  int adIndex;

    Quote({
      this.id,
      this.author,
      this.origin,
      this.body,
      this.comment,
      this.tags,
      this.dateCreated,
      this.lastEdited,
      this.dateDeleted,
      this.deleted,
      this.private,
    });

  factory Quote.fromMap(Map<String, dynamic> json) => new Quote(
    id: json[DataContract.QUOTES_COLUMN_NAME_ID],
    author: json[DataContract.QUOTES_COLUMN_NAME_AUTHORS],
    origin: json[DataContract.QUOTES_COLUMN_NAME_ORIGIN],
    body: json[DataContract.QUOTES_COLUMN_NAME_QUOTE],
    comment: json[DataContract.QUOTES_COLUMN_NAME_COMMENT],
    tags: DataConverter.stringToIntegerSet(json[DataContract.QUOTES_COLUMN_NAME_TAG_IDS]),
    dateCreated: DataConverter.getDateFromString(json[DataContract.QUOTES_COLUMN_NAME_DATE_CREATED]),
    lastEdited: DataConverter.getDateFromString(json[DataContract.QUOTES_COLUMN_NAME_LAST_EDITED]),
    dateDeleted: DataConverter.getDateFromString(json[DataContract.QUOTES_COLUMN_NAME_DATE_DELETED]),
    deleted: json[DataContract.QUOTES_COLUMN_NAME_DELETED] == 1,
    private: json[DataContract.QUOTES_COLUMN_NAME_PRIVATE] == 1,
  );


  Map<String, dynamic> toMap() => {
    DataContract.QUOTES_COLUMN_NAME_AUTHORS: author,
    DataContract.QUOTES_COLUMN_NAME_ORIGIN: origin,
    DataContract.QUOTES_COLUMN_NAME_QUOTE: body,
    DataContract.QUOTES_COLUMN_NAME_COMMENT: comment,
    DataContract.QUOTES_COLUMN_NAME_TAG_IDS: DataConverter.getStringFromIntegerSet(tags),
    DataContract.QUOTES_COLUMN_NAME_DATE_CREATED: DataConverter.getStringFromDate(dateCreated),
    DataContract.QUOTES_COLUMN_NAME_LAST_EDITED: DataConverter.getStringFromDate(lastEdited),
    DataContract.QUOTES_COLUMN_NAME_DATE_DELETED: DataConverter.getStringFromDate(dateDeleted),
    DataContract.QUOTES_COLUMN_NAME_DELETED: deleted ? 1 : 0,
    DataContract.QUOTES_COLUMN_NAME_PRIVATE: private ? 1 : 0,
  };

  static Quote createQuote(int id, String author, String origin, String body, String comment, Set<int> tags) {
    Quote set = new Quote();
    DateTime current = DateTime.now();

    set.id = id;
    set.author = author;
    set.origin = origin;
    set.body = body;
    set.comment = comment;

    set.tags = tags;
    set.dateCreated = current;
    set.lastEdited = current;
    set.dateDeleted = current;
    set.private = false;
    set.deleted = false;
    set.isAd = false;

    return set;
  }

  static Quote createQuoteAdvanced(int id, String author, String origin, String quote, String comment, bool private, Set<int> tags, DateTime dateCreated, DateTime lastEdited, bool deleted, DateTime dateDeleted) {
    Quote set = Quote.createQuote(id, author, origin, quote, comment, tags);

    set.dateCreated = dateCreated;
    set.lastEdited = lastEdited;
    set.dateDeleted = dateDeleted;
    set.private = private;
    set.deleted = deleted;
    set.isAd = false;

    return set;
  }

  Quote deepClone() {
    return Quote.createQuoteAdvanced(id, author, origin, body, comment, private, tags, dateCreated, lastEdited, deleted, dateDeleted);
  }

  static Quote createAd(int index) {
    Quote set = new Quote();
    set.isAd = true;
    set.adIndex = index;
    return set;
  }

  static List<Quote> tempQuotes(BuildContext context) {

    var set = new List<Quote>();
    DateTime now = DateTime.now();

    var quote1 = Quote.createQuote(0,
      AppLocalizations.of(context).translate("default_quote_1_by"),
      AppLocalizations.of(context).translate("default_quote_1_origin"),
      AppLocalizations.of(context).translate("default_quote_1_quote"),
      AppLocalizations.of(context).translate("default_quote_1_comment"),
      new Set<int>());

    var quote2 = Quote.createQuote(1,
      AppLocalizations.of(context).translate("default_quote_2_by"),
      AppLocalizations.of(context).translate("default_quote_2_origin"),
      AppLocalizations.of(context).translate("default_quote_2_quote"),
      AppLocalizations.of(context).translate("default_quote_2_comment"),
      new Set<int>());

    var quote3 = Quote.createQuote(2,
      AppLocalizations.of(context).translate("default_quote_3_by"),
      AppLocalizations.of(context).translate("default_quote_3_origin"),
      AppLocalizations.of(context).translate("default_quote_3_quote"),
      AppLocalizations.of(context).translate("default_quote_3_comment"),
      new Set<int>());

    var quote4 = Quote.createQuote(3,
      AppLocalizations.of(context).translate("default_quote_4_by"),
      AppLocalizations.of(context).translate("default_quote_4_origin"),
      AppLocalizations.of(context).translate("default_quote_4_quote"),
      AppLocalizations.of(context).translate("default_quote_4_comment"),
      new Set<int>());

    var quote5 = Quote.createQuote(4,
      AppLocalizations.of(context).translate("default_quote_5_by"),
      AppLocalizations.of(context).translate("default_quote_5_origin"),
      AppLocalizations.of(context).translate("default_quote_5_quote"),
      AppLocalizations.of(context).translate("default_quote_5_comment"),
      new Set<int>());

    set.add(quote1);
    set.add(quote2);
    set.add(quote3);
    set.add(quote4);
    set.add(quote5);

    return set;

  }

  static List<Quote> tempQuotes2() {

    var set = new List<Quote>();

    var quote1 = Quote.createQuote(0,
      "Ralph Waldo Emerson",
      "Journals of Ralph Waldo Emerson",
      "Make your own Bible. Select and collect all the words and sentences that in all your reading have been to you like the blast of triumph out of Shakspear, Seneca, Moses, John, and Paul.",
      "Entry from July 1836\n\nRalph Waldo Emerson (1803 – 1882) was an American essayist, lecturer, philosopher, and poet. In his early writings, Emerson spelled Shakespeare as Shakspear.",
      [1,2].toSet());

    var quote2 = Quote.createQuote(1,
      "Seneca",
      "Letters from a Stoic",
      "Each day, too, acquire something which will help you to face poverty, or death, and other ills as well. After running over a lot of different thoughts, pick out one to be digested thoroughly that day. This is what I do myself; out of the many bits I have been reading I lay hold of one.",
      "In Letter II\n\nSeneca (c. 4 BC – AD 65) was a Roman statesman, Stoic philosopher, and dramatist.",
      [1,2].toSet());

    var quote3 = Quote.createQuote(2,
      "Marcus Aurelius",
      "Meditations",
      "When you wake up in the morning, tell yourself: the people I deal with today will be meddling, ungrateful, arrogant, dishonest, jealous and surly. They are like this because they can\'t tell good from evil. But I have seen the beauty of good, and the ugliness of evil, and have recognized that the wrongdoer has a nature related to my own - not of the same blood and birth, but the same mind, and possessing a share of the divine. And so none of them can hurt me. No one can implicate me in ugliness. Nor can I feel angry at my relative, or hate him. We were born to work together like feet, hands and eyes, like the two rows of teeth, upper and lower. To obstruct each other is unnatural. To feel anger at someone, to turn your back on him: these are unnatural.",
      "In Book 2, entry 1\n\nMarcus Aurelius (121 – 180) was Roman emperor and a Stoic philosopher.",
      [1,3,4].toSet());

    var quote4 = Quote.createQuote(2,
      "Leo Tolstoy",
      "The Law of Love and the Law of Violence",
      "The most important and necessary human deeds, for both doer and recipient, are those of which he does not see the results.",
      "Lev Tolstoy (1828 – 1910) was a Russian count and writer.",
      [3,4].toSet());

    var quote5 = Quote.createQuote(2,
      "William Butler Yeats",
      "The Wind Among the Reeds",
      "Had I the heavens\' embroidered cloths,\nEnwrought with golden and silver light,\nThe blue and the dim and the dark cloths\nOf night and light and the half−light,\nI would spread the cloths under your feet:\nBut I, being poor, have only my dreams;\nI have spread my dreams under your feet;\nTread softly because you tread on my dreams.",
      "William Butler Yeats (1865 –1939) was an Irish poet. The Wind Among The Reeds, published in 1899, was his third volume of poetry.",
      [5,6].toSet());


    set.add(quote1);
    set.add(quote2);
    set.add(quote3);
    set.add(quote4);
    set.add(quote5);

    return set;
  }

}