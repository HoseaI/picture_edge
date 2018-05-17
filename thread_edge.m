clear
I=imread('1.jpg');
I=rgb2gray(I);
% M=edge(I,'prewitt');
M=im2bw(I,0.9);             %ͼ���ֵ��
img=M(1000:2000,600:2000);  %ȡ�������Ƽ����ֵ�ͼ��
img=edge(img);              %��Ե��ȡ
[m,n]=size(img);
up_num=1;
down_num=1;
distinc=50;                 %�и��ͼ�����������������ص㣬����distinc�����ص�
f=zeros(m,distinc);
for i=1:n-distinc
    for x=0:distinc             %ȡ��distinct�����ݣ���Ϊ�����ң���n�����ص���n+distinc
        f(:,x+1)=(img(:,x+i));
    end
    l=sum(sum(f));
     if sum(sum(f))>50           %�˵�ȫ�ڵĲ��֣���������
        if( sum(sum(f( fix(m*0.5) : fix(m*3/5) ,:)))<20 )     %�˵���ʼ��˿����ֱ�߲��֣��ⲿ��û������
            for x=1:distinc                     %�ҳ�����distinc����ϵĵ�
                up_max(x)=min(find(f(:,x)==1));
                ll=find(f(:,x)==1);
            end
            for x=1:distinc                     %�ҳ�����distinc����µĵ�
                down_min(x)=max(find(f(:,x)==1));
            end
            
            if up_max(fix(distinc/2))==max(up_max)          %�����ϵĵ��У����м����ߣ�����¼����
                up(:,up_num)=[up_max(fix(distinc/2)),i+fix(distinc/2)];
                up_num=up_num+1;
            else if up_max(fix(distinc/2))==min(up_max)     %�����ϵĵ��У����м����ͣ�����¼����
                up(:,up_num)=[up_max(fix(distinc/2)),i+fix(distinc/2)];
                up_num=up_num+1;
                end
            end
             if down_min(fix(distinc/2))==max(down_min)     %�����µĵ��У����м����ߣ�����¼����
                down(:,down_num)=[down_min(fix(distinc/2)),i+fix(distinc/2)];
                down_num=down_num+1;
            else if down_min(fix(distinc/2))==min(down_min) %�����µĵ��У����м����ͣ�����¼����
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
title('�õ�������ͼ��')
[a,b]=size(up);             %�õ����Ϸ���ĸ���
[c,d]=size(down);           %�õ����·���ĸ���
y=1;count=1;
for t=1:b-1
    if (up(1,t)==up(1,t+1))             %�����������Ʊ�Ե����ɵ�
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
for t=1:d-1                             %�����������Ʊ�Ե����ɵ�
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
 title('�Ż�����ȡ���Ʊ�Ե���ͼ��')
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