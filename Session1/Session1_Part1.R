x <- 1
x1 <- 1.54
x_chr <- "Text"
y_chr <- "Text 1"
x_log <- TRUE
x_neg <- FALSE
x_Date <- as.Date("2010-12-25")
y_Date <- as.Date("2010-08-05")

x + x1
#x_chr + y_chr
y_Date - x_Date
x_log + x_neg

typeof(x)
x <- 1L

v_num <- c(1,5,7,2,9)
v_seq <- seq(1,10,1)
v_rep <- rep(1,100)
v <- rep(seq(1,10),10)
v[1]
v[seq(1,3)]
v[c(1,5,8)]
v[length(v)]
m_num <- matrix(data = v, 10, 10)
m_num[1,1]
m_num[1:3,1:3]
m_num[seq(3,1, -1),1]

l_num <- list(A = v_num, B = v, C = m_num)

l_num$A
l_num$C

v_chr <- LETTERS[1:10]

df <- data.frame(numbers = v_seq,
                 letters = v_chr,
                 stringsAsFactors = FALSE)

l_num$df <- df
l_num$dataframe <- df
l_num$C[1,1]
l_num$df$numbers[5]

