#Read sample key file
sampleKey <- read.csv("./input/GSE60655_samplekey.csv", stringsAsFactors = FALSE, as.is = TRUE)

#Remove columns where all values are identical
differentColumnValueCount <- apply(sampleKey, 2, function(x) length(unique(x)))
identicalColumnNames <- names(differentColumnValueCount[differentColumnValueCount == 1])
sampleKey <- sampleKey[, !names(sampleKey) %in% identicalColumnNames]

#Fix array column
sampleKey$X <- NULL
sampleKey$X.SAMPLE <- NULL
sampleKey$geo_accession <- NULL
sampleKey$source_name_ch1 <- NULL


#Fix slide column
names(sampleKey)[names(sampleKey) == 'characteristics_ch1.1'] <- 'Slide'
sampleKey$Slide <- sub(".*: ", "", sampleKey$Slide)

#Fix array column
names(sampleKey)[names(sampleKey) == 'characteristics_ch1.2'] <- 'Array'
sampleKey$Array <- sub(".*: ", "", sampleKey$Array)

#Fix batch column
names(sampleKey)[names(sampleKey) == 'characteristics_ch1.3'] <- 'batch'
sampleKey$batch <- sub(".*: ", "", sampleKey$batch)

#Fix group column
names(sampleKey)[names(sampleKey) == 'characteristics_ch1.4'] <- 'training'
sampleKey$training[sampleKey$training == 'group: T1'] <- 'before' 
sampleKey$training[sampleKey$training == 'group: T2'] <- 'after' 

#Fix subject column
names(sampleKey)[names(sampleKey) == 'characteristics_ch1.5'] <- 'subject'
sampleKey$subject <- sub(".*: ", "", sampleKey$subject)

#Fix gender column
names(sampleKey)[names(sampleKey) == 'characteristics_ch1.6'] <- 'gender'
sampleKey$gender[sampleKey$gender == 'gender: male'] <- 'male' 
sampleKey$gender[sampleKey$gender == 'gender: female'] <- 'female' 

#Fix base name
sampleKey$supplementary_file.1 <- NULL
names(sampleKey)[names(sampleKey) == 'supplementary_file'] <- 'basename'
sampleKey$basename <- basename(sampleKey$basename)
sampleKey$basename <- sub("_[^_]*$", "", sampleKey$basename)

#Save cleaned sample key
write.csv(sampleKey, "./output/GSE60655_samplekey_clean.csv")

