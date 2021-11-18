package com.example.test.network

import io.ktor.client.*
import io.ktor.client.engine.ios.*

fun HttpClientIOS()= HttpClient(Ios) {
    engine {
        configureRequest {
            //setAllo
            //CellularAcc
           // setAllowsCellularAccess(true)
        }
    }
}

actual fun createHttpClient(): HttpClient {
    return HttpClientIOS()
}