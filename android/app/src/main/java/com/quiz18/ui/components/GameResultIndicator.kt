package com.quiz18.ui.components

import androidx.compose.foundation.Canvas
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.size
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.text.SpanStyle
import androidx.compose.ui.text.buildAnnotatedString
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.withStyle
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.compose.material3.Text

@Composable
fun GameResultIndicator(rightAnswersAmount: Int, totalQuestions: Int = 18, modifier: Modifier = Modifier) {
    val progress = (rightAnswersAmount.toFloat() / totalQuestions.toFloat()).coerceIn(0f, 1f)
    val scoreColor = calculateScoreColor(rightAnswersAmount = rightAnswersAmount, totalQuestions = totalQuestions)
    Box(
        modifier = modifier.size(280.dp),
        contentAlignment = Alignment.Center,
    ) {
        Canvas(modifier = Modifier.size(280.dp)) {
            val stroke = 24.dp.toPx()
            drawArc(
                color = scoreColor.copy(alpha = 0.1f),
                startAngle = -90f,
                sweepAngle = 360f,
                useCenter = false,
                style = Stroke(width = stroke, cap = StrokeCap.Round),
            )
            drawArc(
                brush = Brush.sweepGradient(listOf(scoreColor.copy(alpha = 0.9f), scoreColor, scoreColor.copy(alpha = 0.85f))),
                startAngle = -90f,
                sweepAngle = 360f * progress,
                useCenter = false,
                style = Stroke(width = stroke, cap = StrokeCap.Round),
            )
        }

        Row(verticalAlignment = Alignment.Bottom) {
            Text(
                text = rightAnswersAmount.toString(),
                color = scoreColor,
                fontSize = 64.sp,
                fontWeight = FontWeight.ExtraBold,
            )
            Text(
                text = buildAnnotatedString {
                    withStyle(
                        style = SpanStyle(
                            color = Color(0xFFB0B0B0),
                            fontSize = 50.sp,
                            fontWeight = FontWeight.Bold,
                        ),
                    ) {
                        append("/")
                    }
                    withStyle(
                        style = SpanStyle(
                            color = Color(0xFFB0B0B0),
                            fontSize = 50.sp,
                            fontWeight = FontWeight.Bold,
                        ),
                    ) {
                        append(totalQuestions.toString())
                    }
                },
            )
        }
    }
}

private fun calculateScoreColor(rightAnswersAmount: Int, totalQuestions: Int): Color {
    val ratio = rightAnswersAmount.toDouble() / totalQuestions.toDouble()
    return when {
        ratio < 0.4 -> Color(0xFFFF3B30)
        ratio < 0.7 -> Color(0xFFFF9500)
        ratio < 0.9 -> Color(0xFFFFCC00)
        else -> Color(0xFF34C759)
    }
}
