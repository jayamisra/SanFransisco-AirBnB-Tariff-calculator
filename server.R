library(shiny)
library("shinythemes")
lasso_private_formula<-readRDS(file = "./lasso_private.rds")
lasso_shared_formula<-readRDS(file = "./lasso_shared.rds")
lasso_home_formula<-readRDS(file = "./lasso_home.rds")

finalPrice_function <- function(room,neighbourhd,bedroomnumber,accomodation){
  if(room == 'Entire home/apartment'){
    formula<-lasso_home_formula}
  else if(room == 'Private room'){
    formula<-lasso_private_formula}
  else{
    formula <- lasso_shared_formula}

  new_data=data.frame(neighborhood =neighbourhd,
                      accommodates=accomodation,
                      bedrooms=bedroomnumber)
  fp<- predict(formula,new_data)
  return(round(fp))
}


function(input, output)
{
  final_price <- eventReactive(
    input$calculateButton,
    {finalPrice_function(input$room_type ,input$neighbourhood,input$bedroomnumber,input$accomodation)
    }
  )
  output$finalPrice <- renderText({ paste("<div class=\"panel panel-primary\">
                                            <div class=\"panel-heading\">
                                              <h3 class=\"panel-title\"> Tariff per night:</h3></div><div class=\"panel-body\">
                                              <h5>Suitable tariff for a night given the inputs entered by you</h6>
                                          <font size = 20>","$",final_price(),"</font>
                                          </div></div>")})
}
    
    
