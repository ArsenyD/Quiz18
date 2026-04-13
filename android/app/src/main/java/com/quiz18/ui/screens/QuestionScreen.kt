package com.quiz18.ui.screens

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.quiz18.domain.Question
import com.quiz18.domain.QuestionOption
import com.quiz18.ui.components.QuestionButton
import com.quiz18.ui.components.QuestionTimer

@Composable
fun QuestionScreen(question: Question, selectedOption: QuestionOption?, timeRemaining: Int, onOptionSelected: (QuestionOption) -> Unit) {
    Column(
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center,
        modifier = Modifier.fillMaxSize().padding(horizontal = 16.dp),
    ) {
        Text(question.description, fontSize = 30.sp, fontWeight = FontWeight.Bold, lineHeight = 36.sp, textAlign = TextAlign.Center, modifier = Modifier.fillMaxWidth())
        Spacer(Modifier.height(36.dp))
        QuestionTimer(timeRemaining)
        Spacer(Modifier.height(36.dp))
        LazyVerticalGrid(columns = GridCells.Fixed(2), horizontalArrangement = Arrangement.spacedBy(10.dp), verticalArrangement = Arrangement.spacedBy(10.dp), modifier = Modifier.fillMaxWidth()) {
            items(question.options) { option -> QuestionButton(option, selectedOption, timeRemaining > 0) { onOptionSelected(option) } }
        }
    }
}
