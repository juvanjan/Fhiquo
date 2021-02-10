package phiquo.app.widget

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.view.View
import android.widget.RemoteViews
import android.widget.RemoteViewsService
import fhiquo.poc.Codes
import fhiquo.poc.R
import fhiquo.poc.WidgetDatabase
import fhiquo.poc.WidgetQuote


/*
 *  If you are familiar with Adapter of ListView, this is the same as adapter
 *  with few changes
 */
class ListProvider(private val context: Context, intent: Intent) : RemoteViewsService.RemoteViewsFactory {
    private val appWidgetId: Int = intent.getIntExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, AppWidgetManager.INVALID_APPWIDGET_ID)
    private val quoteText: String = intent.getStringExtra(Codes.INTENT_EXTRA_QUOTE_TEXT)
    private val authorText: String = intent.getStringExtra(Codes.INTENT_EXTRA_AUTHOR_TEXT)
    private val updatedText: String = intent.getStringExtra(Codes.INTENT_EXTRA_UPDATED_TEXT)
    private val quoteId: Int = intent.getIntExtra(Codes.INTENT_EXTRA_QUOTE_ID_WIDGET, -1)

    /*
     * Similar to getView of Adapter where instead of View we return RemoteViews
     */
    override fun getViewAt(position: Int): RemoteViews {
        val bodyView = RemoteViews(context.packageName, R.layout.widget_quote_row)

        val db = WidgetDatabase(context);
        val quote = db.getRandomQuote()

        bodyView.setTextViewText(R.id.BodyText, getBody(quote))
        bodyView.setTextViewText(R.id.AuthorText, getAuthor(quote))
        bodyView.setViewVisibility(R.id.AuthorText, if (getAuthor(quote).isNullOrEmpty()) View.GONE else View.VISIBLE)
        bodyView.setTextViewText(R.id.UpdatedText, updatedText)

        return bodyView
    }

    private fun getBody(quote: WidgetQuote): String {
        return if (quote.body != "ERROR") quote.body else quoteText
    }

    private fun getAuthor(quote: WidgetQuote): String {
        return if (quote.author != "ERROR") quote.author else authorText
    }

    override fun onCreate() {}
    override fun getLoadingView(): RemoteViews? = null
    override fun onDataSetChanged() {}
    override fun onDestroy() {}
    override fun getCount(): Int = 1

    override fun getItemId(position: Int): Long {
        return position.toLong()
    }

    override fun hasStableIds(): Boolean {
        return true
    }

    override fun getViewTypeCount(): Int {
        return 1
    }

}