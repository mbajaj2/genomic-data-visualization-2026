library(ggplot2)
data <- read.csv("data/Xenium-IRI-ShamR_matrix.csv.gz")
# data <- read.csv("data/Visium-IRI-ShamR_matrix.csv.gz")
dim(data) #80k cells, 302 genes

pos <- data[, c('x', 'y')]
rownames(pos) <- data[,1]

gexp <- data[, 4:ncol(data)]
rownames(gexp) <- data[,1]

std <- data.frame(
  std = apply(data[, 4:302], 2, sd, na.rm = FALSE)
)
std <- std[order(std$std, decreasing = TRUE), , drop = FALSE]
most_std_genes <- head(rownames(std), 10)

df <- data.frame(
  pos,
  gene = gexp[, "Cyp4b1"]
)
ggplot(df) + geom_point(aes(x=x, y=y, col= log10(gene+1)), size=0.01)