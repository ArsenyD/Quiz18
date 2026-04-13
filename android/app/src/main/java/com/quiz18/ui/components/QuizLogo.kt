package com.quiz18.ui.components

import androidx.compose.foundation.Canvas
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.size
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

@Composable
fun QuizLogo() {
    Row(verticalAlignment = Alignment.CenterVertically) {
        Box(modifier = Modifier.size(80.dp), contentAlignment = Alignment.Center) {
            Canvas(modifier = Modifier.size(70.dp)) {
                drawArc(Color(0xFFA855F7), 90f, 331f, false, style = Stroke(width = 6.dp.toPx(), cap = StrokeCap.Round))
            }
        }
        Text("18", color = Color(0xFFA855F7), fontSize = 84.sp, fontWeight = FontWeight.ExtraBold, fontFamily = FontFamily.Monospace)
    }
}
