library(tidyverse)
library(leaflet)
library(geojsonio)
library(shiny)

##TO DO/ideas
#make differnet icons absed on type
#input for your own location/recreation type, comments etc
#different icons for each recreation type
#updated locations
#make another legend/functionality for filtering
places <- read.csv("places.csv")

# Define UI for application that draws a histogram
ui <- fluidPage(
    mainPanel(
        leafletOutput("map1", 
                      width = 1600,
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
                       label = ~NAME,
                       icon = ~map_icons[TYPE]) %>%
            addLayersControl(overlayGroups = c("Satelite", "Basemap"),
                             options = layersControlOptions(collapsed = FALSE, title = "Layers")) %>%
            hideGroup(c("Satelite"))
            
            
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
