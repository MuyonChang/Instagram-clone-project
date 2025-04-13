plugins {
    
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("kotlin-android")
    id("com.android.application")
    id("dev.flutter.flutter-gradle-plugin")

    id("com.google.gms.google-services")
    
}

android {
    namespace = "com.example.flutter_application_1"
    compileSdk = flutter.compileSdkVersion
        ndkVersion = "29.0.13113456" // 실제 설치된 NDK 버전으로 설정


    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.flutter_application_1"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 23
        targetSdk = 33
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        
        multiDexEnabled = true 
    }

    

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
  // Import the Firebase BoM
  implementation(platform("com.google.firebase:firebase-bom:33.12.0"))
  implementation("androidx.multidex:multidex:2.0.1")



  // TODO: Add the dependencies for Firebase products you want to use
  // When using the BoM, don't specify versions in Firebase dependencies
  implementation("com.google.firebase:firebase-analytics")


  // Add the dependencies for any other desired Firebase products
  // https://firebase.google.com/docs/android/setup#available-libraries
}