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

class StepForegroundService : Service(), SensorEventListener {
    private lateinit var sensorManager: SensorManager
    private var stepSensor: Sensor? = null
    private var initialCount: Float? = null
    private val PREF = "pedometer"
    private val KEY_STEPS = "steps"

    override fun onCreate() {
        super.onCreate()
        android.util.Log.d("StepForegroundService", "onCreate: service started")
        sensorManager = getSystemService(Context.SENSOR_SERVICE) as SensorManager
        stepSensor = sensorManager.getDefaultSensor(Sensor.TYPE_STEP_COUNTER)
        createNotificationChannel()
        val n: Notification = NotificationCompat.Builder(this, "step_channel")
            .setContentTitle("걸음 수 수집 중")
            .setContentText("앱이 종료되어도 걸음 수를 수집합니다.")
            .setSmallIcon(android.R.drawable.ic_menu_compass)
            .setOngoing(true)
            .build()
        startForeground(1001, n)
        stepSensor?.let { sensorManager.registerListener(this, it, SensorManager.SENSOR_DELAY_NORMAL) }
    }

    override fun onDestroy() {
        sensorManager.unregisterListener(this)
        stopForeground(true)
        super.onDestroy()
    }

    override fun onBind(intent: Intent?): IBinder? = null

    override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {}

    override fun onSensorChanged(event: SensorEvent?) {
        if (event == null) return
        val value = event.values[0]
        if (initialCount == null) initialCount = value
        val steps = (value - (initialCount ?: value)).toInt()
        // Flutter가 읽는 SharedPreferences 파일명으로 저장
        val prefs = getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
        prefs.edit().putInt(KEY_STEPS, steps).apply()
        android.util.Log.d("StepForegroundService", "onSensorChanged: raw=$value, steps=$steps, wrote to prefs")

        StepAppWidgetProvider.triggerUpdate(this)
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val nm = getSystemService(NotificationManager::class.java)
            nm?.createNotificationChannel(
                NotificationChannel("step_channel", "걸음 수 수집", NotificationManager.IMPORTANCE_LOW)
            )
        }
    }
}
