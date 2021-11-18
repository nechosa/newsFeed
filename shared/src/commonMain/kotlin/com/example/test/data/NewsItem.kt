package com.example.test.data

import kotlinx.serialization.Serializable

@Serializable
data class NewsItem(
    var author: String?,
    var title: String?,
    var description: String?,
    var url: String?,
    var urlToImage: String?,
    var content: String?,
    var publishedAt: String
)

@Serializable
data class NewsList(
    var articles: List<NewsItem>
)