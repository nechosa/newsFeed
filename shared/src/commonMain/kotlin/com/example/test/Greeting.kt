package com.example.test

class Greeting {
    fun greeting(): String {
        return "Hello, ${Platform().platform}!"
    }
}