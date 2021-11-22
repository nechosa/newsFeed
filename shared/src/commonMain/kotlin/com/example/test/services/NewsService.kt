package com.example.test.services

import com.example.test.data.NewsList
import com.example.test.network.NetworkClient

class NewsService(private val client: NetworkClient) {

    suspend fun getList(): NewsList {
        return client.getData<NewsList>(NEWS_URL)
    }


    companion object Url {
        const val NEWS_URL = "v2/top-headlines?language=en"
    }
}