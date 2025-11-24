package com.example.pedometer

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.widget.RemoteViews
import io.flutter.embedding.android.FlutterActivity

class StepAppWidgetProvider : AppWidgetProvider() {
    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray) {
        updateAllWidgets(context, appWidgetManager, appWidgetIds)
    }

    companion object {
        fun updateAllWidgets(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray) {
            val prefs = context.getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
            val steps = prefs.getInt("steps", 0)
            val pkg = context.packageName
            val views = RemoteViews(pkg, R.layout.home_widget)
            views.setTextViewText(R.id.txt_steps, "걸음 수: $steps")
            for (id in appWidgetIds) {
                appWidgetManager.updateAppWidget(id, views)
            }
        }

        // 네이티브에서 호출하여 등록된 모든 위젯을 즉시 갱신
        fun triggerUpdate(context: Context) {
            val mgr = AppWidgetManager.getInstance(context)
            val cn = ComponentName(context, StepAppWidgetProvider::class.java)
            val ids = mgr.getAppWidgetIds(cn)
            if (ids.isNotEmpty()) updateAllWidgets(context, mgr, ids)
        }
    }
}
