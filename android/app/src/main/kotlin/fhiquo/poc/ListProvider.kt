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


/*
 *  If you are familiar with Adapter of ListView, this is the same as adapter
 *  with few changes
 */
class ListProvider(private val context: Context, intent: Intent) : RemoteViewsService.RemoteViewsFactory {
    private val appWidgetId: Int
    private val quoteText: String
    private val authorText: String
    private val updatedText: String
    private val quoteId: Int

    /*
     * Similar to getView of Adapter where instead of View we return RemoteViews
     */
    override fun getViewAt(position: Int): RemoteViews {
        val bodyView = RemoteViews(context.packageName, R.layout.widget_quote_row)
        bodyView.setTextViewText(R.id.BodyText, quoteText)
        bodyView.setTextViewText(R.id.AuthorText, authorText)
        bodyView.setViewVisibility(R.id.AuthorText, if (authorText.isNullOrEmpty()) View.GONE else View.VISIBLE)
        bodyView.setTextViewText(R.id.UpdatedText, updatedText)

        // Next, set a fill-intent, which will be used to fill in the pending intent template
        // that is set on the collection view in StackWidgetProvider.
        /*
        val extras = Bundle()
        extras.putInt(Codes.INTENT_EXTRA_QUOTE_ID_WIDGET, quoteId)
        val fillInIntent = Intent()
        fillInIntent.putExtras(extras)
        // Make it possible to distinguish the individual on-click
        // action of a given item
        bodyView.setOnClickFillInIntent(R.id.widget_quote_frame, fillInIntent)
        */
        return bodyView
    }

    override fun onCreate() {

    }

    override fun getLoadingView(): RemoteViews? = null

    override fun onDataSetChanged() {}
    override fun onDestroy() {}
    override fun getCount(): Int {
        return 1
    }

    override fun getItemId(position: Int): Long {
        return position.toLong()
    }

    override fun hasStableIds(): Boolean {
        return true
    }


    override fun getViewTypeCount(): Int {
        return 1
    }

    init {
        appWidgetId = intent.getIntExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, AppWidgetManager.INVALID_APPWIDGET_ID)
        quoteText = intent.getStringExtra(Codes.INTENT_EXTRA_QUOTE_TEXT)
        authorText = intent.getStringExtra(Codes.INTENT_EXTRA_AUTHOR_TEXT)
        updatedText = intent.getStringExtra(Codes.INTENT_EXTRA_UPDATED_TEXT)
        quoteId = intent.getIntExtra(Codes.INTENT_EXTRA_QUOTE_ID_WIDGET, -1)
    }
}