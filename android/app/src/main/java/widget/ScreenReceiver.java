package widget;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

public class ScreenReceiver extends BroadcastReceiver {

    //todo DataHelper data;
    QuoteAppWidget widget;

    public ScreenReceiver() {}

    public ScreenReceiver(Context context, QuoteAppWidget quoteAppWidget) {
        dataRefresh(context);
        widget = quoteAppWidget;
    }

    public void onReceive(Context context, Intent intent){
        if (intent.getAction().equals(Intent.ACTION_USER_PRESENT)) {

            //todo if (data == null)
                dataRefresh(context);

            if (/*data != null && */widget != null) {
                //todo  data.setRandomWidgetQuote();
                widget.refresh(context);
            }
        }
    }

    public void dataRefresh(Context context) {
        //todo data = DataHelper.getInstance(context);
    }

}