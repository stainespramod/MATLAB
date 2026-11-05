clc; clearvars;

P=readmatrix('input3_payoff.txt');

rowmin=ones(1,height(P));
colmax=ones(1,width(P));
for i=1:height(P)
    rowmin(i)=min(P(i,:));
end
for i=1:width(P)
    colmax(i)=max(P(:,i));
end
[maximin,maximin_ind]=max(rowmin);
[minimax,minimax_ind]=min(colmax);
if(maximin==minimax)
    fprintf("Player A can always choose strategy %d and Player B can always choose strategy %d to play optimally\nThe value of the game = %d\n",maximin_ind,minimax_ind,maximin);
else
    for i=1:height(P)
        for j=i+1:height(P)
            if(j>=height(P))
                break
            end
            if(sum(P(i,:)<=P(j,:))==width(P))
                P(i,:)=[];
            end
        end
    end
    for i=1:width(P)
        for j=i+1:width(P)
            if(j>=width(P))
                break
            end
            if(sum(P(:,i)>=P(:,j))==height(P))
                P(:,i)=[];
            end
        end
    end
    if(length(P)==2)
        p1=abs(P(2,1)-P(2,2));
        p2=abs(P(1,1)-P(1,2));
        total=p1+p2;
        p1=p1/total;
        p2=p2/total;
        q1=abs(P(1,2)-P(2,2));
        q2=abs(P(1,1)-P(2,1));
        total=q1+q2;
        q1=q1/total;
        q2=q2/total;
        fprintf("p1 = %d; p2 = %d; q1 = %d; q2 = %d;\nwhere p1,p2,q1,q2 are the probabilities with which Players A and B choose their strategies respectively.\n",p1,p2,q1,q2);

    else
        fprintf("The Algebraic Method is not applicable for this Payoff Matrix\n");
    end

end