package fhiquo.poc

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.net.Uri
import android.os.Bundle
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider
import java.text.SimpleDateFormat
import java.util.*

class QuoteAppWidget : HomeWidgetProvider() {
    val REFRESH_CLICKED = "fhiquo.poc.REFRESH_CLICKED"

    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray, widgetData: SharedPreferences) {
        appWidgetIds.forEach {
            widgetId -> updateWidget(context, widgetId, appWidgetManager, widgetData)
        }
    }

    fun updateWidget(context: Context, widgetId: Int, appWidgetManager: AppWidgetManager, widgetData: SharedPreferences) {
        val simpleDateFormat = SimpleDateFormat("HH:mm:ss")
        val currentDateAndTime: String = simpleDateFormat.format(Date())

        val quoteText: String = widgetData.getString("body", null) ?: "No Title Set";
        val authorText: String = widgetData.getString("author", null) ?: "No message Set";
        val updatedText: String = widgetData.getString("updated", null) ?: currentDateAndTime;
        val quoteId: Int = 0;

        val remoteViews = updateWidgetListView(context, quoteText, authorText, updatedText, quoteId, widgetId);
        remoteViews.setOnClickPendingIntent(R.id.AppWidgetButton, PendingIntent.getActivity(context, 0, Intent(context, MainActivity::class.java), 0));
        remoteViews.setOnClickPendingIntent(R.id.AppWidgetName, PendingIntent.getActivity(context, 0, Intent(context, MainActivity::class.java), 0));

        // Refresh button
        val active = Intent(context, QuoteAppWidget::class.java)
        active.action = REFRESH_CLICKED
        val actionPendingIntent = PendingIntent.getBroadcast(context, 0, active, 0)
        remoteViews.setOnClickPendingIntent(R.id.RefreshWidgetButton, actionPendingIntent)

        appWidgetManager.updateAppWidget(widgetId, remoteViews)
        appWidgetManager.notifyAppWidgetViewDataChanged(widgetId, R.id.widget_list_view)
    }

    override fun onReceive(paramContext: Context?, paramIntent: Intent) {
        if (paramIntent.action.equals(REFRESH_CLICKED)) {
            if (paramContext != null) {
                val appWidgetManager = AppWidgetManager.getInstance(paramContext)
                val thisAppWidget = ComponentName(paramContext.packageName, QuoteAppWidget::class.java.name)
                val appWidgetIds = appWidgetManager.getAppWidgetIds(thisAppWidget)
                appWidgetIds.forEach { appWidgetId ->
                    appWidgetManager.notifyAppWidgetViewDataChanged(appWidgetId, R.id.widget_list_view)
                }

            }
        } else {
            super.onReceive(paramContext, paramIntent)
        }
    }


    private fun updateWidgetListView(context: Context, quoteText: String, authorText: String, updatedText: String, quoteId: Int, appWidgetId: Int): RemoteViews {

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