package com.example.test

import com.example.test.network.NetworkClient
import com.example.test.services.NewsService

object DI {
    val networkClient by lazy {
        NetworkClient()
    }

    val newsService by lazy {
        NewsService(networkClient)
    }
}