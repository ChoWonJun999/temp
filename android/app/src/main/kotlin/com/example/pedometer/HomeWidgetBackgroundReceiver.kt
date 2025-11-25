package com.example.pedometer

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import es.antonborri.home_widget.HomeWidgetBackgroundReceiver as PluginReceiver

/**
 * Public receiver that forwards to the plugin receiver, then refreshes our widget.
 */
class HomeWidgetBackgroundReceiver : BroadcastReceiver() {
    private val delegate = PluginReceiver()

    override fun onReceive(context: Context, intent: Intent) {
        delegate.onReceive(context, intent)
        StepAppWidgetProvider.triggerUpdate(context)
    }
}
