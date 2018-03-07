#����vegan��  
library(vegan)  
#��ȡ������-���֡��ļ�  
sp <- read.table("C:\\Users\\JL_Zh\\Desktop\\RDA_analysis\\sample-species.txt",
                 sep = "\t",header = T,row.names = 1)  

sp  
#��ȡ������-�������ӡ��ļ�  
se <- read.table("C:\\Users\\JL_Zh\\Desktop\\RDA_analysis\\sample-enviroment.txt",
                 sep = "\t",header = T,row.names = 1)  

se  
#ѡ����RDA����CCA���������á�����-���֡��ļ���DCA������  
decorana(sp)   
#���ݿ����������Axis Lengths�ĵ�һ��Ĵ�С  
#�������4.0,��ӦѡCCA�����ڵ���ģ�ͣ��䷶��Ӧ������  
#�����3.0-4.0֮�䣬ѡRDA��CCA����  
#���С��3.0, RDA�Ľ�������������������ģ�ͣ����������  
#��RDA����Ϊ��  
sp0 <- rda(sp ~ 1, se)    
sp0  
plot(sp0)  
#�������л�����������RDA����  
sp1 <- rda(sp ~ ., se)    
sp1  
plot(sp1)  
#������RDAͼ�Ѿ�������,�ܶ�����Ҳ��ֱ�ӷ�����ͼ,�������׷������Ļ�,��������ggplot2������·�,��װ�Լ�  
#׼����ͼ���ݣ���ȡRDA�������������,��Ϊ��ͼ��Ԫ��  
new <- sp1$CCA  
new  
#��ȡ��ת��������������  
samples <- data.frame(sample = row.names(new$u),RDA1 = new$u[,1],RDA2 = new$u[,2])  
samples  
#��ȡ��ת�������֡�����  
species <- data.frame(spece = row.names(new$v),RDA1 = new$v[,1],RDA2 = new$v[,2])  
species  
#��ȡ��ת�����������ӡ�����  
envi <- data.frame(en = row.names(new$biplot),RDA1 = new$biplot[,1],RDA2 = new$biplot[,2])  
envi  
#������������ֱ������  
line_x = c(0,envi[1,2],0,envi[2,2],0,envi[3,2],0,envi[4,2],0,envi[5,2],0,envi[6,2])  
line_x  
line_y = c(0,envi[1,3],0,envi[2,3],0,envi[3,3],0,envi[4,3],0,envi[5,3],0,envi[6,3])  
line_y  
line_g = c("pH","pH","T","T","S2","S2","NH4","NH4","NO2","NO2","Fe2","Fe2")  
line_g  
line_data = data.frame(x = line_x,y = line_y,group = line_g)  
line_data  
#����ggplot2��  
library(ggplot2)  
#��ʼ�ػ�RDAͼ  
#����������ݣ��ֱ���RDA1,RDA2ΪX,Y�ᣬ��ͬ��������ɫ����  
ggplot(data = samples,aes(RDA1,RDA2)) + geom_point(aes(color = sample),size = 2) +  
  #���΢�����������ݣ���ͬ������ͼ������  
  geom_point(data = species,aes(shape = spece),size = 2) +   
  #��价���������ݣ�ֱ��չʾ  
  geom_text(data = envi,aes(label = en),color = "blue") +  
  #����0�̶��ݺ���  
  geom_hline(yintercept = 0) + geom_vline(xintercept = 0) +  
  #����ԭ��ָ�򻷾����ӵ�ֱ��  
  geom_line(data = line_data,aes(x = x,y = y,group = group),color = "green") +  
  #ȥ��������ɫ������������  
  theme_bw() + theme(panel.grid = element_blank())  
#�󹦸�ɣ�����Ϊʸ��ͼ�ȵ�  
ggsave("RDA2.PDF")  