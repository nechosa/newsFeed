package com.example.coremodule

class Greeting {
    fun greeting(): String {
        return "Hello, ${Platform().platform}!"
    }
}