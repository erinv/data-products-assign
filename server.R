#

library(shiny)
library(ggplot2)
load("CTrips.RData")


# Begin server function
shinyServer(function(input, output) {

#Subset data based on user input & create summary table...didn't work   
#selected <-reactive({
#    isolate({
#        return(subset(ctrips_table, ctrips_table$O_county==as.numeric(input$O) & 
#                          ctrips_table$D_county==as.numeric(input$D)))
#            
#        })
#})

#Create output plot
output$plot <- renderPlot({
selected <- ctrips_table[ctrips_table$O_county==input$O & 
                             ctrips_table$D_county==input$D,]
myplot <- ggplot(data=selected, aes(x=factor(selected$trip_mode), 
                    y=selected$Trips, fill=selected$Mode))
myplot <- myplot +geom_bar(stat = "identity") +xlab("Modes") + ylab("Trips")
myplot
       
    })

#Create output table    
output$table <- renderTable({
    selected <- ctrips_table[ctrips_table$O_county==input$O &
                             ctrips_table$D_county==input$D,]
    result <- cbind(selected[, c(4:7)], Percentage =prop.table(selected$Trips))
})


# Generate a summary of the data
output$summary <- renderPrint({
    selected <- ctrips_table[ctrips_table$O_county==input$O &
                                 ctrips_table$D_county==input$D,]
    summary(selected)
    
    
})

#end of server function
})
