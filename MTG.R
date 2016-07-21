if(!('rjson' %in% installed.packages())){
install.packages('rjson')
}
setwd('MTG/')

cards.db<-rjson::fromJSON(file='AllCards.json')

creat.name<-c()
creat.cost<-c()
creat.power<-c()
creat.toughness<-c()
creat.color<-c()
creat.text<-c()
for (i in cards.db){
  if (grepl("Creature", i$types)){
    creat.name <- c(creat.name, i$name)
    if(is.null(i$manaCost)){
      creat.cost <- c(creat.cost, '')
    }else{
    creat.cost <- c(creat.cost, i$manaCost)
    }
    creat.power<- c(creat.power, as.numeric(i$power))
    creat.toughness<- c(creat.toughness, as.numeric(i$toughness))
    if (is.null(i$colors)){
      creat.color <- c(creat.color, '')
    }else{
    creat.color <- c(creat.color, i$colors)}
    if (is.null(i$text)){
      creat.text <- c(creat.text, '')
      
    }else{
    creat.text <- c(creat.text, i$text)}
  }
}
creatures <- data.frame(name=creat.name, cost=creat.cost, power=creat.power, thoughness=creat.toughness,
                           color=creat.color, text=creat.text, stringsAsFactors=F)
