package com.quiz18.ui.screens

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import com.quiz18.R
import com.quiz18.domain.Game
import com.quiz18.ui.components.GameResultIndicator
import com.quiz18.ui.components.PrimaryButton
import com.quiz18.ui.components.SecondaryButton

@Composable
fun GameResultScreen(game: Game, onPlayAgain: () -> Unit, onGoToMenu: () -> Unit) {
    Column(
        modifier = Modifier.fillMaxSize().padding(horizontal = 16.dp, vertical = 12.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
    ) {
        Spacer(Modifier.weight(1f))
        GameResultIndicator(rightAnswersAmount = game.rightAnswersAmount)
        Spacer(Modifier.weight(1f))
        PrimaryButton(stringResource(R.string.play_again_button), onPlayAgain, modifier = Modifier.fillMaxWidth())
        Spacer(Modifier.height(15.dp))
        SecondaryButton(stringResource(R.string.go_to_menu_button), onGoToMenu, modifier = Modifier.fillMaxWidth())
        Spacer(Modifier.height(8.dp))
    }
}
