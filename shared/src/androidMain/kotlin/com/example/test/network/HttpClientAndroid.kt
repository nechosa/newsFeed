package com.example.test.network

import io.ktor.client.*
import io.ktor.client.engine.okhttp.*

fun HttpClientAndroid()= HttpClient(OkHttp){
    engine {
        config {
            retryOnConnectionFailure(true)
        }
    }
}

actual fun createHttpClient(): HttpClient {
    return HttpClientAndroid()
}