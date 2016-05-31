### Example data
head(ChickWeight)
summary(ChickWeight)

library(ggplot2)

# Number of individuals in treatment groups at the beginning and at the first and last day of the experiment
q <- ggplot(data=ChickWeight[ChickWeight$Time%in%c(0,21),]) + 
	geom_bar(aes(x=Diet, group=Time, fill=factor(Time)), position='dodge') + 
	ylab('Individuals in treatment') + 
	scale_fill_grey(name='Day') + 
	scale_y_continuous(expand=c(0,0), limits=c(0,20.5))


# Distribution of weights at the end of the experiment
qq <- ggplot(data=ChickWeight[ChickWeight$Time==21,]) + geom_boxplot(aes(x=Diet, y=weight)) + ylab('Final weight')


library(cowplot)
## plot grid
plot_grid(q,qq)
## adding labels
plot_grid(q,qq, labels=letters[1:2])
## change position of legend in a
plot_grid(q+theme(legend.position=c(.8,.8)),qq, labels=letters[1:2])
q <- q+theme(legend.position=c(.8,.8))

## Save the plot
save_plot(
	plot_grid(q,qq, labels=letters[1:2]),
	filename='~/Desktop/tst.png', base_height=4, base_width=7
)


## Adding another plot 
qqq <- ggplot(data=ChickWeight) + geom_point(aes(x=Time, y=weight, colour=Diet)) + stat_smooth(aes(x=Time, y=weight, colour=Diet), method='loess')

## Plotting all three figures
plot_grid(q,qq,qqq, labels=letters[1:3])

## Alterntively, we do it manually
ggdraw()+ #Set up a drawing layer on top of a ggplot
	draw_plot(q)+ #Places a plot somewhere onto the drawing canvas
	draw_plot(qq)+
	draw_plot(qqq)+
	draw_plot_label(label=LETTERS[1:3])


ggdraw()+
	draw_plot(q, x=0, y=.5, width=0.5, height=.5)+
	draw_plot(qq, x=.5, y=.5, width=0.5, height=.5)+
	draw_plot(qqq, x=0, y=0, width=1, height=.5)+
	draw_plot_label(label=LETTERS[1:3], x=c(0,.5,0), y=c(1,1,.5), fontface='italic') + 
	draw_label("DRAFT", angle = 45, size = 110, alpha = .2)


save_plot(ggdraw()+
						draw_plot(q, x=0, y=.5, width=0.5, height=.5)+
						draw_plot(qq, x=.5, y=.5, width=0.5, height=.5)+
						draw_plot(qqq, x=0, y=0, width=1, height=.5)+
						draw_plot_label(label=LETTERS[1:3], x=c(0,.5,0), y=c(1,1,.5), fontface='bold'),
					filename='~/Desktop/tst2.png', base_height=6, base_width=7
)