# DiversityinData | July 10, 2022 | Movie Casting
# Data source is https://www.vox.com/platform/amp/2016/9/13/12889478/black-actors-typecasting


# libraries ---------------------------------------------------------------
library(tidytuesdayR)
library(tidyverse)
library(showtext)
library(ggtext)
library(treemapify)

# add font ----------------------------------------------------------------
font_add_google(name = "Ultra", family = "Ultra")
font_add_google(name = "Abel", family = "Abel")

# turn on showtext --------------------------------------------------------
showtext_auto()


# get data ----------------------------------------------------------------
df <- readr::read_csv("Movie_Character_Casting.csv", show_col_types = FALSE) %>%
  mutate(Role = str_to_upper(Role))

df %>%
ggplot(aes(area = Percent, label = Ethnicity, subgroup = Role, fill = Ethnicity, subgroup2 = Percent)) +
  geom_treemap() +
  geom_treemap_subgroup_border(color = "#f2f2f2", size = 1.5) +
  geom_treemap_subgroup2_border(color = "#f2f2f2", size = 0.75)  +
  geom_treemap_subgroup_text(place = "bottom", 
                             size = 14, 
                             color = "#000000",
                             padding.y = grid::unit(2.3, "mm"),
                             family = "Ultra") +
  geom_treemap_subgroup_text(place = "bottom", 
                             size = 14, 
                             color = "#f2f2f2",
                             padding.y = grid::unit(3, "mm"),
                             family = "Ultra") +
  geom_treemap_text(place = "top", 
                    grow = TRUE,
                    color = "#f2f2f2",
                    padding.y = grid::unit(1.3, "mm"),
                    family = "Abel") +
  scale_fill_manual(values = c("#d9632e", "#92b0b3", "#bcaf84", "#33383b")) +
  theme_void() +
  theme(plot.title = element_text(family = "Ultra", size = 38, hjust = 0.5, face = "bold"),
        plot.title.position = "plot",
        plot.subtitle = element_markdown(family = "Abel", hjust = 0.5),
        plot.caption = element_text(family = "Abel", hjust = 0.5, size = 8.5),
        legend.position = "Null",
        panel.grid = element_blank(),
        plot.margin = unit(c(1.2, 1.2, 1.2, 1.2), "cm"),
        plot.background = element_rect(color = "#f2f2f2", fill = "#f2f2f2")) +
  labs(title = "TYPECASTING",
       subtitle = "<span style = 'font-size:12pt;'>Racial disparity in the casting of gang-type roles in movies<br></span>",
       caption = "\n\nData: Vox.com | #DiversityinData | Design: Ryan Hart")
  
# save plot
ggsave(paste0("Typecasting_", format(Sys.time(), "%d%m%Y"), ".png"), dpi = 320, width = 6, height = 6)


