library(shiny)
library(tm)
suppressPackageStartupMessages(library(googleVis))
source("Scripts/predictor.R")

shinyServer(function(input, output) {

	

output$prediction <- renderGvis({	
			if(nchar(input$text)>0)
			{
				readdata <- paste0("Datasets/",input$language,"/",input$language,input$data)
				inputvalues<-c(input$text,readdata,input$lines)

				prediction<-predictor(inputvalues[1],inputvalues[2],inputvalues[3])
				if(prediction == "no data")
				{
					V1<-as.character(c("Word Not Found","Word Not Found","Word Not Found","Word Not Found","Word Not Found","Other Words"))
					V2<-as.numeric(c(100,0,0,0,0,0))
				} else{
					total_words<-sum(prediction[,2])
					percentages <- c((prediction[1:5,2])/total_words,1-(sum(prediction[1:5,2])/total_words))

					V2 <- matrix(c(as.numeric( percentages*100 )))
					V2[is.na(V2)]<-0
					V1 <- matrix(c(as.character(prediction[1:5,1]),"Other Words"))
					V1[is.na(V1)]<-"Word Not Found"
					}
				format_prediction <- data.frame(as.character(array(V1)),as.numeric(V2))

				pie_data <- as.data.frame(format_prediction)

				pie<-gvisPieChart(pie_data, options=list(title="Word Distribution in the Sample Set",width=600, height=675, is3D=TRUE))

				output$word1 <- renderText({as.character(pie_data[1,1])})
				output$word2 <- renderText({as.character(pie_data[2,1])})
				output$word3 <- renderText({as.character(pie_data[3,1])})
				output$word4 <- renderText({as.character(pie_data[4,1])})
				output$word5 <- renderText({as.character(pie_data[5,1])})

				return(pie)

			} else{
				gvisPieChart(data.frame("After submission, the word distribution will be shown here.",100), options=list(title="Word Distribution in the Sample Set",width=600, height=675, is3D=TRUE))

				}			
		})



})