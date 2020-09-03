theme_wsj <- function() {
    theme_minimal() %+replace% 
    theme(
        axis.text.x = element_text(angle = 0), 
        axis.title.x = element_blank(), 
        axis.title.y = element_text(
            angle = 0, 
            margin = margin(t = 0, r = 20, b = 0, l = 0)
        ), 
        axis.ticks.y = element_blank(), 
        axis.ticks.x = element_line(),
        axis.ticks.length.x = unit(4, 'pt'), 
        panel.grid.minor = element_blank(), 
        panel.grid.major.x = element_blank(), 
        panel.spacing = unit(.5, "lines"),
        plot.subtitle = element_text(
            hjust = 0.5, 
            size = 9
        ),
        plot.title = element_text(
            hjust = 0.5, 
            margin = margin(t = 0, r = 0, b = 15, l = 0)
        ),
        strip.text.y = element_text(
            size = 8,
            margin = margin(t = 0, r = 0, b = 0, l = 0),
            angle = -90
        ),
        legend.title = element_blank(), 
        plot.caption = element_text(
            hjust = 0, 
            size = 8, 
            margin = margin(
                t = 15, r = 0, b = 0, l = 0
            ),
        )
    )
}
