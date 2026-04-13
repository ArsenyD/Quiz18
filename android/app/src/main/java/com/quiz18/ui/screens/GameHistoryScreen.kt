package com.quiz18.ui.screens

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.quiz18.domain.Game
import com.quiz18.ui.components.SecondaryButton
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale

@Composable
fun GameHistoryScreen(games: List<Game>, onBack: () -> Unit) {
    Column(Modifier.fillMaxSize().background(Color.Black)) {
        Text("Game History", fontSize = 32.sp, fontWeight = FontWeight.Bold, modifier = Modifier.padding(horizontal = 16.dp, vertical = 12.dp))
        LazyColumn(verticalArrangement = Arrangement.spacedBy(12.dp), modifier = Modifier.weight(1f).padding(horizontal = 16.dp)) {
            items(games) { GameHistoryRow(it) }
        }
        SecondaryButton("Go to menu", onBack, modifier = Modifier.padding(horizontal = 16.dp, vertical = 8.dp))
    }
}

@Composable
private fun GameHistoryRow(game: Game) {
    val date = Date(game.dateEpochMillis)
    val dateText = SimpleDateFormat("MMM d, yyyy", Locale.US).format(date)
    val timeText = SimpleDateFormat("h:mm a", Locale.US).format(date)
    Row(Modifier.fillMaxWidth().background(Color(0xFF1D1D1D), RoundedCornerShape(16.dp)).padding(16.dp)) {
        Column { Text(dateText, fontWeight = FontWeight.SemiBold); Text(timeText, color = Color.LightGray) }
        Spacer(Modifier.weight(1f))
        Column {
            Text("${game.rightAnswersAmount}", fontWeight = FontWeight.Bold, fontSize = 24.sp, color = when (game.rightAnswersAmount / 18.0) {
                in 0.0..<0.4 -> Color.Red; in 0.4..<0.7 -> Color(0xFFFF9800); in 0.7..<0.9 -> Color.Yellow; else -> Color.Green
            })
            Text("Correct", color = Color.LightGray)
        }
    }
}
