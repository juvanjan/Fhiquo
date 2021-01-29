package fhiquo.poc

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.*
import android.net.Uri
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider

class QuoteAppWidget : HomeWidgetProvider() {

    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray, widgetData: SharedPreferences) {

        appWidgetIds.forEach { widgetId ->


            // List view
            val quoteText: String = widgetData.getString("body", null) ?: "No Title Set";
            val authorText: String = widgetData.getString("author", null) ?: "No message Set";
            val updatedText: String = widgetData.getString("updated", null) ?: "No updated Set";
            val quoteId: Int = 0;
            val remoteViews = updateWidgetListView(context, quoteText, authorText, updatedText, quoteId, widgetId);

            // Refresh button
            // remoteViews.setOnClickPendingIntent(R.id.RefreshWidgetButton, getPendingIntent(context, Codes.WIDGET_REFRESH_CLICKED, Intent(context, javaClass)))

            // Lock button
            // remoteViews.setOnClickPendingIntent(R.id.LockWidgetButton, getPendingIntent(context, Codes.WIDGET_lOCK_CLICKED, Intent(context, javaClass)))

            // App button
            try {
                val intent = Intent("android.intent.action.MAIN")
                intent.addCategory("android.intent.category.LAUNCHER")
                intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION)
                intent.component = ComponentName(context.packageName, MainActivity::class.java.getName())
                val pendingIntent = PendingIntent.getActivity(context, 0, intent, 0)
                remoteViews.setOnClickPendingIntent(R.id.AppWidgetButton, pendingIntent)
                remoteViews.setOnClickPendingIntent(R.id.AppWidgetName, pendingIntent)
                remoteViews.setOnClickPendingIntent(R.id.widget_container, PendingIntent.getActivity(context, 0, Intent(context, MainActivity::class.java), 0))
            } catch (e: ActivityNotFoundException) {
                //Toast.makeText(context.applicationContext, "There was a problem loading the application" + " ", Toast.LENGTH_SHORT).show()
            }
            //val watchWidget = ComponentName(context, QuoteAppWidget::class.java)

            appWidgetManager.updateAppWidget(widgetId, remoteViews)
        }

    }

    private fun updateWidgetListView(context: Context, quoteText: String, authorText: String, updatedText: String,quoteId: Int, appWidgetId: Int): RemoteViews {
        println("NNNNNNNNNNNNNNNNNNNNNN - updateWidgetListView");

        return RemoteViews(context.packageName, R.layout.widget_main).apply {
            //RemoteViews Service needed to provide adapter for ListView
            val svcIntent = Intent(context, WidgetViewService::class.java)
            svcIntent.putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, appWidgetId)
            svcIntent.putExtra(Codes.INTENT_EXTRA_QUOTE_TEXT, quoteText)
            svcIntent.putExtra(Codes.INTENT_EXTRA_AUTHOR_TEXT, authorText)
            svcIntent.putExtra(Codes.INTENT_EXTRA_UPDATED_TEXT, updatedText)
            //setting a unique Uri to the intent, don't know its purpose to me right now
            svcIntent.data = Uri.parse(svcIntent.toUri(Intent.URI_INTENT_SCHEME))
            //setting adapter to listview of the widget
            setRemoteAdapter(R.id.widget_list_view, svcIntent)
            //setting an empty view in case of no data
            setEmptyView(R.id.widget_list_view, R.id.empty_view)
            //setting lock icon
            //remoteViews.setInt(R.id.LockWidgetButtonImage, "setBackgroundResource", R.drawable.ic_lock_open_white_24dp)
            //setting refresh icon
            //remoteViews.setInt(R.id.RefreshWidgetButtonImage, "setBackgroundResource", R.drawable.ic_refresh_white_24dp)
        }

    }

}