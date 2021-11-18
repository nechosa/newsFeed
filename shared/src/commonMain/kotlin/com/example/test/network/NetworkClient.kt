package com.example.test.network

import io.ktor.client.*
import io.ktor.client.request.*
import io.ktor.http.*
import kotlinx.serialization.decodeFromString

expect fun createHttpClient(): HttpClient

class NetworkClient {

    val httpClient = createHttpClient()

    suspend inline fun <reified T> getData(path: String): T {
        try {
            val json = httpClient.get<String> {
                url {
                    protocol = URLProtocol.HTTPS
                    host = NetworkConfig.apiUrl
                    encodedPath = path
                    header("X-Api-Key", NetworkConfig.apiKey)
                }
            }
            print(json)
            val jsonDecoder = kotlinx.serialization.json.Json { ignoreUnknownKeys = true }
            val result = jsonDecoder.decodeFromString<T>(json)
            return result
        } catch (e: Exception) {
            throw  e
        }

    }
}
