library(httr)

# Problem 1 requires setting up a github OAuth application, and 
# using it to access the instructor's repos.
# We will use the httr package to interface with this API

oauth_endpoints("github")

myapp <- oauth_app("github",
                   key = "5c0e735be15dabbe3e27",
                   secret = "5a37b88aed8710eb39f97ceaa872f4ec231205d9")

github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

gtoken <- config(token = github_token)
req <- GET("https://api.github.com/rate_limit", gtoken)
stop_for_status(req)
content(req)


# Problem 4 requires that we read in an html page, and check specific
# line numbers. We can open a connection to this page with url

page <- url("http://biostat.jhsph.edu/~jleek/contact.html")
lines <- readLines(page)

# Now we have a character vector with each element corresponding to one
# line of the html file. We want the 10, 20, 30, and 100th lines.
nchar(lines[10])
nchar(lines[20])
nchar(lines[30])
nchar(lines[100])


# Problem 5 asks that we read in a fixed-width format file, which we
# can do using read.fwf. We will first open a connection.
# We need to provide the widths of each column, which we can manually
# count to determine.

page5 <- url("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for")
data5 <- read.fwf(page5, widths = c(12,7,4,9,4,9,4,9,4), skip=4)
five <- sum(data5$V4)
five
