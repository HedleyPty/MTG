if(!('rjson' %in% installed.packages())){
install.packages('rjson')
}
setwd('MTG/')
cards.db<-rjson::fromJSON(file= 'AllCards.json')

### Creating a dataframe of creatures
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
    creat.color <- c(creat.color, paste0(i$colors, collapse=","))}
    if (is.null(i$text)){
      creat.text <- c(creat.text, '')
      
    }else{
    creat.text <- c(creat.text, paste0(i$text, collapse = ","))}
  }
}
creatures <- data.frame(name=creat.name, cost=creat.cost, power=creat.power, thoughness=creat.toughness,
                           color=creat.color, text=creat.text, stringsAsFactors=F)
rm(list=grep('creat\\.', ls(), value=T))

duel <- function(player.deck, enemy.deck){
  player.deck <- player.deck[nrow(player.deck),]
  enemy.deck <- enemy.deck[nrow(enemy.deck),]
  
  hand.player <- player.deck[1:7,]
  hand.enemy <- player.enemy[1:7,]
  player.deck <- player.deck[-(1:7),]
  enemy.deck <- enemy.deck[-(1:7),]
  decks <- list(player.deck, enemy.deck)
  creatures.battlefield <- list()
  lands <- list()
  cementery <- list()
  lives <- c(20, 20)
  
  while (all(lives) > 0){
   for (i in 1:2){
     mana <- 0
    #Upkeep
    #Drawing a card
   }
  }
}