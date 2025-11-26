package com.example.pedometer

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.widget.RemoteViews

class StepAppWidgetProvider : AppWidgetProvider() {
    override fun onUpdate(
            context: Context,
            appWidgetManager: AppWidgetManager,
            appWidgetIds: IntArray
    ) {
        updateAllWidgets(context, appWidgetManager, appWidgetIds)
    }

    companion object {
        fun updateAllWidgets(
                context: Context,
                appWidgetManager: AppWidgetManager,
                appWidgetIds: IntArray
        ) {
            val prefs =
                    context.getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
            val steps = prefs.getInt("steps", 0)

            android.util.Log.d("StepAppWidgetProvider", "updateAllWidgets: steps=$steps")
            val views =
                    RemoteViews(context.packageName, R.layout.home_widget).apply {
                        setTextViewText(R.id.txt_steps, "걸음 수: $steps")
                    }

            for (id in appWidgetIds) appWidgetManager.updateAppWidget(id, views)
        }

        fun triggerUpdate(context: Context) {
            val mgr = AppWidgetManager.getInstance(context)
            val cn = ComponentName(context, StepAppWidgetProvider::class.java)
            val ids = mgr.getAppWidgetIds(cn)
            if (ids.isNotEmpty()) updateAllWidgets(context, mgr, ids)
        }
    }
}
