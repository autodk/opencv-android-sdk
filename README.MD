# Maven repository for OpenCV Android SDK

This repository contains the OpenCV Android SDK files and sources.

## How to use

### Step 1 - Add the repository

Gradle: Add the following lines to your root `build.gradle` file:

```groovy
allprojects {
    repositories {
        maven { 
            url "https://raw.githubusercontent.com/autodk/opencv-android-sdk/main" 
        }
    }
}
```

Maven:

```xml
<repositories>
    <repository>
        <id>opencv-android-sdk</id>
        <url>https://raw.githubusercontent.com/autodk/opencv-android-sdk/main</url>
    </repository>
</repositories>
```

### Step 2 - Add the dependency

Gradle: Add the following lines to your module `build.gradle` file:

```groovy
dependencies {
    implementation 'com.github.autodk:opencv-android-sdk:<version>'
}
```

Maven:

```xml
<dependencies>
    <dependency>
        <groupId>com.github.autodk</groupId>
        <artifactId>opencv-android-sdk</artifactId>
        <version>${version}</version>
    </dependency>
</dependencies>
```
