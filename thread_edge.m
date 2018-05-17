clear
I=imread('1.jpg');
I=rgb2gray(I);
% M=edge(I,'prewitt');
M=im2bw(I,0.9);             %图像二值化
img=M(1000:2000,600:2000);  %取出含螺纹件部分的图像
img=edge(img);              %边缘提取
[m,n]=size(img);
up_num=1;
down_num=1;
distinc=50;                 %切割出图像连续纵向所有像素点，横向distinc个像素点
f=zeros(m,distinc);
for i=1:n-distinc
    for x=0:distinc             %取出distinct列数据，即为从左到右，第n个像素到第n+distinc
        f(:,x+1)=(img(:,x+i));
    end
    l=sum(sum(f));
     if sum(sum(f))>50           %滤掉全黑的部分，不做处理
        if( sum(sum(f( fix(m*0.5) : fix(m*3/5) ,:)))<20 )     %滤掉开始螺丝顶端直线部分，这部分没有螺纹
            for x=1:distinc                     %找出连续distinc个最靠上的点
                up_max(x)=min(find(f(:,x)==1));
                ll=find(f(:,x)==1);
            end
            for x=1:distinc                     %找出连续distinc个最靠下的点
                down_min(x)=max(find(f(:,x)==1));
            end
            
            if up_max(fix(distinc/2))==max(up_max)          %如果最靠上的点中，正中间点最高，即记录下来
                up(:,up_num)=[up_max(fix(distinc/2)),i+fix(distinc/2)];
                up_num=up_num+1;
            else if up_max(fix(distinc/2))==min(up_max)     %如果最靠上的点中，正中间点最低，即记录下来
                up(:,up_num)=[up_max(fix(distinc/2)),i+fix(distinc/2)];
                up_num=up_num+1;
                end
            end
             if down_min(fix(distinc/2))==max(down_min)     %如果最靠下的点中，正中间点最高，即记录下来
                down(:,down_num)=[down_min(fix(distinc/2)),i+fix(distinc/2)];
                down_num=down_num+1;
            else if down_min(fix(distinc/2))==min(down_min) %如果最靠下的点中，正中间点最低，即记录下来
                down(:,down_num)=[down_min(fix(distinc/2)),i+fix(distinc/2)];
                down_num=down_num+1;
                end 
             end
        end
    end
end
figure
plot(up(2,:),m-up(1,:),'bd'),hold on
plot(down(2,:),m-down(1,:),'bd')
plot(up(2,:),m-up(1,:),'b'),hold on
plot(down(2,:),m-down(1,:),'b')
title('得到的螺纹图像')
[a,b]=size(up);             %得到最上方点的个数
[c,d]=size(down);           %得到最下方点的个数
y=1;count=1;
for t=1:b-1
    if (up(1,t)==up(1,t+1))             %将连续的螺纹边缘处理成点
        count=count+1;
    else
        up_last(2,y)=fix(mean(up(2,t-count+1:t)));
        up_last(1,y)=up(1,t);
        count=1;
        y=y+1;
        if y==21
            break;
        end
    end
end
y=1;count=1;
for t=1:d-1                             %将连续的螺纹边缘处理成点
    if (down(1,t)==down(1,t+1))
        count=count+1;
    else
        down_last(2,y)=fix(mean(down(2,t-count+1:t)));
        down_last(1,y)=down(1,t);
        count=1;
        y=y+1;
        if y==21
            break;
        end
    end
end
figure
 plot(up_last(2,:),m-up_last(1,:),'r'),hold on
 plot(down_last(2,:),m-down_last(1,:),'r')
  plot(up_last(2,:),m-up_last(1,:),'rd'),hold on
 plot(down_last(2,:),m-down_last(1,:),'rd')
 title('优化后提取螺纹边缘点的图像')
% figure
% for t=1:b-1
% %    if up(1,t+1)-up(1,t)>5
%         line([up(2,t) up(1,t)],[up(2,t+1) up(1,t+1)]);hold on
%         pause(.1);
% %    end
% end
% axsi([0 m 0 n])
% for t=1:d-1
%     line(down(:,t)',down(:,t+1)');hold on
% end
% figure
% imshow(img)