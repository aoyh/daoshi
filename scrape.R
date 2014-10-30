library(XML)
#till 1507-1650, 1651-1670, 1671-1678, 1680:1735
# 1679 does not exist
from <- 1507
to <- 1735
pages <- paste0("http://www.wddsnxn.org/", seq(from, to), ".html")
pages <- pages[-173]
thelist <- sapply(pages, function(x) {
doc <- htmlTreeParse(x, useInternal = TRUE)
h1 <- sapply(getNodeSet(doc, '//div[@class="chaptertitle clearfix"]/h1'), xmlValue)
body <- sapply(getNodeSet(doc, '//div[@id="BookText"]'), xmlValue)
gsub("                  ", "",paste(h1, body, sep = "\n\r"))
})

for (i in 1:length(thelist)) {ifelse(i == 1,
                                   out <- thelist[[i]],
                                   out <- paste0(out, "\n\r", "@", i, thelist[[i]])
                            )}

writeLines(out, paste0("out_", from, "_", to, ".txt"))

#system.time(source("scrape.R")) 
