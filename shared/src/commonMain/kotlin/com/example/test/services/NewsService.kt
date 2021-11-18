package com.example.test.services

import com.example.test.data.NewsList
import com.example.test.network.NetworkClient

class NewsService(val networkClient: NetworkClient) {

    suspend fun getList(): NewsList {
        return networkClient.getData<NewsList>(NEWS_URL)
    }


    companion object Url {
        const val NEWS_URL = "v2/top-headlines?language=en"
    }
}