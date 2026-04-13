package com.quiz18.domain

import com.quiz18.data.ResourceHandler

class GameEngine(private val resourceHandler: ResourceHandler) {
    private var gameQuestions: List<Question> = emptyList()
    private var currentQuestionIndex = 0

    fun prepareGame(): Question {
        val questions = resourceHandler.loadQuestions() ?: error("Unable to load questions resource.")
        gameQuestions = questions.filter { it.difficulty == QuestionDifficulty.easy }.shuffled().take(5) +
            questions.filter { it.difficulty == QuestionDifficulty.medium }.shuffled().take(5) +
            questions.filter { it.difficulty == QuestionDifficulty.hard }.shuffled().take(5) +
            questions.filter { it.difficulty == QuestionDifficulty.hardcore }.shuffled().take(3)
        currentQuestionIndex = 0
        return gameQuestions[currentQuestionIndex]
    }

    fun nextQuestion(): Question? {
        currentQuestionIndex += 1
        return gameQuestions.getOrNull(currentQuestionIndex)
    }

    fun endGame(): Game {
        val game = Game(rightAnswersAmount = currentQuestionIndex)
        resourceHandler.saveGame(game)
        return game
    }
}
