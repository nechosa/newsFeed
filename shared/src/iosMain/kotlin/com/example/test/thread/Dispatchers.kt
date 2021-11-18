package com.example.test.thread

import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.Runnable
import kotlin.coroutines.CoroutineContext
import kotlin.native.concurrent.freeze

actual val uiDispatcher: CoroutineContext = MainDispatcher

actual  val ioDispatcher: CoroutineContext = MainDispatcher


@ThreadLocal
object MainDispatcher : CoroutineDispatcher() {
    override fun dispatch(context: CoroutineContext, block: Runnable) {
        try {
            block.run().freeze()
        }
        catch (e: Exception) {
            throw  e
        }
    }
}