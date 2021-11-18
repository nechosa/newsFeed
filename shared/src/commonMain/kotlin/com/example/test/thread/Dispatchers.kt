package com.example.test.thread

import kotlin.coroutines.CoroutineContext

expect val uiDispatcher: CoroutineContext

expect  val ioDispatcher: CoroutineContext