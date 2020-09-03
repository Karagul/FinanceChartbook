plt <- function(
    series, 
    start_date, 
    unit, 
    recession_dates, 
    ylabel="", 
    labels=NA, 
    ...
) {
#' Plot one or several series and include recession shading, and both 
#' a long term and shorter term view of the data 

#' @param: series     : character vector  =>  st louis fred codes 
#' @param: start_date : character         =>  date to start 
#' @param: unit       : character         =>  fredr code e.g. 'pcl' or 'lin'
#' @param: recession_dates: tibble        =>  result from 'get_recessions()' 
#' @param: ylabel     : character         
#' @param: labels     : named character vector 
    
    today <- as.Date(Sys.time())
    short_date <- today - 365
    data <- get_data(series, start_date, unit)
    
    # Plot the long range series
    long_plt <- ggplot() +
        geom_rect(data=recession_dates, 
            mapping=aes(xmin=start, xmax=end, ymin=-Inf, ymax=Inf),
            fill="grey", alpha=.75) + 
        geom_line(data=data, mapping=aes(date, value, color=series_id)) +
        geom_hline(yintercept = 0, color = "darkgrey") +
        scale_y_continuous(
            labels = label_wsj(accuracy = 1, ...)
        ) +
        labs(y=ylabel) +
        theme_wsj() + 
        theme(
            legend.position = "none"
        )
    
    # Plot the short range series
    short_plt <- ggplot() +
        geom_rect(data=recession_dates, 
            mapping=aes(xmin=start, xmax=end, ymin=-Inf, ymax=Inf),
            fill="grey", alpha=.75) + 
        geom_line(data=data, mapping=aes(date, value, color=series_id)) +
        geom_hline(yintercept = 0, color = "darkgrey") +
        scale_y_continuous(
            labels = scales::label_comma(accuracy = 1)
        ) +
        scale_x_date(limits = c(short_date, today), date_labels = "%b") +
        theme_wsj() + 
        theme (
            axis.title.y = element_blank()
        )
        
    if (!is.na(labels)) {
        short_plt <- short_plt + 
            scale_color_discrete(name = '', breaks = waiver(), labels = labels) + 
            theme(legend.title = element_blank())
    } else {
        short_plt <- short_plt + 
            theme(legend.position = "none") 
    }
    return(grid.arrange(long_plt, short_plt, ncol=2))
}

get_data <- function(series, start_date, unit) {
#' Recurrsively get all the series in the list 
#' 
#' @param: series      : character vector of fredr series names
#' @param: start_date  : character 
#' @param: unit        : character
    
    # if only one series, return data from fredr
    if (length(series) == 1) {
        data <- fredr(series_id = series, 
                    observation_start = start_date, 
                    units = unit)
        return(data[!is.na(data$value),])
    }
    # otherwise, split the names into two groups 
    # and stack them i.e. bind_rows 
    else {
        s1 <- series[1]
        s2 <- series[2:length(series)]
        t1 <- get_data(s1, start_date, unit)
        t2 <- get_data(s2, start_date, unit) 
        return(bind_rows(t1, t2))
    }
}

get_recessions <- function(start_date, rec_series="USRECM") {
#' Get recession start and end dates and return as tibble 
    
    rec_dates <- fredr(rec_series, observation_start = start_date)
    nrows     <- nrow(rec_dates)
    stopifnot(nrows > 1)
        
    start_rec <- c() 
    end_rec   <- c()
    for (i in 1:(nrows-1)) {
        curr <- rec_dates$value[[i]]
        nxt  <- rec_dates$value[[i+1]]
        
        # start of recession 
        # curr ISNT recession, but nxt IS recession
        if (curr == 0 && nxt == 1) {
            d <- as.Date(rec_dates$date[[i + 1]])
            start_rec <- append(start_rec, d)
        }
        # end of recession
        # if curr IS recession, but next ISNT recession
        else if (curr == 1 && nxt == 0) {
            d <- as.Date(rec_dates$date[[i]])
            end_rec <- append(end_rec, d)
        }
        # still in a recession
        # add today as the end to make the recession rectangle
        else if (curr == 1 && nxt == 1 && i == nrows - 1) {
            d <- Sys.Date()
            end_rec <- append(end_rec, d)
        }
    }
    stopifnot(length(start_rec) == length(end_rec))
    return (tibble(start = start_rec, end = end_rec))
}