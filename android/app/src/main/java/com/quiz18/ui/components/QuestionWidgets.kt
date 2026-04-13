package com.quiz18.ui.components

import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.quiz18.domain.QuestionOption

@Composable
fun QuestionButton(option: QuestionOption, selectedOption: QuestionOption?, enabled: Boolean, onPress: () -> Unit) {
    val color = when {
        selectedOption == null -> Color(0xFFA855F7)
        option.isCorrect -> Color(0xFF22C55E)
        selectedOption.description == option.description -> Color(0xFFEF4444)
        else -> Color(0x66A855F7)
    }
    Box(
        modifier = Modifier.fillMaxWidth().height(50.dp).background(color, RoundedCornerShape(8.dp))
            .clickable(enabled = enabled && selectedOption == null, onClick = onPress),
        contentAlignment = Alignment.Center,
    ) { Text(option.description, color = Color.White, fontWeight = FontWeight.Bold, textAlign = TextAlign.Center, modifier = Modifier.fillMaxWidth()) }
}

@Composable
fun QuestionTimer(timeRemaining: Int) {
    val progress = timeRemaining / 18f
    val ringColor = if (timeRemaining <= 5) Color.Red else Color(0xFFA855F7)
    Box(modifier = Modifier.size(220.dp), contentAlignment = Alignment.Center) {
        Canvas(modifier = Modifier.size(220.dp)) {
            drawCircle(color = Color(0x1AA855F7), style = Stroke(width = 10.dp.toPx()))
            drawArc(color = ringColor, startAngle = -90f, sweepAngle = 360f * progress, useCenter = false, style = Stroke(width = 12.dp.toPx(), cap = StrokeCap.Round))
            repeat(60) { i ->
                val tick = if (i % 5 == 0) 10.dp.toPx() else 5.dp.toPx()
                val a = Math.toRadians((i / 60f * 360f).toDouble())
                val c = size.width / 2f
                val outer = c - 5.dp.toPx()
                val inner = outer - tick
                drawLine(
                    color = Color.White.copy(alpha = if (i % 5 == 0) 0.8f else 0.3f),
                    start = Offset(c + inner * kotlin.math.sin(a).toFloat(), c - inner * kotlin.math.cos(a).toFloat()),
                    end = Offset(c + outer * kotlin.math.sin(a).toFloat(), c - outer * kotlin.math.cos(a).toFloat()),
                    strokeWidth = 2.dp.toPx(),
                )
            }
        }
        Text("$timeRemaining", color = if (timeRemaining <= 5) Color.Red else Color.White, fontSize = 64.sp, fontWeight = FontWeight.ExtraBold, fontFamily = FontFamily.Monospace)
    }
}
