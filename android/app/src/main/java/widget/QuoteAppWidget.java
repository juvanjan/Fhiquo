package widget;

import android.app.PendingIntent;
import android.appwidget.AppWidgetManager;
import android.appwidget.AppWidgetProvider;
import android.content.ActivityNotFoundException;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.net.Uri;
import android.util.Log;
import android.widget.RemoteViews;
import android.widget.Toast;

import fhiquo.fhiquo.R;

/*
 * Implementation of App Widget functionality.
 */
public class QuoteAppWidget extends AppWidgetProvider {

    //todo private DataHelper data;
    private int AppWidgetId;

    private void updateAppWidget(Context context, AppWidgetManager appWidgetManager, int appWidgetId) {

        AppWidgetId = appWidgetId;

        // Body data
        //todo data = getData(context);
        //todo if (data.widgetQuote == null)
        //todo    data.setRandomWidgetQuote();

        // Register screen receiver
        ScreenReceiver receiver = new ScreenReceiver(context, this);
        IntentFilter filter = new IntentFilter();
        filter.addAction(Intent.ACTION_SCREEN_OFF);
        filter.addAction(Intent.ACTION_USER_PRESENT);
        context.getApplicationContext().registerReceiver(receiver, filter);

        // List view
        String quoteText = "quote"; //todo data.widgetQuote.Body;
        String authorText = "author"; //todo data.widgetQuote.Author.replace(";", ", ");
        Integer quoteId = 0; //todo data.widgetQuote.Id;
        RemoteViews remoteViews = updateWidgetListView(context, quoteText, authorText, quoteId, AppWidgetId);

/*
        // This section makes it possible for items to have individualized behavior.
        // It does this by setting up a pending intent template. Individuals items of a collection
        // cannot set up their own pending intents. Instead, the collection as a whole sets
        // up a pending intent template, and the individual items set a fillInIntent
        // to create unique behavior on an item-by-item basis.
        Intent activityIntent = new Intent(context, NGalleryActivity.class);
        // Set the action for the intent.
        // When the user touches a particular view.
        activityIntent.putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, appWidgetId);
        activityIntent.setData(Uri.parse(activityIntent.toUri(Intent.URI_INTENT_SCHEME)));
        activityIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK |Intent.FLAG_ACTIVITY_CLEAR_TASK);
        PendingIntent pendingIntentList = PendingIntent.getActivity(context, appWidgetId, activityIntent, PendingIntent.FLAG_UPDATE_CURRENT);
        remoteViews.setPendingIntentTemplate(R.id.widget_list_view, pendingIntentList);
*/

        // Refresh button
        remoteViews.setOnClickPendingIntent(R.id.RefreshWidgetButton, getPendingIntent(context, Codes.WIDGET_REFRESH_CLICKED, new Intent(context, getClass())));

        // Lock button
        remoteViews.setOnClickPendingIntent(R.id.LockWidgetButton, getPendingIntent(context, Codes.WIDGET_lOCK_CLICKED, new Intent(context, getClass())));

        /*
        //todo
        // App button
        try {
            Intent intent = new Intent("android.intent.action.MAIN");
            intent.addCategory("android.intent.category.LAUNCHER");

            intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
            intent.setComponent(new ComponentName(context.getPackageName(), SplashActivity.class.getName()));
            PendingIntent pendingIntent = PendingIntent.getActivity(context, 0, intent, 0);

            remoteViews.setOnClickPendingIntent(R.id.AppWidgetButton, pendingIntent);
            remoteViews.setOnClickPendingIntent(R.id.AppWidgetName, pendingIntent);
        } catch (ActivityNotFoundException e) {
            Toast.makeText(context.getApplicationContext(), R.string.widget_notice_activity_not_found + " ", Toast.LENGTH_SHORT).show();
        }
        */

        ComponentName watchWidget = new ComponentName(context, QuoteAppWidget.class);
        appWidgetManager.updateAppWidget(watchWidget, remoteViews);
    }

    /* //todo
    private DataHelper getData(Context context) {
        if (data == null)
            data = DataHelper.getInstance(context);

        return data;
    }
    */

    private RemoteViews updateWidgetListView(Context context, String quoteText, String authorText, Integer quoteId, int appWidgetId) {

        //which layout to show on widget
        RemoteViews remoteViews = new RemoteViews(context.getPackageName(), R.layout.widget_main);

        //RemoteViews Service needed to provide adapter for ListView
        Intent svcIntent = new Intent(context, WidgetViewService.class);
        svcIntent.putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, appWidgetId);
        svcIntent.putExtra(Codes.INTENT_EXTRA_QUOTE_TEXT, quoteText);
        svcIntent.putExtra(Codes.INTENT_EXTRA_AUTHOR_TEXT, authorText);
        svcIntent.putExtra(Codes.INTENT_EXTRA_QUOTE_ID_WIDGET, quoteId);
        //setting a unique Uri to the intent, don't know its purpose to me right now
        svcIntent.setData(Uri.parse(svcIntent.toUri(Intent.URI_INTENT_SCHEME)));
        //setting adapter to listview of the widget
        remoteViews.setRemoteAdapter(R.id.widget_list_view, svcIntent);
        //setting an empty view in case of no data
        remoteViews.setEmptyView(R.id.widget_list_view, R.id.empty_view);
        //setting lock icon
        remoteViews.setInt(R.id.LockWidgetButtonImage, "setBackgroundResource", /*data.widgetLock*/ true ? R.drawable.ic_lock_white_24dp : R.drawable.ic_lock_open_white_24dp);
        //setting refresh icon
        remoteViews.setInt(R.id.RefreshWidgetButtonImage, "setBackgroundResource", /*data.widgetLock*/ true ? R.drawable.ic_refresh_white_50a_24dp : R.drawable.ic_refresh_white_24dp);

        return remoteViews;
    }

    public int setAppWidgetId() {
        return AppWidgetId;
    }

    @Override
    public void onReceive(Context context, Intent intent) {
        super.onReceive(context, intent);


        //todo DataHelper quoteData = getData(context);
        String action = intent.getAction();

        // Action
        switch (action) {
            case Codes.WIDGET_REFRESH_CLICKED:
                //Log.i(LoggingHelper.PerformanceLogging, "Refresh clicked!");
                //todo quoteData.setRandomWidgetQuote();
                break;
            case Codes.WIDGET_lOCK_CLICKED:
                //todo data.widgetLock = !data.widgetLock;
                break;
        }

        // Refresh
        switch (action) {
            case Codes.WIDGET_REFRESH_CLICKED:
            case Codes.WIDGET_lOCK_CLICKED:
                refresh(context);
                break;
        }
    }

    public void refresh(Context context) {
        AppWidgetManager appWidgetManager = AppWidgetManager.getInstance(context);

        //todo if (data.widgetQuote == null)
        //todo     data.setRandomWidgetQuote();

        String quoteText = "quote"; //todo data.widgetQuote.Body;
        String authorText = "author"; //todo data.widgetQuote.Author.replace(CommonHelper.authorSeparator, ", ");
        Integer quoteId = 0; //todo data.widgetQuote.Id;
        RemoteViews remoteViews = updateWidgetListView(context, quoteText, authorText, quoteId, -1);
        ComponentName appWidget = new ComponentName(context, QuoteAppWidget.class);
        appWidgetManager.updateAppWidget(appWidget, remoteViews);
    }

    protected PendingIntent getPendingIntent(Context context, String action, Intent intent) {
        intent.setAction(action);
        return PendingIntent.getBroadcast(context, 0, intent, 0);
    }

    @Override
    public void onUpdate(Context context, AppWidgetManager appWidgetManager, int[] appWidgetIds) {
        //todo if (data == null)
            //todo data = DataHelper.getInstance(context);

        //Log.i(LoggingHelper.PerformanceLogging, "[QAW ][onUpdate] Data available: " + (data == null));

        //todo if (data != null) {
            //todo data.setRandomWidgetQuote();
            //Log.i(LoggingHelper.PerformanceLogging, "[QAW ][onUpdate] Random quote set!");
        //todo }

        // There may be multiple widgets active, so update all of them
        for (int appWidgetId : appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId);
        }
        super.onUpdate(context, appWidgetManager, appWidgetIds);
    }

    @Override
    public void onEnabled(Context context) {
        // Enter relevant functionality for when the first widget is created

        // Body data
        //todo data = getData(context);
        //todo data.setRandomWidgetQuote();
    }

    @Override
    public void onDisabled(Context context) {
        // Enter relevant functionality for when the last widget is disabled
    }
}