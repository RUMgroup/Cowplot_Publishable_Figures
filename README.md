# Cowplot – Publishable Figures in R

The _cowplot()_ package provides a simple way to create figures with severa pannels (either with equal size, or with variable size and positions), A,B,C, ... labelling, and more. Here I provide the code from our R Group Meeting (31st May 2016). An example figure with the used code are shown below. 

```{r}
library(ggplot2)
library(cowplot)

q <- ggplot(data=ChickWeight[ChickWeight$Time%in%c(0,21),]) + geom_bar(aes(x=Diet, group=Time, fill=factor(Time)), position='dodge') + ylab('Individuals in treatment') + scale_fill_grey(name='Day') + scale_y_continuous(expand=c(0,0), limits=c(0,20.5)) + theme(legend.position=c(.8,.8))
qq <- ggplot(data=ChickWeight[ChickWeight$Time==21,]) + geom_boxplot(aes(x=Diet, y=weight)) + ylab('Final weight')
qqq <- ggplot(data=ChickWeight) + geom_point(aes(x=Time, y=weight, colour=Diet)) + stat_smooth(aes(x=Time, y=weight, colour=Diet), method='loess')

ggdraw()+
	draw_plot(q, x=0, y=.5, width=0.5, height=.5)+
	draw_plot(qq, x=.5, y=.5, width=0.5, height=.5)+
	draw_plot(qqq, x=0, y=0, width=1, height=.5)+
	draw_plot_label(label=LETTERS[1:3], x=c(0,.5,0), y=c(1,1,.5), fontface='bold')
```

![cow plot example](https://github.com/flsrgroup/Cowplot_Publishable_Figures/blob/master/tst2.png "Logo Title Text 1")

