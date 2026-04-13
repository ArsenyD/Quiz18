package com.quiz18.ui.screens

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.quiz18.ui.components.PrimaryButton
import com.quiz18.ui.components.QuizLogo
import com.quiz18.ui.components.SecondaryButton

@Composable
fun MainScreen(onPlay: () -> Unit, onStatistics: () -> Unit) {
    Column(
        modifier = Modifier.fillMaxSize().padding(horizontal = 16.dp),
        verticalArrangement = Arrangement.SpaceBetween,
        horizontalAlignment = Alignment.CenterHorizontally,
    ) {
        Spacer(Modifier.height(1.dp))
        Column(horizontalAlignment = Alignment.CenterHorizontally) {
            QuizLogo()
            Spacer(Modifier.height(50.dp))
            PrimaryButton("Play", onPlay)
            Spacer(Modifier.height(12.dp))
            SecondaryButton("Statistics", onStatistics)
        }
        Spacer(Modifier.height(1.dp))
    }
}
