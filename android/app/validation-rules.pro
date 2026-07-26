# https://github.com/flutter/flutter/issues/78625#issuecomment-804164524
#-keep class io.flutter.app.** { *; }
#-keep class io.flutter.plugin.** { *; }
#-keep class io.flutter.util.** { *; }
#-keep class io.flutter.view.** { *; }
#-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

-keep class io.flutter.embedding.android.FlutterActivity {*;}
-keep class io.flutter.embedding.android.FlutterSurfaceView {*;}
-keep class io.flutter.embedding.engine.FlutterEngine {*;}
-keep class io.flutter.embedding.engine.renderer.FlutterRenderer {*;}

-dontwarn io.flutter.plugins.firebase.core.FlutterFirebaseCorePlugin