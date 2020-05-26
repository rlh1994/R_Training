make_challenge_data <- function(){
    library(png)
    
    ima <- readPNG("Image_Challenge/image1.png")
    dims <- dim(ima)
    pts <- matrix(c(rep(1:dims[1], dims[2]), rep(1:dims[2], each = dims[1])),byrow = FALSE, ncol = 2)
    
    #pick out only the points that are gray (on outline)
    pts <- pts[sapply(1:(dims[1]*dims[2]),
                      function(x){
                        ima[pts[x,1],pts[x,2],4]>0.5 &
                          ima[pts[x,1],pts[x,2],4] < 0.8
                      }),]
    
    samp <- sample(x=1:nrow(pts), size = 5000, replace = TRUE)
    
    ptsflipped <- cbind(x = pts[samp, 2], y=dims[2]-pts[samp, 1])
    
    # now add a bunch of random noise
    xynorm <- round(cbind(x = rnorm(n = 20000, mean = 500, sd = 500),
                          y = rnorm(n = 20000, mean = 500, sd = 500)), 0)
    
    xydata <- rbind(xynorm, ptsflipped)
    
    n <- nrow(xydata)
    
    #reorder rows to hide the data
    samp2 <- sample(x = 1:n, size = n, replace = FALSE)
    xydata <- xydata[samp2,]
  
    return(data.frame(xydata))
}
