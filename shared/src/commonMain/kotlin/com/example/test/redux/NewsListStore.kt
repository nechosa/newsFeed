package com.example.test.redux

import com.example.test.DI
import com.example.test.data.NewsItem
import com.example.test.thread.ioDispatcher
import com.example.test.thread.uiDispatcher
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

sealed class NewsSideEffect : Effect {
    data class Error(val error: String):NewsSideEffect()
}

class NewsListStore : Store<NewsStoreState,NewsAction,NewsSideEffect>,NewsActionType {
    private val scope: CoroutineScope
    val newsService by lazy {
        DI.newsService
    }

    init {
        val job = SupervisorJob()
        scope = CoroutineScope(uiDispatcher + job)
    }

    private val state = MutableStateFlow<NewsStoreState>(NewsStoreState(false, emptyList()))


    override fun data(news: List<NewsItem>) {
        dispatch(NewsAction.Data(news))
    }

    override fun refresh() {
        dispatch(NewsAction.Refresh(true))
    }


    override fun observeState(): StateFlow<NewsStoreState> {
        return state
    }

    override fun observeSideEffect(): StateFlow<NewsSideEffect> {
        TODO("Not yet implemented")
    }

    override fun observeAction(): StateFlow<NewsAction> {
        TODO("Not yet implemented")
    }

    override fun dispatch(action: NewsAction) {
        val oldState = state.value
        val newState = when (action) {
            is NewsAction.Refresh -> {
                loadNews()
                oldState
            }
            is NewsAction.Data -> {
                NewsStoreState(false, action.news)
            }
        }
        state.value = newState as NewsStoreState
    }

    fun loadNews() {
        scope.launch {
            val response = withContext(ioDispatcher) { newsService.getList() }
            dispatch(NewsAction.Data(response.articles))
        }
    }
}
