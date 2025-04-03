import java.io.FileInputStream
import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "fr.gouv.agir"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.2.12479018" // [NDK default](https://github.com/actions/runner-images/blob/main/images/ubuntu/Ubuntu2404-Readme.md#android)  // flutter.ndkVersion
    externalNativeBuild {
        cmake {
            version = "3.22.1" // [CMake default](https://github.com/actions/runner-images/blob/main/images/ubuntu/Ubuntu2404-Readme.md#android) 
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "fr.gouv.agir"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            val file = rootProject.file("key.properties")
            if (file.exists()) {
                val properties = Properties().apply {
                    load(FileInputStream(file))
                }
                properties.load(FileInputStream(file))
                storeFile = file(properties.getProperty("storeFile"))
                storePassword = properties.getProperty("storePassword")
                keyAlias = properties.getProperty("keyAlias")
                keyPassword = properties.getProperty("keyPassword")
            }
        }
    }

    flavorDimensions += "default"

    productFlavors {
        create("production") {
            dimension = "default"
            manifestPlaceholders["appName"] = "J’agis"
        }
        create("development") {
            dimension = "default"
            applicationIdSuffix = ".dev2"
            manifestPlaceholders["appName"] = "[D] J’agis"
        }
        create("local") {
            dimension = "default"
            applicationIdSuffix = ".local"
            manifestPlaceholders["appName"] = "[L] J’agis"
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
            // https://github.com/flutter/flutter/issues/32756#issuecomment-846705128
            ndk {
                abiFilters.clear()
                abiFilters.addAll(listOf("armeabi-v7a", "arm64-v8a", "x86_64"))
            }
        }
        debug {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
