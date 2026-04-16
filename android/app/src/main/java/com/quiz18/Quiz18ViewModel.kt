package com.quiz18

import android.content.Context
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.viewModelScope
import com.quiz18.data.ResourceHandler
import com.quiz18.domain.AppScreen
import com.quiz18.domain.Game
import com.quiz18.domain.GameEngine
import com.quiz18.domain.Question
import com.quiz18.domain.QuestionOption
import kotlinx.coroutines.Job
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch

data class Quiz18UiState(
    val screen: AppScreen = AppScreen.Main,
    val currentQuestion: Question? = null,
    val currentQuestionNumber: Int = 0,
    val selectedOption: QuestionOption? = null,
    val timeRemaining: Int = 18,
    val resultGame: Game? = null,
    val historyGames: List<Game> = emptyList(),
)

class Quiz18ViewModel(private val resourceHandler: ResourceHandler) : ViewModel() {
    private val engine = GameEngine(resourceHandler)
    private val _ui = MutableStateFlow(Quiz18UiState())
    val uiState: StateFlow<Quiz18UiState> = _ui.asStateFlow()
    private var timerJob: Job? = null

    fun startGame() {
        _ui.value = _ui.value.copy(
            screen = AppScreen.Question,
            currentQuestion = engine.prepareGame(),
            currentQuestionNumber = 1,
            selectedOption = null,
            timeRemaining = 18,
        )
        startTimer()
    }

    fun showHistory() {
        _ui.value = _ui.value.copy(screen = AppScreen.History, historyGames = resourceHandler.loadGames().orEmpty())
    }

    fun goToMain() {
        timerJob?.cancel()
        _ui.value = Quiz18UiState()
    }

    fun onOptionSelected(option: QuestionOption) {
        val s = _ui.value
        if (s.selectedOption != null || s.timeRemaining == 0) return
        _ui.value = s.copy(selectedOption = option)
        timerJob?.cancel()
        viewModelScope.launch {
            if (option.isCorrect) {
                delay(500)
                val next = engine.nextQuestion()
                if (next == null) endGame() else {
                    _ui.value = _ui.value.copy(
                        currentQuestion = next,
                        currentQuestionNumber = _ui.value.currentQuestionNumber + 1,
                        selectedOption = null,
                        timeRemaining = 18,
                    )
                    startTimer()
                }
            } else {
                delay(1000)
                endGame()
            }
        }
    }

    fun onHistoryBack() = goToMain()

    private fun startTimer() {
        timerJob?.cancel()
        timerJob = viewModelScope.launch {
            while (_ui.value.timeRemaining > 0) {
                delay(1000)
                if (_ui.value.selectedOption != null) return@launch
                _ui.value = _ui.value.copy(timeRemaining = _ui.value.timeRemaining - 1)
            }
            endGame()
        }
    }

    private fun endGame() {
        timerJob?.cancel()
        _ui.value = _ui.value.copy(
            screen = AppScreen.Result,
            resultGame = engine.endGame(),
            currentQuestion = null,
            currentQuestionNumber = 0,
            selectedOption = null,
            timeRemaining = 0,
        )
    }

    class Factory(private val context: Context) : ViewModelProvider.Factory {
        @Suppress("UNCHECKED_CAST")
        override fun <T : ViewModel> create(modelClass: Class<T>): T = Quiz18ViewModel(ResourceHandler(context.applicationContext)) as T
    }
}
