package com.quiz18.ui

import androidx.activity.compose.BackHandler
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.WindowInsets
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.safeDrawing
import androidx.compose.material3.Scaffold
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import com.quiz18.Quiz18ViewModel
import com.quiz18.domain.AppScreen
import com.quiz18.ui.screens.GameHistoryScreen
import com.quiz18.ui.screens.GameResultScreen
import com.quiz18.ui.screens.MainScreen
import com.quiz18.ui.screens.QuestionScreen

@Composable
fun Quiz18App(viewModel: Quiz18ViewModel) {
    val state by viewModel.uiState.collectAsState()
    BackHandler(enabled = state.screen != AppScreen.Main) { if (state.screen == AppScreen.History) viewModel.onHistoryBack() }
    Scaffold(contentWindowInsets = WindowInsets.safeDrawing, containerColor = Color.Black) { padding ->
        Box(Modifier.fillMaxSize().background(Color.Black).padding(padding)) {
            when (state.screen) {
                AppScreen.Main -> MainScreen(viewModel::startGame, viewModel::showHistory)
                AppScreen.Question -> state.currentQuestion?.let { QuestionScreen(it, state.selectedOption, state.timeRemaining, viewModel::onOptionSelected) }
                AppScreen.Result -> state.resultGame?.let { GameResultScreen(it, viewModel::startGame, viewModel::goToMain) }
                AppScreen.History -> GameHistoryScreen(state.historyGames, viewModel::onHistoryBack)
            }
        }
    }
}
