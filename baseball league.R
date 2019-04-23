install.packages("lemon")

library(tidyverse);library(ggplot2);library(directlabels);library(lemon)

names <- c("Roberto Clemente", "Frank Robinson", "Frank Howard", "Jay Johnstone", "Ken Berry", "Jim Spencer",
           "Don Kessinger", "Luis Alvarado", "Ron Santo", "Ron Swoboda", "Del Unser", "Billy Williams", "George Scott", "Rico Petrocelli", "Elli Rodriguez", "Bert Campaneris", "Thurman Munson", "Max Alvis")

preseason_hit <- c(0.400,0.375,0.360,0.340,0.310,0.310,0.280,0.260,0.240,0.240,0.220,0.220,0.225,0.225,0.220,0.200,0.175,0.155)

season_hit <- c(0.340,0.290,0.275,0.225,0.275,0.275,0.260,0.210,0.260,0.225,0.260,0.255,0.310,0.260,0.225,0.280,0.320,0.200)

shrink <- 0.265 + 0.212*(preseason_hit-0.265)

baseball_league1 <- data.frame(Player = names, Preseason = preseason_hit, Season = season_hit)

baseball_league2 <- data.frame(Player = names, Preseason = preseason_hit, Shrinked = shrink, Season = season_hit)

#absolutes differences

Preseason_diff <- baseball_league1$Preseason[1]-baseball_league1$Preseason[18]

Season_diff <- baseball_league1$Season[1]-baseball_league1$Season[18]

Preseason_diff-Season_diff

#######---Baseball plot (Preseason vs Regular Season)---######

levels(baseball_league1$Player)
baseball_league1$Player<- factor(baseball_league1$Player, levels = c("Roberto Clemente", "Frank Robinson" , "Frank Howard",
                                                                     "Jay Johnstone" ,   "Ken Berry"  ,      "Jim Spencer",
                                                                     "Don Kessinger"  ,  "Luis Alvarado"  ,  "Ron Santo",
                                                                     "Ron Swoboda"   ,   "Del Unser"   ,     "Billy Williams",
                                                                     "George Scott" ,    "Rico Petrocelli"  ,"Elli Rodriguez",
                                                                     "Bert Campaneris" , "Thurman Munson"  , "Max Alvis"))


#colorful version

p <- baseball_league1 %>% 
  gather("Season", "average_hit", -Player) %>% 
  ggplot(aes(Season,average_hit, group = Player))+
  geom_point(aes(color = Player))+
  geom_line(aes(color = Player))+
  theme_classic()+
  theme(panel.border=element_blank(),
        axis.line = element_line(), 
        axis.ticks = element_line(colour='black'),
        legend.position="none", axis.text = element_text(size = 20),
        axis.title.y = element_text(size=16,margin = margin(t = 0, r = 20, b = 0, l = 0)))+
  coord_capped_cart(bottom='both', left='both')+
  xlab("") + ylab("Batting average")

direct.label(p, "first.qp")
