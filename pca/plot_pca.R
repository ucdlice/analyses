library(plyr)

p=read.table('all_lice.raw.pca.eigenvec', header=F, stringsAsFactor=F)

a=read.table('../lice_info.txt', header=T, sep='\t', stringsAsFactor=F)
p$ecto=mapvalues(p$V1, from=a$V1, to=a$Ecto)
p$pool=mapvalues(p$V1, from=a$V1, to=a$pooled.individual)
p$location=mapvalues(p$V1, from=a$V1, to=a$Location)
p$date=mapvalues(p$V1, from=a$V1, to=a$Date)


pdf('pca_alllice.pdf')
ggplot(p, aes(x=V3, y=V4, color=ecto)) + geom_point()
ggplot(p, aes(x=V3, y=V4, color=ecto)) + geom_point() + facet_wrap(~ecto)
ggplot(p, aes(x=V5, y=V4, color=ecto)) + geom_point()
ggplot(p, aes(x=V3, y=V4, color=pool)) + geom_point()
ggplot(p, aes(x=V3, y=V4, color=pool)) + geom_point() + facet_wrap(~pool)
ggplot(p, aes(x=V5, y=V4, color=pool)) + geom_point()
ggplot(p, aes(x=V3, y=V4, color=location)) + geom_point()
ggplot(p, aes(x=V3, y=V4, color=location)) + geom_point() + facet_wrap(~location)
ggplot(p, aes(x=V5, y=V4, color=location)) + geom_point()
ggplot(p, aes(x=V5, y=V4, color=location)) + geom_point() + facet_wrap(~location)
ggplot(p, aes(x=V3, y=V4, color=date)) + geom_point()
ggplot(p, aes(x=V3, y=V4, color=date)) + geom_point() + facet_wrap(~date)
ggplot(p, aes(x=V5, y=V4, color=date)) + geom_point()
ggplot(p, aes(x=V5, y=V4, color=date)) + geom_point() + facet_wrap(~date)
dev.off()


pdf('single_loc.pdf')
ggplot(p[p$location=='San Francisco, California',], aes(x=V3, y=V4, color=ecto)) + geom_point()
ggplot(p[p$location=='Alaska',], aes(x=V3, y=V4, color=ecto)) + geom_point()
dev.off()
