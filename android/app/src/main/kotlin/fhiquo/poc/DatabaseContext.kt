package fhiquo.poc

import android.content.Context
import android.content.ContextWrapper
import android.database.DatabaseErrorHandler
import android.database.sqlite.SQLiteDatabase
import android.os.Environment
import android.util.Log
import java.io.File

class DatabaseContext(base: Context?) : ContextWrapper(base) {
    override fun getDatabasePath(name: String): File {
        var dbfile: String = "/data/data/fhiquo.poc/db/TestQDB.db"
        if (!dbfile.endsWith(".db")) {
            dbfile += ".db"
        }
        val result = File(dbfile)
        if (!result.getParentFile().exists()) {
            result.getParentFile().mkdirs()
        }
        if (Log.isLoggable(DEBUG_CONTEXT, Log.WARN)) {
            Log.w(DEBUG_CONTEXT, "getDatabasePath(" + name + ") = " + result.getAbsolutePath())
        }
        return result
    }

    /* this version is called for android devices >= api-11. thank to @damccull for fixing this. */
    override fun openOrCreateDatabase(name: String, mode: Int, factory: SQLiteDatabase.CursorFactory?, errorHandler: DatabaseErrorHandler?): SQLiteDatabase {
        return openOrCreateDatabase(name, mode, factory)
    }

    /* this version is called for android devices < api-11 */
    override fun openOrCreateDatabase(name: String, mode: Int, factory: SQLiteDatabase.CursorFactory?): SQLiteDatabase {

        val result: SQLiteDatabase = SQLiteDatabase.openOrCreateDatabase(getDatabasePath(name), null)
        if (Log.isLoggable(DEBUG_CONTEXT, Log.WARN)) {
            Log.w(DEBUG_CONTEXT, "openOrCreateDatabase(" + name + ",,) = " + result.getPath())
        }
        return result
    }

    companion object {
        private const val DEBUG_CONTEXT = "DatabaseContext"
    }
}