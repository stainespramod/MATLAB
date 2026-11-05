clc; clearvars;

% Enter these matrices from final optimal table
A=readmatrix('input2_A.txt');
xB=readmatrix('input2_xB.txt');
B_inv=readmatrix('input2_B_inv.txt');
red_cost=readmatrix('input2_red_cost.txt');
cB=readmatrix('input2_cB.txt');

p=input("Enter a to get the range for some a, b for some b and c for some c\n","s");

if(p=='a')
    B=inv(B_inv);
    r=input("Enter the row of the a you want to find the range of\n");
    k=input("Enter the column of the a you want to find the range of\n");
    a_in_B=0;
    for i=1:width(B)
        if(A(:,k)==B(:,i))
            a_in_B=1;
            break;
        end
    end
    if(a_in_B==0)      
        check=cB*B(:,r);
        if(check>0)
            lower_limit=-red_cost(k)/check;
            fprintf("lower bound for change in a%d%d is %d\n",r,k,lower_limit);
        elseif(check<0)
            upper_limit=-red_cost(k)/check;
            fprintf("upper bound for change in a%d%d is %d\n",r,k,upper_limit);
        else
            fprintf("a%d%d is unrestricted\n",r,k);
        end
    else
        lower_bound=1;
        upper_bound=-1;
        for i=1:length(xB)
            Q=B_inv(r,k)*xB(i)-B_inv(i,r)*xB(k);
            if(Q>0&&-xB(i)/Q>lower_bound)
                lower_bound=-xB(i)/Q;
            elseif(Q<0&&Q<upper_bound)
                upper_bound=-xB(i)/Q;
            end
        end
        if(lower_bound<=0)
            fprintf("lower bound for change in a%d%d is %d\n",r,k,lower_bound);
        end
        if(upper_bound>=0)
            fprintf("upper bound for change in a%d%d is %d\n",r,k,upper_bound);
        end
        if(lower_bound>0&&upper_bound<0)
            fprintf("a%d%d is unrestricted\n",r,k);
        end
    end


elseif(p=='b')
    k=input("Enter the column of b you want to find the range of\n");
    lower_limit=1;
    upper_limit=-1;
    for i=1:length(xB)
        if(B_inv(i,k)==0)
            continue;
        end
        if(-xB(i)/B_inv(i,k)<lower_limit)
            lower_limit=-xB(i)/B_inv(i,k);
        end
        if(-xB(i)/B_inv(i,k)>upper_limit)
            upper_limit=-xB(i)/B_inv(i,k);
        end                
    end
    if(lower_limit>=0)
        fprintf("lower bound for change in b%d is -infinity\n",k);
    else 
        fprintf("lower bound for change in b%d is %d\n",k,lower_limit);
    end
    if(upper_limit<=0)
        fprintf("upper bound for change in b%d is infinity\n",k);
    else 
        fprintf("upper bound for change in b%d is %d\n",k,upper_limit);
    end

else
    k=input("Enter the column of c you want to find the range of\n");
    lower_limit=1;
    upper_limit=-1;
    for i=1:width(A)
        if(A(k,i)==0)
            continue;
        end
        if(-red_cost(i)/A(k,i)<lower_limit)
            lower_limit=-red_cost(i)/A(k,i);
        end
        if(-red_cost(i)/A(k,i)>upper_limit)
            upper_limit=-red_cost(i)/A(k,i);
        end           
    end
    if(lower_limit>=0)
        fprintf("lower bound for change in c%d is -infinity\n",k);
    else 
        fprintf("lower bound for change in c%d is %d\n",k,lower_limit);
    end
    if(upper_limit<=0)
        fprintf("upper bound for change in c%d is infinity\n",k);
    else 
        fprintf("upper bound for change in c%d is %d\n",k,upper_limit);
    end
end