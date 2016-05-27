# Data types --------------------------------------------------------------
# Numeric variables (either integer or double (floating point number)):
x <- 1
x1 <- 1.54
# if you want to set a variabe explicitly to integer:
x <- 1L

# Character variables
x_chr <- "Text"
y_chr <- "Text 1"

# Logical variables
x_log <- TRUE
x_neg <- FALSE

# Date format:
x_Date <- as.Date("2010-12-25")
y_Date <- as.Date("2010-08-05")

# Examples for dates if the date format is not the standard format If the date
# (e.g. in your data) is not given in the standard format as in the two examples
# above, the user has to tell the function as.Date in which format the date is
# given. See the two examples below:
date_1 <- as.Date("25.12.2010", "%d.%m.%Y")

date_chr <- "12:25 05.08.10"
date_2 <- as.Date(date_chr, "%H:%M %d.%m.%y")

# Simple calculations with different data types
x + x1
x_chr + y_chr # This command gives an error as you cannot calculate with strings
y_Date - x_Date
x_log + x_neg

# To query the data type of a variable simply use the command typeof()
typeof(x)

# To convert between data types use the commands as....
# Here some examples:
x <- 1.23456
x_chr <- as.character(x)
x_factor <- as.factor(x_chr)
x_logic  <- as.logical(x)


# Data structures ---------------------------------------------------------

# 1D/same data type: Vectors ----------------------------------------------
# Concatination of values
v_num <- c(1,5,7,2,9)
v_chr <- c("A", "Test", "123", "Last Entry")

# Sequences of values
v_seq <- seq(1,10,1)
v_seq <- 1:10 # if the increment is 1 it can be written in this way as well
# Sequence of letters
v_chr <- LETTERS[1:10]

# Repetition of a value n times
v_rep <- rep(1,100)

# Repeating the sequence (1 to 10) 10 times
v <- rep(seq(1,10),10)
v <- rep(1:10, 10)

# Subsetting a vector
v[1] # The first value of vector v
v[seq(1,3)] # The first three values
v[c(1,5,8)] # Values a 1, 5, and 8 position
v[length(v)] # Last value in the vector


# 2D/same data type: matrices ---------------------------------------------
#Defining a matrix with 10 rows and 10 columns with vector v as data input
m_num <- matrix(data = v, nrow = 10, ncol = 10)

# Subsetting a matrix
# Similar to vectors, but here two indices are required for rows and columns
m_num[1,1] # first element
m_num[1:3,1:3] 
m_num[seq(3,1, -1),1] # Reverse order with negative increment in sequence



# 1D/different data types: Lists ------------------------------------------
# Defining a list
l_num <- list(A = v_num, B = v, C = m_num)

# Subsetting a list with the $ operator
l_num$A
l_num$C


# 2D/different data types: data frame -------------------------------------
# Defining a data frame
df <- data.frame(numbers = v_seq,
                 letters = v_chr,
                 stringsAsFactors = FALSE)

# Example subsetting a more "complex" data strucure -----------------------
# Adding whole data frame as one element in the list
l_num$dataframe <- df

# First element in the matrix "C" in the list "l_num"
l_num$C[1,1]
# Fifth element in the column "numbers" of the data frame "df" in the list "l_num"
l_num$df$numbers[5]

