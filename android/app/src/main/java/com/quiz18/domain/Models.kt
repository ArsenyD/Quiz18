package com.quiz18.domain

import kotlinx.serialization.Serializable

@Serializable
data class Question(val id: Int, val description: String, val difficulty: QuestionDifficulty, val options: List<QuestionOption>)

@Serializable
data class QuestionOption(val id: Int, val description: String, val isCorrect: Boolean)

@Serializable
enum class QuestionDifficulty { easy, medium, hard, hardcore }

@Serializable
data class Game(val dateEpochMillis: Long = System.currentTimeMillis(), val rightAnswersAmount: Int)

enum class AppScreen { Main, Question, Result, History }
