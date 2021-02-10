package fhiquo.poc

import android.content.Context
import android.database.Cursor
import android.database.sqlite.SQLiteDatabase
import kotlin.random.Random

class WidgetDatabase(context: Context?) {
    private val databaseHelper: DatabaseHelper
    private val database: SQLiteDatabase


    fun getDataCount(): Int? {
        val query = "SELECT COUNT(*) AS num FROM Quotes"
        val cursor: Cursor = database.rawQuery(query, null)
        if (cursor.moveToFirst()) {
            return cursor.getInt(0)
        }
        return null
    }

    //Example of getting a list from database
    fun getRandomQuote(): WidgetQuote {

        val quote: WidgetQuote = WidgetQuote("ERROR", "ERROR");
        val count: Int? = getDataCount();
        if (count != null) {
            val rnum: Int = Random.nextInt(count);
            val query = "SELECT Quote, Authors FROM Quotes LIMIT 1 OFFSET $rnum;"
            val cursor: Cursor = database.rawQuery(query, null)
            if (cursor.moveToFirst()) {
                quote.body = cursor.getString(0);
                quote.author = cursor.getString(1);
                return quote;
            }
        }

        return quote
    }

    init {
        databaseHelper = DatabaseHelper(context, "TestQDB.db")
        database = databaseHelper.readableDatabase
    }
}