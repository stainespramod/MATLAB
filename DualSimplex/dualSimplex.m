clc; clearvars;

A=readmatrix('input1_A.txt');
b=readmatrix('input1_b.txt');
c=readmatrix('input1_c.txt');
yB_initial=readmatrix('input1_yB.txt');
yB=yB_initial;
xB=readmatrix('input1_xB.txt');
cB=readmatrix('input1_cB.txt');

miniFlag=input("This is a minimization problem. Answer 1 if true and 0 if false.\n");
if(miniFlag)
    c=c*-1;
    cB=cB*-1;
end
red_cost=cB*A-c;
while(sum(xB<0)>0)
    [~,pivot_row]=min(xB);
    max_ratio=-100000;
    for i=1:length(red_cost)
        if(A(pivot_row,i)<0&&red_cost(i)/A(pivot_row,i)>max_ratio)
            max_ratio=red_cost(i)/A(pivot_row,i);
            pivot_col=i;
        end
    end
    pivot_element=A(pivot_row,pivot_col);
    for i=1:length(red_cost)
        A(pivot_row,i)=A(pivot_row,i)/pivot_element;
    end
    xB(pivot_row)=xB(pivot_row)/pivot_element;
    for i=1:height(A)
        if(i==pivot_row)
            continue
        end
        factor=A(i,pivot_col);
        A(i,:)=A(i,:)-factor*A(pivot_row,:);
        xB(i)=xB(i)-factor*xB(pivot_row);
    end
    factor=red_cost(pivot_col);
    red_cost=red_cost-factor*A(pivot_row,:);
    yB(pivot_row)=pivot_col;
    cB(pivot_row)=c(pivot_col);
end
z=-cB*(xB.');
if(miniFlag)
    z=z*-1;
end
fprintf("The minimum possible value of the objective function is %d\n\n",z);

       
