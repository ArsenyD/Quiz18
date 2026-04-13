package com.quiz18.ui.theme

import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.darkColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color

@Composable
fun Quiz18Theme(content: @Composable () -> Unit) {
    MaterialTheme(
        colorScheme = darkColorScheme(
            primary = Color(0xFFA855F7),
            secondary = Color(0xFFA855F7),
            background = Color.Black,
            surface = Color(0xFF111111),
        ),
        content = content,
    )
}
