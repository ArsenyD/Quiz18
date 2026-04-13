package com.quiz18.ui.screens

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.quiz18.domain.Game
import com.quiz18.ui.components.PrimaryButton
import com.quiz18.ui.components.SecondaryButton

@Composable
fun GameResultScreen(game: Game, onPlayAgain: () -> Unit, onGoToMenu: () -> Unit) {
    Column(
        modifier = Modifier.fillMaxSize().padding(horizontal = 16.dp),
        verticalArrangement = Arrangement.Center,
        horizontalAlignment = Alignment.CenterHorizontally,
    ) {
        Text("Right Answers: ${game.rightAnswersAmount}", fontSize = 24.sp)
        Spacer(Modifier.height(24.dp))
        PrimaryButton("Play Again", onPlayAgain)
        Spacer(Modifier.height(15.dp))
        SecondaryButton("Go to menu", onGoToMenu)
    }
}
