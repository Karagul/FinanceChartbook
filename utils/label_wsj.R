label_wsj <- function(
    prefix = "% ", suffix = '', rm.bottom = TRUE, ...
) {
#' @description label plots like the wall street journal 
#' i.e. put the units only on the top tick of the graph
#' 
#' @param breaks ~ the axis marks for the graphs to label 
#' @param unit   ~ the unit label to include on the max number 
#' @param remove.lowest ~ logical, remove the lowest number? 

    function(x) do_wsj_label(
        x, prefix, suffix, rm.bottom, ...
    )
}

do_wsj_label <- function(
    breaks, prefix, suffix, rm.bottom, ...
) {
#' @description label plots like the wall street journal 
#' i.e. put the units only on the top tick of the graph
#' 
#' @param breaks ~ the axis marks for the graphs to label 
#' @param unit   ~ the unit label to include on the max number 
#' @param remove.lowest ~ logical, remove the lowest number? 

    max_break <- which.max(breaks)
    
    breaks_with_commas <- scales::label_comma(...)(breaks)
    max_num <- breaks_with_commas[ max_break ]
    
    if (rm.bottom) {
        breaks_with_commas[ 1] <- ''
    }
    breaks_with_commas[ max_break] <- paste0(prefix, max_num, suffix)
    
    wsj_labels <- breaks_with_commas 
    return(wsj_labels)
}
