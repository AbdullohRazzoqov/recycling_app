package com.recycling.mobdev

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import androidx.annotation.NonNull
import com.yandex.mapkit.MapKitFactory

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MapKitFactory.setApiKey("58195065-dfe0-45a5-b5e5-6dc940b0f9ec")
        super.configureFlutterEngine(flutterEngine)
    }
}
