library(tidyverse)
library(leaflet)
library(geojsonio)
library(shiny)
places <- read.csv("places.csv")

# Define UI for application that draws a histogram
ui <- fluidPage(
    mainPanel(
        leafletOutput("map1", 
                      width = 1800,
                      height = 1000
                      )
        ) #end of tabpanel
) #end of navbar page

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$map1 <- renderLeaflet({
        places %>%
            leaflet() %>%
            addTiles(group = "Basemap") %>%
            addProviderTiles('Esri.WorldImagery', group = "Satelite") %>%
            addMarkers(lat = ~LAT, lng = ~LONG, 
                       #popup = NOTES,
                       label = ~NAME) %>%
            addLayersControl(overlayGroups = c("Satelite", "Basemap"),
                             options = layersControlOptions(collapsed = FALSE, title = "Layers"))
            
            
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
