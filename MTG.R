if(!('rjson' %in% installed.packages())){
install.packages('rjson')
}
if (getwd()!= '/home/hedley/MTG'){
  setwd('MTG/')}
source('Creatures.R')
creatures <- data.frame(name=creat.name, cost=creat.cost, power=creat.power, thoughness=creat.toughness,
                        color=creat.color, text=creat.text, stringsAsFactors=F)
rm(list= grep('^(i|creat\\.)', ls(), value=T))

player.deck<-c()
enemy.deck<-c()
search.creature <<-function(deck){
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
      
      deck <<- c(deck, rep(as.numeric(s),selected.creature))
      search.creature()
    }else if(s=='2'){
      search.creature()
    }else{
      'Bye!'
    }
  }
}
adding.lands<-function(deck){
  opt<-readline('Which basic land do you want to add to your deck? (pick a number)\n1-Plains\n2-Mountains\n3-Swamps\n4-Forests\n5-Islands\nx-Select any other option to exit: ')
  if(opt=='1'){
    opt<-readline('How many Plains do you want to have in your deck?: ')
    if (grepl('\\d+', opt)){
      deck <<-c(deck, rep('{W}', as.numeric(opt)))
      opt <-readline('Do you want to select any other type of land? (pick a number)\n1-yes\nx-Press any other key to exit: ')
      if (opt=='1')
        adding.lands()
    }else if(opt=='2'){
      opt<-readline('How many Mountains do you want to have in your deck?: ')
      if (grepl('\\d+', opt)){
        deck <<-c(deck, rep('{R}', as.numeric(opt)))
        opt<-readline('Do you want to select any other type of land? (pick a number)\n1-yes\nx-Press any other key to exit: ')
        if (opt=='1')
          adding.lands()
      }
    }else if(opt=='3'){
      opt<-readline('How many Swamps do you want to have in your deck?: ')
      if (grepl('\\d+', opt)){
        deck <<-c(deck, rep('{B}', as.numeric(opt)))
        opt<-readline('Do you want to select any other type of land? (pick a number)\n1-yes\nx-Press any other key to exit: ')
        if (opt=='1')
          adding.lands()
      }
    }else if(opt=='4'){
      opt<-readline('How many Forests do you want to have in your deck?: ')
      if (grepl('\\d+', opt)){
        deck <<-c(deck, rep('{G}', as.numeric(opt)))
        opt<-readline('Do you want to select any other type of land? (pick a number)\n1-yes\nx-Press any other key to exit: ')
        if (opt=='1')
          adding.lands()
      }else if(opt=='5'){
        opt<-readline('How many Islands do you want to have in your deck?: ')
        if (grepl('\\d+', opt)){
          deck <<-c(deck, rep('{U}', as.numeric(opt)))
          opt<-readline('Do you want to select any other type of land? (pick a number)\n1-yes\nx-Press any other key to exit: ')
          if (opt=='1')
            adding.lands()
        }
      }
    }
}
}
duel <- function(player.deck, enemy.deck){
  player.deck <- player.deck[sample(1:length(player.deck), n=length(player.deck), replace = F)]
  enemy.deck  <- enemy.deck[sample(1:length(enemy.deck), n=length(enemy.deck), replace=F)]
  
  hand.player <- player.deck[1:7]
  hand.enemy <- player.enemy[1:7]
  hands<-list(hand.player, hand.enemy)
  player.deck <- player.deck[-(1:7)]
  enemy.deck <- enemy.deck[-(1:7)]
  decks <- list(player.deck, enemy.deck)
  creatures.battlefield <- list(c(), c())
  creatures.tapped <- list(c(), c())
  lands <- list(c(), c())
  lands.tapped <- list(c(), c())
  cementery <- list()
  lives <- c(20, 20)
  
  while (all(lives) > 0){
   for (i in 1:2){
    mana <- c(0,0)
    #Upkeep
    #Untap
    for (x in creatures.tapped){
      if(length(x) > 0){
        for (j in 1:length(x))
        {
          x[j]<-F
        }
      }
    }
    for (w in lands.tapped){
      if(length(w) > 0){
        for (j in 1:length(w))
        {
          w[j]<-F
        }
      }
    }
    rm(list=c('x','w'))
    #Drawing a card
    hands[[i]]<-c(hands[[i]], decks[[i]][1])
    decks[[i]]<- decks[[i]][-1]
    if (any(grepl('Land: ', hands[[i]]))){
      l<-min(grep('Land: ', hands[[i]]))
      lands[[i]]<- c(lands[[i]], hands[[i]][l]  )
      hands[[i]]<-hands[[i]][-l]
      lands.tapped[[i]]<-c(lands.tapped[[i]], F)
    }
   }
  }
}
