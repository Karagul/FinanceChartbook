theme_wsj <- function() {
    theme_minimal() %+replace% 
    theme(
        axis.ticks.y = element_blank(), 
        axis.ticks.length.x = unit(4, 'pt'), 
        axis.text.x = element_text(angle = 0), 
        axis.title.x = element_blank(), 
        axis.title.y = element_text(
            angle = 0, 
            margin = margin(t = 0, r = 20, b = 0, l = 0)
        ), 
        panel.grid.minor = element_blank(), 
        panel.grid.major.x = element_blank(), 
        panel.border = element_blank(), 
        plot.subtitle = element_text(
            hjust = 0.5, 
            size = 9
        ),
        plot.title = element_text(
            hjust = 0.5, 
            margin = margin(t = 0, r = 0, b = 15, l = 0)
        ),
        legend.title = element_blank()
    )
}