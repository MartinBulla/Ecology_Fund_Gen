
# load packages
require(data.table)
   
require(ggplot2)
require(ggpmisc)
require(ggpubr)

require(patchwork)

# constatns
set.seed(5) # for simulations
nsim = 5000
g_r_x = 35
orig_ = '#D43F3AFF'
furt_ = '#46B8DAFF'#"#357EBDFF"#
col_p1 = 'darkgrey'#'darkgrey'
col_p = 'grey60'#'darkgrey'
col_pc = 'grey10'
point_out = 'grey30'
point_fill = "#46B8DAFF"
col_R = "#D43F3AFF"
col_l = '#D43F3AFF'
col_ <- c("#46B8DAFF", "#EEA236FF")

per_ = 0.05
scale_size = 0.352778
inch = 0.393701
force_0_yes = FALSE


# simulate and plot

h = data.table( 
    x = rnorm(1000, mean = 35, sd = 4), 
    y = rnorm(1000, mean = 35, sd = 4) 
    )

g1=
ggplot(h, aes(x = x, y = y)) + 
    geom_point(col = col_p1, size = 1.5, alpha = 0.6) +
    stat_poly_line(se = FALSE, col = col_l) +
    stat_cor(cor.coef.name = "r", aes(label = after_stat(r.label)),  col = col_R, r.accuracy = 0.1, label.x = g_r_x, label.y = 52-(52-20)*per_ , hjust = 0.5, cex = 3) + 
    coord_cartesian(xlim = c(20, 50), ylim = c(20, 52)) +
    scale_x_continuous(breaks = seq(20,50, by=10), labels = seq(20,50, by=10), expand = c(0,0))+
    scale_y_continuous(breaks = seq(20,50, by=10), labels = seq(20,50, by=10), expand = c(0,0)) +
    theme_bw() + 
    theme(axis.ticks = element_blank(),
        panel.grid.major = element_blank(),  # Remove major grid lines
        panel.grid.minor = element_blank() )

g2=  
ggplot(h, aes(x = x, y = y/x)) + 
    geom_point(col = col_p1, size = 1.5, alpha = 0.6) +#geom_point(fill = col_p, pch = 21, size = 1.5) +
    stat_poly_line(se = FALSE, col = col_l) +
    stat_cor(cor.coef.name = "r", aes(label = after_stat(r.label)),  col = col_R, r.accuracy = 0.1, label.x = g_r_x, hjust = 0.5, cex = 3) + 
    coord_cartesian(xlim = c(20, 50)) +
    scale_x_continuous(breaks = seq(20,50, by=10), labels = seq(20,50, by=10), expand = c(0,0))+
    scale_y_continuous(expand = c(0,0)) +
    theme_bw() + 
    theme(axis.ticks = element_blank(),
        panel.grid.major = element_blank(),  # Remove major grid lines
        panel.grid.minor = element_blank() )

(g1 | g2) + plot_layout(axis_titles = "collect")