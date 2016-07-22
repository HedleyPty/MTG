if(!('rjson' %in% installed.packages())){
install.packages('rjson')
}
setwd('MTG/')
source('Creatures.R')
creatures <- data.frame(name=creat.name, cost=creat.cost, power=creat.power, thoughness=creat.toughness,
                        color=creat.color, text=creat.text, stringsAsFactors=F)
rm(list= grep('^(i|creat\\.)', ls(), value=T))
creatures.deck<-c()
search.creature<-function(){
  opt<-readline('Select a creature?\n1-yes\npress any other key to exit: \n\n')
  creat.nam <-creatures$name
  if (opt=="1"){
    s<-readline('Write a keyword to search a creature name: ')
    searched.creatures<-grep(s, creat.nam, value=T, ignore.case=T)
    if(length(searched.creatures)==0){
      'I have not found that creature'
      search.creature()
     }
    searched.creatures.p<-c()
    for (i in 1:length(searched.creatures)){
      searched.creatures.p <- c(searched.creatures.p, paste0(i, '-', searched.creatures[i]))      
    } 
    searched.creatures.prompt<-paste0(searched.creatures.p, collapse='\n')
    rm(searched.creatures.p)
    
    s <-readline(paste('Select a number to add a creature', searched.creatures.prompt, '\nx-select any other key to exit: '))
    selected.creature <-searched.creatures[as.numeric(s)]
    s<-readline(paste0('You have selected the creature named: "', selected.creature, '"\nWhat do you want to do:\n1-Add to the deck\n2-Select another creature\nx-Press any key to exit'))
    if (s=='1'){
      s<-readline('How many copies do you want in your deck?')
      
      creatures.deck <<- c(creatures.deck, rep(as.numeric(s),selected.creature))
      search.creature()
    }else if(s=='2'){
      search.creature()
    }else{
      'Bye!'
    }
  }
}
duel <- function(player.deck, enemy.deck){
  player.deck <- player.deck[nrow(player.deck),]
  enemy.deck <- enemy.deck[nrow(enemy.deck),]
  
  hand.player <- player.deck[1:7]
  hand.enemy <- player.enemy[1:7]
  player.deck <- player.deck[-(1:7)]
  enemy.deck <- enemy.deck[-(1:7)]
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