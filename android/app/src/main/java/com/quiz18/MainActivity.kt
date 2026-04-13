package com.quiz18

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.activity.viewModels
import com.quiz18.ui.Quiz18App
import com.quiz18.ui.theme.Quiz18Theme

class MainActivity : ComponentActivity() {
    private val viewModel: Quiz18ViewModel by viewModels {
        Quiz18ViewModel.Factory(applicationContext)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            Quiz18Theme { Quiz18App(viewModel) }
        }
    }
}
