# Keep all Flutter plugin registrants
-keep class io.flutter.plugins.** { *; }

# Keep Firebase core plugin
-keep class io.flutter.plugins.firebase.core.** { *; }

# Keep all Firebase SDK classes
-keep class com.google.firebase.** { *; }

# Keep Google Play services classes
-keep class com.google.android.gms.** { *; }

# Prevent stripping of Flutter engine classes
-keep class io.flutter.embedding.engine.** { *; }

# Keep generated plugin registrant
-keep class io.flutter.plugins.GeneratedPluginRegistrant { *; }
