install.packages('ggwordcloud')

library(data.table)
library(wordcloud2)

d = fread("./Data/2026_countries.csv")

wordcloud2(d)


wordcloud2(d, size = 1, minSize = 0, gridSize =  0,
    fontFamily = 'Segoe UI', fontWeight = 'normal',
    color = 'random-dark', backgroundColor = "white",
    minRotation = -pi/4, maxRotation = pi/4, shuffle = FALSE,
    rotateRatio = 0.4, shape = 'circle', ellipticity = 0.65,
    widgetsize = NULL, figPath = NULL, hoverFunction = NULL)


library(ggwordcloud)

p <- ggplot(d, aes(
  label = country,
  size = count
)) +
  geom_text_wordcloud_area(color = "grey90", grid_margin = 3) +
  scale_size_area(max_size = 20) +
  theme_void() +
  theme(
    plot.background  = element_rect(fill = "transparent", colour = NA),
    panel.background = element_rect(fill = "transparent", colour = NA)
  )

ggsave(
  "Output/wordcloud_v2.png",
  plot = p,
  #width = 20,
  #height = 12,
  #units = "cm",
  dpi = 300,
  bg = "transparent"
)
