tokenize <- function (target)
{

#Tokenizer
	i <- 1
	tokens <- c()
	filt_tokens <- list()

	while(i <= length(target))
	{
		tokens[i] <- list(MC_tokenizer(target[i]))

		j <- 1
		element <- 1
		filt_tokens[[i]] <- array()

		while (j <= length(tokens[[i]]))
		{
			if (nchar(tokens[[i]][j]) > 0)
				{
					filt_tokens[[i]][element] <- tokens[[i]][j]
					element <- element+1
				}

			j <- j+1
		}
		i <- i+1
	}
	filt_tokens <- lapply(filt_tokens,tolower)
	filt_tokens
}