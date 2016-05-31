readtext <- function(file_to_read)
{
  news.con <- file(file_to_read,'rb')
	text_file <- suppressWarnings(readLines(news.con, encoding="UTF-8mb4"))
	close(news.con)
	text_file <- iconv(enc2utf8(text_file),sub="byte")
	text_file
}