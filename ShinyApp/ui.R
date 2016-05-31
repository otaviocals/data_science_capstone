library(shiny)
library(tm)
suppressPackageStartupMessages(library(googleVis))
shinyUI(fluidPage(

  titlePanel("Word Predictor - Data Science Capstone Project"),

  sidebarLayout(
    sidebarPanel(
	p("This app takes as input a string sequence and outputs the most likely words that appear after it.
	It does so by analyzing datasets sampled from Twitter, news posts and blog posts.
	The datasets are avaiable in English, German, Russian and Finnish. "),

      textInput("text","Text to predict the next word:"),
	selectInput("language","Language to read:",
			c("English"="en_US",
			"German"="de_DE",
			"Russian" = "ru_RU",
			"Finnish" = "fi_FI"
			)
			),
	selectInput("data","Data to read:",
			c("Twitter"=".twitter.txt",
			"News"=".news.txt",
			"Blog Posts" = ".blogs.txt"
			)
			),
	numericInput("lines","Number of lines to sample from:",value = 0,min = 0,max = 1000000000000),
	h5("Obs.: Leave at 0 to sample all the lines from the dataset.",style="display: inline;"),
	br(),
	h4("Warning",style="display: inline;"),h5(": A greater number of lines to sample leads to longer computation time.",style="display: inline;"),
	br(),
	h5("Recommended: ~10000 lines.",style="display: inline;"),
	br(),
	br(),
	submitButton("Submit")
    ),


    mainPanel(
	h3("The most likely next word is, in order of likelihood:"),

	h3("1:",style="display: inline-block;"),h4(textOutput("word1"),style="display: inline-block;"),
	br(),
	h3("2:",style="display: inline-block;"),h4(textOutput("word2"),style="display: inline-block;"),
	br(),
	h3("3:",style="display: inline-block;"),h4(textOutput("word3"),style="display: inline-block;"),
	br(),
	h3("4:",style="display: inline-block;"),h4(textOutput("word4"),style="display: inline-block;"),
	br(),
	h3("5:",style="display: inline-block;"),h4(textOutput("word5"),style="display: inline-block;"),

      htmlOutput("prediction")
    )
  )
))