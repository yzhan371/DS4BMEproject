library(shiny)
library(shinythemes)

shinyUI(fluidPage(theme = shinytheme("darkly"),
                  
tabsetPanel(
  tabPanel("Main App",
  headerPanel("LSA"),
  
  flowLayout(
    
    wellPanel(
       h5("Put the words in following cells"),
       textInput('word1','Word 1','calculus'),
       textInput('word2','Word 2','relativity'),
       textInput('word3','Word 3','statistics'),
       textInput('word4','Word 4','psychology'),
       textInput('word5','Word 5','biology'),
       textInput('word6','Word 6','quantum'),
       textInput('word7','Word 7','computer'),
       textInput('word8','Word 8','mathematics'),
       textInput('word9','Word 9','physics'),
       textInput('word10','Word 10','theory'),
       submitButton('Start LSA') 
    
    ),
    
    wellPanel(
      h5("Put the articles in following cells"),
      textInput('A1','Article 1','https://en.wikipedia.org/wiki/Isaac_Newton'),
      textInput('A2','Article 2','https://en.wikipedia.org/wiki/Albert_Einstein'),
      textInput('A3','Article 3','https://en.wikipedia.org/wiki/Alan_Turing'),
      textInput('A4','Article 4','https://en.wikipedia.org/wiki/Sigmund_Freud'),
      textInput('A5','Article 5','https://en.wikipedia.org/wiki/Ronald_Fisher'),
      textInput('A6','Article 6','https://en.wikipedia.org/wiki/Leonardo_da_Vinci'),
      textInput('A7','Article 7','https://en.wikipedia.org/wiki/Charles_Darwin'),
      textInput('A8','Article 8','https://en.wikipedia.org/wiki/Max_Planck'),
      textInput('A9','Article 9','https://en.wikipedia.org/wiki/Carl_Friedrich_Gauss'),
      textInput('A10','Article 10','https://en.wikipedia.org/wiki/Nikola_Tesla'),
      textInput('t1','Topics for X Axis, Enter Topic#','Topic1'),
      textInput('t2','Topics for Y Axis, Enter Topic#','Topic2')
      
    ),
    
    
    
    mainPanel(
       plotOutput("LSA Plot",width = 1200,height = 1000)
    )
  )),
  tabPanel('File Path Generator',
           fileInput('f1','Upload Local File'),
           textOutput('path')
           ),
  tabPanel("User Instruction",
           h1('Input Instruction'),
           p('The function of this app is to perfom a latent semantic analysis (LSA) on 10 words and 10 articles.
             The inputs for the first column are ten words that are at least appear in one of the ten articles and ten articles of your choice.
             Type either the local address or the URL of the articles into the second column. Then, type in the topic number that you wish to plot.
             The maximum topic number is 10 in this app. Noted that error message may occur if you input the mis-spelling word.
             Also, if the word does not appear in any of the articles or appears in every articles, an error may also arise.'),
           
           h1('Output Interpretation'),
           p('The output is plotted for both word and articles. The euclidian distance between the two dots indicates how similar or related the two are. 
             This relationship apply to all pairs: word-word, article, article. The coordinate of vector from the origin indicates how close the word or the article to
             the latent topics. And by cosine similarity we can assess how close each word or article are to each other regarding the topic.'),
           p('For local file, you can use File Path Generator to upload the file and copy the generated path to the main panel.')
           
           )
           
)))
