import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("environment")

    productFlavors {
        create("development") {
            dimension = "environment"
            applicationId = "com.poplogic.blipin_vendor.development"
            resValue(type = "string", name = "app_name", value = "Blipin Vendor Dev")
        }
        create("staging") {
            dimension = "environment"
            applicationId = "com.poplogic.blipin_vendor.staging"
            resValue(type = "string", name = "app_name", value = "Blipin Vendor Stg")
        }
        create("production") {
            dimension = "environment"
            applicationId = "com.poplogic.blipin_vendor"
            resValue(type = "string", name = "app_name", value = "Blipin Vendor")
        }
    }

    buildFeatures.resValues = true
}