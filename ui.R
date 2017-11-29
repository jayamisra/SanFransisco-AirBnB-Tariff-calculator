
library("shinythemes")

neighbourhoods<- readRDS(file = "./neighbourhoods.rds")
fluidPage(
  theme = "journal-custom.css",
  titlePanel(title=div(img(src="./airbnb1.jpg",height = 50,width=100),class="navbar navbar-inverse"," San Fransisco Tariff calculator" ),"San Fransisco Tariff calculator"),
  sidebarLayout( 
    
    sidebarPanel(
      h5("Please provide all of the below inputs for the property that you host or would be hosting to calculate a suitable Tariff per night: "),
      
      selectInput("room_type", '\n\nRoom Type', choices = c('Shared room','Entire home/apartment','Private Room'),selected = ""),
      selectInput("neighbourhood", 'Neighbourhood', choices = neighbourhoods,selected = ""),
      numericInput("bedroomnumber", "Number of Bedrooms:", 1,min = 0,max = 15),
      numericInput("accomodation", "Number of Guests:", 2,min=1,max=20),
      actionButton("calculateButton", "Calculate Tariff",class = "btn-primary")
    ),
    mainPanel(
      htmlOutput('finalPrice')
      
    )
  )
)
    