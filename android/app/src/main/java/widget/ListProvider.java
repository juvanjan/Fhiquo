package widget;

import android.annotation.TargetApi;
import android.appwidget.AppWidgetManager;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.widget.RemoteViews;
import android.widget.RemoteViewsService;

import fhiquo.fhiquo.R;


/*
 *  If you are familiar with Adapter of ListView, this is the same as adapter
 *  with few changes
 */
@TargetApi(Build.VERSION_CODES.HONEYCOMB)
public class ListProvider implements RemoteViewsService.RemoteViewsFactory {
    private Context context;
    private int appWidgetId;
    private String quoteText;
    private String authorText;
    private Integer quoteId;

    public ListProvider(Context context, Intent intent) {
        this.context = context;
        appWidgetId = intent.getIntExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, AppWidgetManager.INVALID_APPWIDGET_ID);
        quoteText = intent.getStringExtra(Codes.INTENT_EXTRA_QUOTE_TEXT);
        authorText = intent.getStringExtra(Codes.INTENT_EXTRA_AUTHOR_TEXT);
        quoteId = intent.getIntExtra(Codes.INTENT_EXTRA_QUOTE_ID_WIDGET, -1);
    }

    /*
     * Similar to getView of Adapter where instead of View we return RemoteViews
     */
    @Override
    public RemoteViews getViewAt(int position) {
        final RemoteViews bodyView = new RemoteViews(context.getPackageName(), R.layout.widget_quote_row);
        bodyView.setTextViewText(R.id.BodyText, quoteText);
        bodyView.setTextViewText(R.id.AuthorText, authorText);
        bodyView.setViewVisibility(R.id.AuthorText, IsEmptyOrNull(authorText) ? View.GONE : View.VISIBLE);

        // Next, set a fill-intent, which will be used to fill in the pending intent template
        // that is set on the collection view in StackWidgetProvider.
        Bundle extras = new Bundle();
        extras.putInt(Codes.INTENT_EXTRA_QUOTE_ID_WIDGET, quoteId);
        Intent fillInIntent = new Intent();
        fillInIntent.putExtras(extras);
        // Make it possible to distinguish the individual on-click
        // action of a given item
        bodyView.setOnClickFillInIntent(R.id.widget_quote_frame, fillInIntent);

        return bodyView;
    }

    @Override
    public void onCreate() {

    }

    @Override
    public void onDataSetChanged() {

    }

    @Override
    public void onDestroy() {

    }

    @Override
    public int getCount() {
        return 1;
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public boolean hasStableIds() {
        return true;
    }

    @Override
    public RemoteViews getLoadingView() {
        return null;
    }

    @Override
    public int getViewTypeCount() {
        return 1;
    }

    public static boolean IsEmptyOrNull(String string) {
        if (string == null)
            return true;

        if (string.length() == 0)
            return true;

        return false;
    }

}