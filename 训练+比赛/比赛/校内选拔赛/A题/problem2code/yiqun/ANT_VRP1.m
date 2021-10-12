function [R_best,L_best,L_ave,Shortest_Route,Shortest_Length]=ANT_VRP1(D,Demand,Cap,iter_max,m,Alpha,Beta,Rho,Q)

%% R_best �������·��
%% L_best �������·�ߵĳ���
%% L_ave ����ƽ������
%% Shortest_Route ���·��
%% Shortest_Length ���·������
%% D ���м�֮��ľ������Ϊ�Գƾ���
%% Demand �ͻ�������
%% Cap �����������
%% iter_max ����������
%% m ���ϸ���
%% Alpha ������Ϣ����Ҫ�̶ȵĲ���
%% Beta ��������ʽ������Ҫ�̶ȵĲ���
%% Rho ��Ϣ������ϵ��
%% Q ��Ϣ������ǿ��ϵ��

n=size(D,1);
T=zeros(m,2*n);           %װ�ؾ���
Eta=ones(m,2*n);          %��������
Tau=ones(n,n);            %��Ϣ��
Tabu=zeros(m,n);          %���ɱ�
Route=zeros(m,2*n);       %·��
L=zeros(m,1);             %��·��
L_best=zeros(iter_max,1);   %�������·�߳���
R_best=zeros(iter_max,2*n); %�������·��
nC=1;

while nC<=iter_max                   %ֹͣ����
    Eta=zeros(m,2*n);
    T=zeros(m,2*n);
    Tabu=zeros(m,n);
    Route=zeros(m,2*n);
    L=zeros(m,1);
    Cost = zeros(m,1);
    %%%%%%==============��ʼ�������У����ɱ�====================
    for i=1:m
        Cap_1=Cap;      %���װ����
        j=1;
        j_r=1;
        while Tabu(i,n)==0
            T=zeros(m,2*n);    %װ�������ؾ���
            Tabu(i,1)=20;       %���ɱ����λ��Ϊ1
            Route(i,1)=20;      %·�����λ��Ϊ1
            visited=find(Tabu(i,:)>0);   %�ѷ��ʳ���
            num_v=length(visited);        %�ѷ��ʳ��и���
            J=zeros(1,(n-num_v));         %�����ʳ��м��ر�
            P=J;                          %�����ʳ���ѡ����ʷֲ�
            Jc=1;                         %�����ʳ���ѡ��ָ��
            for k=1:n                     %����
                if length(find(Tabu(i,:)==k))==0    %���k�����ѷ��ʳ��д��ţ��ͽ�k�������J��
                    J(Jc)=k;
                    Jc=Jc+1;
                end
            end
            
            %%%%%%%=============ÿֻ���ϰ���ѡ����ʱ������г���==================
            
            for k=1:n-num_v               %�����ʳ���
                if Cap_1-Demand(J(k))>=0    %�������װ�������ڴ����ʳ���������
                    
                    if Route(i,j_r)==20           %���ÿֻ������������
                        T(i,k)=D(20,J(1,k));
                        P(k)=(Tau(20,J(1,k))^Alpha)*((1/T(i,k))^Beta);  %���ʼ��㹫ʽ�еķ���
                    else                         %���ÿֻ�����ڲ���������
                        T(i,k)=D(Tabu(i,j),J(1,k));
                        P(k)=(Tau(Tabu(i,visited(end)),J(1,k))^Alpha)*((1/T(i,k))^Beta); %���ʼ��㹫ʽ�еķ���
                    end
                    
                else              %�������װ����С�ڴ����ʳ���������
                    T(i,k)=0;
                    P(k)=0;
                end
            end
            
            
            if length(find(T(i,:)>0))==0    %%%������װ����С�ڴ����ʳ���ʱ��ѡ�����Ϊ1
                Cap_1=Cap;
                j_r=j_r+1;
                Route(i,j_r)=20;
                L(i)=L(i)+D(20,Tabu(i,visited(end)));
            else
                P=P/(sum(P));                 %���ո���ԭ��ѡȡ��һ������
                Pcum=cumsum(P);               %���ۻ����ʺͣ�cumsum��[1 2 3])=1 3 6,Ŀ������ʹ��Pcum��ֵ���д���rand����
                Select=find(Pcum>rand);       %������ѡȡ��һ�����У����ۻ����ʺʹ��ڸ��������������ѡ����ͱ����ϵ����һ��������Ϊ�������ʵĳ���
                o_visit=J(1,Select(1));       %�����ʳ���
                j=j+1;
                j_r=j_r+1;
                Tabu(i,j)=o_visit;             %�����ʳ���
                Route(i,j_r)=o_visit;
                Cap_1=Cap_1-Demand(o_visit);  %����װ��ʣ����
                L(i)=L(i)+T(i,Select(1));       %·������
            end
        end
        L(i)=L(i)+D(Tabu(i,n),20);               %%·������
        
        
        
        
        
        temp_route = Route(i,find(Route(i,:))>0);
        len = 0;
        for kk = 1:length(temp_route)
            if temp_route(kk) == 20
                Cost(i) = Cost(i) + 2*D(temp_route(kk+1),20)*Demand(temp_route(kk+1));
                len = len + D(20,temp_route(kk+1));
                continue;
            end
            if kk == length(temp_route)
                Cost(i) = Cost(i) + 0.4*D(temp_route(kk),20);
                continue;
            end
            if temp_route(kk+1) == 20
                len = 0;
                Cost(i) = Cost(i) + 0.4*D(temp_route(kk),20);
                continue;
            end
            len = len + D(temp_route(kk),temp_route(kk+1));
            Cost(i) = Cost(i) + 2*len*Demand(temp_route(kk+1));
        end
    end
    
    L_best(nC)=min(Cost);             %����·��Ϊ������̵�·��
    pos=find(Cost==min(Cost));           %�ҳ�����·����Ӧ��λ�ã���Ϊ��ֻ����
    R_best(nC,:)=Route(pos(1),:);  %ȷ������·����Ӧ�ĳ���˳��
    L_ave(nC)=mean(Cost)';            %���k�ε�����ƽ������
    
    Delta_Tau=zeros(n,n);            %Delta_Tau(i,j)��ʾ�����������ڵ�i�����е���j������·���ϵ���Ϣ������
    L_zan=L_best(1:nC,1);
    post=find(L_zan==min(L_zan));
    Cities=find(R_best(nC,:)>0);
    num_R=length(Cities);
    
    for k=1:num_R-1          %����������·�������ͷ���Ϣ��
        Delta_Tau(R_best(nC,k),R_best(nC,k+1))=Delta_Tau(R_best(nC,k),R_best(nC,k+1))+Q/L_best(nC);
    end
    Delta_Tau(R_best(nC,num_R),1)=Delta_Tau(R_best(nC,num_R),1)+Q/L_best(nC);
    Tau=Rho*Tau+Delta_Tau;
    
    nC=nC+1;
end
[Shortest_Length,pos] = min(L_best)
Shortest_Route=zeros(1,2*n);           %��ȡ���·��
Shortest_Route(1,:)=R_best(pos,:);
Shortest_Route=Shortest_Route(Shortest_Route>0);
Shortest_Route=[Shortest_Route Shortest_Route(1,1)];
%Shortest_Length=L_best(iter_max);           %��ȡ���·������

%L_ave=mean(L_best);

