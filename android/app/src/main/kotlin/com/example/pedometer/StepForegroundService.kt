package com.example.pedometer

import android.app.*
import android.content.Context
import android.content.Intent
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.os.Build
import android.os.IBinder
import androidx.core.app.NotificationCompat
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale
import kotlin.math.max

class StepForegroundService : Service(), SensorEventListener {
    private lateinit var sensorManager: SensorManager
    private var stepSensor: Sensor? = null
    private var initialCount: Float? = null
    private val PREF = "pedometer"
    private val KEY_STEPS = "steps"
    private val KEY_BASE = "step_base"
    private val KEY_DATE = "step_date"
    private val dateFormat = SimpleDateFormat("yyyy-MM-dd", Locale.US)

    override fun onCreate() {
        super.onCreate()
        val prefs = getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
        val today = dateFormat.format(Date())
        val savedDate = prefs.getString(KEY_DATE, null)

        if (savedDate != today) {
            prefs.edit().remove(KEY_BASE).putString(KEY_DATE, today).putInt(KEY_STEPS, 0).apply()
        } else {
            val savedBase = prefs.getFloat(KEY_BASE, Float.NaN)
            if (!savedBase.isNaN()) initialCount = savedBase
        }

        sensorManager = getSystemService(Context.SENSOR_SERVICE) as SensorManager
        stepSensor = sensorManager.getDefaultSensor(Sensor.TYPE_STEP_COUNTER)
        android.util.Log.d("StepForegroundService", "stepSensor=$stepSensor")
        createNotificationChannel()
        val n: Notification =
                NotificationCompat.Builder(this, "step_channel")
                        .setContentTitle("걸음 수 수집 중")
                        .setContentText("??? 걸음")
                        .setSmallIcon(android.R.drawable.ic_menu_compass)
                        .setOngoing(true)
                        .build()
        startForeground(1001, n)
        stepSensor?.let {
            sensorManager.registerListener(this, it, SensorManager.SENSOR_DELAY_NORMAL)
        }
    }

    override fun onDestroy() {
        sensorManager.unregisterListener(this)
        stopForeground(true)
        super.onDestroy()
    }

    override fun onBind(intent: Intent?): IBinder? = null

    override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {}

    override fun onSensorChanged(event: SensorEvent?) {
        val value = event?.values?.get(0) ?: return
        val prefs = getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
        val today = dateFormat.format(Date())
        if (initialCount == null) {
            initialCount = value
            prefs.edit().putFloat(KEY_BASE, value).putString(KEY_DATE, today).apply()
        }

        val steps = max(0f, value - (initialCount ?: value)).toInt()

        prefs.edit().putInt(KEY_STEPS, steps).apply()
        android.util.Log.d(
                "StepForegroundService",
                "onSensorChanged[$today]: initialCount=$initialCount, steps=$steps, raw=$value"
        )

        StepAppWidgetProvider.triggerUpdate(this)
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val nm = getSystemService(NotificationManager::class.java)
            nm?.createNotificationChannel(
                    NotificationChannel(
                            "step_channel",
                            "걸음 수 수집",
                            NotificationManager.IMPORTANCE_LOW
                    )
            )
        }
    }
}
