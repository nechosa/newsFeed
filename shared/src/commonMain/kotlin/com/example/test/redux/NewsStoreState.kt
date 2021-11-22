package com.example.test.redux

import com.example.test.data.NewsItem

data class NewsStoreState(
    var progress: Boolean,
    var news: List<NewsItem>,
    var item: NewsItem? = null
): StoreState

sealed class NewsAction : Action {
    data class Refresh(val needRefresh : Boolean):NewsAction()
    data class Data(val news: List<NewsItem>):NewsAction()
    data class Error(val error: Exception) : NewsAction()
}

interface NewsActionType {
    fun data(news: List<NewsItem>)

    fun refresh()
}