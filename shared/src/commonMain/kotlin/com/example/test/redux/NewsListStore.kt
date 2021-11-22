package com.example.test.redux

import com.example.test.DI
import com.example.test.data.NewsItem
import com.example.test.thread.ioDispatcher
import com.example.test.thread.uiDispatcher
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

sealed class NewsSideEffect : Effect {
    data class Error(val error: Exception) : NewsSideEffect()
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
    private val sideEffect = MutableSharedFlow<NewsSideEffect>()

    override fun data(news: List<NewsItem>) {
        dispatch(NewsAction.Data(news))
    }

    override fun refresh() {
        dispatch(NewsAction.Refresh(true))
    }


    override fun observeState(): StateFlow<NewsStoreState> = state

    override fun observeSideEffect(): Flow<NewsSideEffect> = sideEffect

    override fun observeAction(): StateFlow<NewsAction> {
        TODO("Not yet implemented")
    }

    override fun dispatch(action: NewsAction) {
        //Napier.d(tag = "FeedStore", message = "Action: $action")
        val oldState = state.value
        val newState = when (action) {
            is NewsAction.Refresh -> {
                if (oldState.progress) {
                    scope.launch { sideEffect.emit(NewsSideEffect.Error(Exception("In progress"))) }
                    oldState
                } else {
                    scope.launch { loadAllNews() }
                    oldState.copy(progress = true)
                }
            }
            is NewsAction.Data -> {
                if (oldState.progress) {
                    NewsStoreState(false, action.news)
                } else {
                    scope.launch { sideEffect.emit(NewsSideEffect.Error(Exception("Unexpected action"))) }
                    oldState
                }
            }

            is NewsAction.Error -> {
                if (oldState.progress) {
                    scope.launch { sideEffect.emit(NewsSideEffect.Error(action.error)) }
                    NewsStoreState(false, oldState.news)
                } else {
                    scope.launch { sideEffect.emit(NewsSideEffect.Error(Exception("Unexpected action"))) }
                    oldState
                }
            }
        }

        if (newState != oldState) {
            //Napier.d(tag = "FeedStore", message = "NewState: $newState")
            state.value = newState
        }
    }

    private suspend fun loadAllNews() {
        try {
            val response = withContext(ioDispatcher) { newsService.getList() }
            dispatch(NewsAction.Data(response.articles))
        } catch (e: Exception) {
            dispatch(NewsAction.Error(e))
        }
    }
}

