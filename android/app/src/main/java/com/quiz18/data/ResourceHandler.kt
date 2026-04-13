package com.quiz18.data

import android.content.Context
import com.quiz18.domain.Game
import com.quiz18.domain.Question
import kotlinx.serialization.json.Json
import java.io.File

open class ResourceHandler(private val context: Context) {
    private val json = Json { ignoreUnknownKeys = true }

    open fun loadQuestions(): List<Question>? = try {
        val text = context.assets.open("Questions.json").bufferedReader().use { it.readText() }
        json.decodeFromString<List<Question>>(text)
    } catch (_: Exception) {
        null
    }

    open fun loadGames(): List<Game>? = try {
        val file = File(context.filesDir, "GameHistory.json")
        if (file.exists()) json.decodeFromString<List<Game>>(file.readText()) else null
    } catch (_: Exception) {
        null
    }

    open fun saveGame(game: Game) {
        val data = (loadGames().orEmpty() + game)
        File(context.filesDir, "GameHistory.json").writeText(json.encodeToString(data))
    }
}
