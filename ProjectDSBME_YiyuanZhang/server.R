library(shiny)
library(ggplot2)
library(ggrepel)


shinyServer(function(input, output) {
  
  LSA <- function(word,articles,topic){
    word1 <- paste("\\<",word,"\\>",sep = "")
    W <- matrix(nrow = length(word),ncol = length(articles))
    for (i in 1: length(word)){
      W[i,] <- sapply(articles,function(x) length(grep(word1[i], x)))
    }
    df <- apply(W,1,function(x) length(x[x!=0]))
    W_tfidf <- matrix(nrow = length(word),ncol = length(articles))
    for (i in 1:length(df)){
      W_tfidf[i,] <- W[i,]*log(length(articles)/df[i])
    }
    w.svd <- svd(W_tfidf) 
    t_a <- as.data.frame(w.svd$v) 
    w_t <-as.data.frame(w.svd$u)
    row.names(t_a) <- paste("A",c(1:length(articles)),sep = "")
    colnames(t_a) <- paste("Topic",c(1:10),sep = "")
    row.names(w_t) <- word
    colnames(w_t) <- paste("Topic",c(1:10),sep = "")
    p <- ggplot(t_a, aes_string(topic[1],topic[2]))+geom_point(colour = "blue", size = 3)+geom_text_repel(label=rownames(t_a),data = t_a,size = 6, hjust =1, distance = 'x')+ geom_point(data=w_t, aes_string(topic[1],topic[2]),colour = "red", size = 3)+geom_text_repel(label=rownames(w_t),data = w_t,nudge_x = 0.2,size = 6, hjust = 1 ,direction ='y')
    p <- p+ theme(
      panel.background = element_rect(fill = "lightblue",
                                      colour = "lightblue",
                                      size = 0.35, linetype = "solid"),
      panel.grid.major = element_line(size = 0.5, linetype = 'solid',
                                      colour = "white"), 
      panel.grid.minor = element_line(size = 0.25, linetype = 'solid',
                                      colour = "white")
    )
    p
  }
   
  output$`LSA Plot` <- renderPlot({
    
    
    LSA(c(input$word1,input$word2,input$word3,input$word4,input$word5,input$word6,input$word7,input$word8,input$word9,input$word10),list(readLines(input$A1),readLines(input$A2),readLines(input$A3),readLines(input$A4),readLines(input$A5),readLines(input$A6),readLines(input$A7),readLines(input$A8),readLines(input$A9),readLines(input$A10)),c(input$t1,input$t2))
    
  })
  
  output$path <- renderText({
    inFile <- input$f1
    
    if (is.null(inFile))
      return(NULL)
    
    inFile$datapath
    
  })
  
})
