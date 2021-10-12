% Test functions for optimization
% These are the test functions that appear in Appendix I.
% Set funnum to the function you want to use.
% funnum=17 is for a MOO function
% Haupt & Haupt
% 2003
function f=testfunction11(x)  % 20

% 22 MIMO PID Tunuing

bias = 2;

funnum = -1;
alpha = 2;
if funnum==-1 %F1 Rasrigin
    f = 18.3549 + 20 + x(:,1).^2 + x(:,2).^2 - 10 * ( cos(alpha*pi*x(:,1)) + cos(alpha*pi*x(:,2)) );
elseif funnum==0 %F1
    f = (x(:,1) - bias).^2 + (x(:,2) - bias).^2;
elseif funnum==1 %F2
    f=abs(x)+cos(x);

elseif funnum==2 %F2
    f=abs(x)+sin(x);
elseif funnum==3 %F3
    f=x(:,1).^2+x(:,2).^2;
elseif funnum==4 %F4
    f=100*(x(:,2).^2-x(:,1)).^2+(1-x(:,1)).^2;
elseif funnum==5 %F5
    f(:,1)=sum(abs(x')-10*cos(sqrt(abs(10*x'))))';
elseif funnum==6 %F6
    f=(x.^2+x).*cos(x);
elseif funnum==7 %F7
    %     x = x * 10;
    f=x(:,1).*sin(4*x(:,1))+1.1*x(:,2).*sin(2*x(:,2));
elseif funnum==8 %F8
    f=x(:,2).*sin(4*x(:,1))+1.1*x(:,1).*sin(2*x(:,2));
elseif funnum==9 %F9
    f(:,1)=x(:,1).^4+2*x(:,2).^4+randn(length(x(:,1)),1);
elseif funnum==10 %F10
    f(:,1)=20+sum(x'.^2-10*cos(2*pi*x'))';
elseif funnum==11 %F11
    f(:,1)=1+sum(abs(x').^2/4000)'-prod(cos(x'))';
elseif funnum==12 %F12
    f(:,1)=.5+(sin(sqrt(x(:,1).^2+x(:,2).^2).^2)-.5)./(1+.1*(x(:,1).^2+x(:,2).^2));
elseif funnum==13 %F13
    aa=x(:,1).^2+x(:,2).^2;
    bb=((x(:,1)+.5).^2+x(:,2).^2).^0.1;
    f(:,1)=aa.^0.25.*sin(30*bb).^2+abs(x(:,1))+abs(x(:,2));
elseif funnum==14 %F14
    f(:,1)=besselj(0,x(:,1).^2+x(:,2).^2)+abs(1-x(:,1))/10+abs(1-x(:,2))/10;
elseif funnum==15 %F15
    f(:,1)=-exp(.2*sqrt((x(:,1)-1).^2+(x(:,2)-1).^2)+(cos(2*x(:,1))+sin(2*x(:,1))));
elseif funnum==16 %F16
    f(:,1)=x(:,1).*sin(sqrt(abs(x(:,1)-(x(:,2)+9))))-(x(:,2)+9).*sin(sqrt(abs(x(:,2)+0.5*x(:,1)+9)));
elseif funnum==17 %MOO function
    x=x+1;
    f(:,1)=(x(:,1)+x(:,2).^2+sqrt(x(:,3))+1./x(:,4))/8.5;
    f(:,2)=(1./x(:,1)+1./x(:,2)+x(:,3)+x(:,4))/6;
elseif funnum == 18
%     xN = (x-0.5)*2;
%     xN = (x);
x = (x)*12;
    x1 = x(:,1);
    x2 = x(:,2);
    
    x1Min = 3;
    x2Min = 3;
    f = 20 + (x1 - x1Min).^2 + (x2 - x2Min).^2 - 10 * (cos(2*pi*(x1 - x1Min)) + cos(2*pi*(x2 - x2Min)));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif funnum == 20 % Game Theory
    A = [20     20      20
        25     25      25
        30     30      30];
    for i = 1 : size(x,1)
        f(i,1) = x(i,:)*A(:,3) - x(i,:)*A*x(i,:)';
    end
    f=x(:,1).^2+x(:,2).^2;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif funnum == 21 % PID Tuning
    s = tf('s');
    %     G = tf([1 2],[1 5 5 5]);
    G = 4.228/(s+0.5)/(s^2+1.64*s+8.456);
    for jj = 1:size(x,1)

        KP = x(jj,1);
        KI = x(jj,2);
        KD = x(jj,3);
        PID_Controller = KP + KD*s + KI/s;
        % G = (1 - 5*s)  /  (  (1+10*s)*(1+20*s)  )
        %
        % Arash System
        SERIES = series(G,PID_Controller);
        ClosedLoop = feedback(SERIES,1);
        gam = 0.01;
        t_in = [0:gam:40];
        [y,t] = step(ClosedLoop,t_in);
        %         step(ClosedLoop,t_in);
        % hold on
        % step(G);
        % [y,t] = step(G,t_in);

        %=====================================================
        %  Finding Max Overshoot
        %=====================================================
        maxovershoot = 0;
        if max(y)>1
            ind = find(y==max(y));
            maxovershoot = (y(ind) - 1);
            %     hold on
            %     plot(t(ind),y(ind),'rp')
            %     hold off
        end

        %=====================================================
        %  Finding Rise Time
        %=====================================================
        y_1_10 = abs(y - 0.1);
        y_9_10 = abs(y - 0.9);

        index1_10 = find(   y_1_10 < (5*min(y_1_10))  );
        index1_10 = index1_10(1);

        index9_10 = find(   y_9_10 < (5*min(y_9_10))  );
        index9_10 = index9_10(1);

        RiseTime = t(index9_10)-t(index1_10);y_1_10 = abs(y - 0.1);
        % hold on
        % plot(t(index9_10),y(index9_10),'gp' , t(index1_10),y(index1_10),'gp')
        % hold off

        %=====================================================
        %  Finding Settling Time
        %=====================================================
        y_1_2_100 = abs(y - 1.05);
        y_0_98_100 = abs(y - 0.95);
        y_1 = abs(y - 1);

        index1_2_100 = find(   y_1_2_100 < (0.01 + min(y_1_2_100))  );
        index0_98_100 = find(   y_0_98_100 < (0.01 + min(y_0_98_100))  );
        % hold on
        % plot(t(index1_2_100),y(index1_2_100),'k.'  ,  t(index0_98_100),y(index0_98_100),'y.')
        % hold off
        settling_time = t(end);
        settling_time_index = numel(t);
        all_indexes = sort([index1_2_100 ;  index0_98_100]);

        for ii = 1:numel(all_indexes)
            if (          sum( (y_1(all_indexes(ii):end)>0.05) )  ) == 0
                settling_time_index = all_indexes(ii);
                settling_time = t(all_indexes(ii));
                break
            end
        end
        %         hold on
        %         plot(settling_time,y(settling_time_index),'kp')
        %         hold off

        %=====================================================
        %  Finding IAE
        %=====================================================
        IAE = sum(abs(y-1))*gam;
        %=====================================================
        %  Returning
        %=====================================================
        f(jj,1) = 1*(maxovershoot  +  RiseTime +  IAE  +  settling_time);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MIMO PID Tuning %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elseif funnum == 22 % MIMO PI Tuning
    %     x = (x-.5) * 2;
    s = tf('s');
    %   PADE APPROXIMATION IS USED TO APROXIMATE EXP(-TS)
    %         G11 = 12.8*((1-.5*s+.5*(-.5*s)^2)/(1+.5*s+.5*(.5*s)^2))/(16.7*s+1);
    %         G12 = -18.9*((1-1.5*s+.5*(-1.5*s)^2)/(1+1.5*s+.5*(1.5*s)^2))/(21*s+1);
    %         G21 = 6.6*((1-3.5*s+.5*(-3.5*s)^2)/(1+3.5*s+.5*(+3.5*s)^2))/(10.9*s+1);
    %         G22 = -19.4*((1-1.5*s+.5*(-1.5*s)^2)/(1+1.5*s+.5*(1.5*s)^2))/(14.4*s+1);
    %
    ApproxOrder = 2;
    [n1,d1] = pade(1,ApproxOrder);
    [n3,d3] = pade(3,ApproxOrder);
    [n7,d7] = pade(7,ApproxOrder);

    G11 = 12.8*tf(n1,d1)/(16.7*s+1);
    G12 = -18.9*tf(n3,d3)/(21*s+1);
    G21 = 6.6*tf(n7,d7)/(10.9*s+1);
    G22 = -19.4*tf(n3,d3)/(14.4*s+1);

    G = [ G11 G12;  G21 G22];
    gam  =  .1;
    t_in = [0:gam:800];

    KP11 = x(:,1);
    KI11 = x(:,2);
    KP12 = x(:,3);
    KI12 = x(:,4);
    KD12 = x(:,5);
    KP21 = x(:,6);
    KI21 = x(:,7);
    KD21 = x(:,8);
    KP22 = x(:,9);
    KI22 = x(:,10);


    for jj = 1:size(x,1)
        jj
        %         x = [KP11 KI11 | KP12 KI12 KD12 | KP21 KI21 KD21 | KP22 KI22 ]
        %
        %         KP11 = 0.184; KI11 = 0.184/3.92; KP12 = -0.0102; KI12 = -0.0102/0.445; KD12 = -0.0102*(-0.804);...
        %         KP21 = -0.0674; KI21 = -0.0674/(-4.23); KD21 = -0.0674 * 0.796; KP22 = -0.0660; KI22 = -0.0660/4.25; jj = 1; %Auto Tuning Controller
        % % %
        % %         KP11 = 0.9971;        KI11 = 0.0031;        KP22 = -.0141;        KI22 = -0.0071; % Their proposed algorithm
        %
        %        KP11 = 0.5511;        KI11 = 0.0018;        KP22 = -.0182;        KI22 = -0.0067; % Traditional GA

        %         KP11 = 0.3750;        KI11 = 0.0452;        KP22 = -.0750;        KI22 = -0.0032; % BLT Method
        Controller11 = KP11(jj) + KI11(jj)/s;
        Controller12 = KP12(jj) + KI12(jj)/s + KD12(jj)*s;
        Controller21 = KP21(jj) + KI21(jj)/s + KD21(jj)*s;
        Controller22 = KP22(jj) + KI22(jj)/s;

        K = [ Controller11 Controller12;  Controller21 Controller22];

        TF = G*K*inv(eye(2,2)+G*K);

        [Y,t] = step(TF,t_in);
        y11 = Y(:,1,1);
        y12 = Y(:,1,2);
        y21 = Y(:,2,1);
        y22 = Y(:,2,2);
        %         step(TF,t_in);
        %=====================================================
        %  Finding IAE
        %=====================================================
        IAE = sum(abs(y11-1) + abs(y12-0) + abs(y21-0) + abs(y22-1)) * gam
        %=====================================================
        %  Returning
        %=====================================================
        f(jj,1) = IAE ;
    end % end of MIMO PI Tuning

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif funnum == 44 % Azermotor
    f = 40 + x(:,1).^2 + x(:,2).^2 + x(:,3).^2 + x(:,4).^2  -  10*(    cos(2*pi*x(:,1)) + cos(2*pi*x(:,2)) + cos(2*pi*x(:,3)) + cos(2*pi*x(:,4))    );
elseif funnum == 43 %New AzerMotor
    %% %%%%%%%%%%%%%%%%%%%%%%%%% NEW AZERMOTOR %%%%%%%%%%%%%%%%%%%%%%%%%
    close all
    L1 = 6; W1 = 14; % Raxtkan
    L2 = 24; W2 = 5; % Saxte Kabin
    L3 = 24; W3 = 5; % Saxte Shasi
    L4 = 15; W4 = 7; % Rober Assemble
    L5 = 10; W5 = 3; % WC
    L6 = 5 ; W6 = 3; % Health Care
    L7 = 10; W7 = 40; %Main Office
    L8 = 24; W8 = 25; % Assemble Line
    L9 = 5; W9 = 18; % Check Room
    L10 = 24; W10 = 8; % Cabine Painting
    L11 = 4; W11 = 4; % Tools Room
    L12 = 4; W12 = 3; % Batri
    L = 50; W = 50;% Main Factory

    x = [3 43   18 47.5   18 42.5   42.5 46.5   45 41.5   37.5 41.5   45 20   20 20.5     2.5 9   20 4    18 36   8 38.5];
    % x = [x;x;x];

    %     1         2           3       4           5          6        7
    for indexx = 1:size(x,1)
        indexx =1
        x1 = x(indexx,1);
        y1 = x(indexx,2);

        x2 = x(indexx,3);
        y2 = x(indexx,4);

        x3 = x(indexx,5);
        y3 = x(indexx,6);

        x4 = x(indexx,7);
        y4 = x(indexx,8);

        x5 = x(indexx,9);
        y5 = x(indexx,10);

        x6 = x(indexx,11);
        y6 = x(indexx,12);

        x7 = x(indexx,13);
        y7 = x(indexx,14);

        x8 = x(indexx,15);
        y8 = x(indexx,16);

        x9 = x(indexx,17);
        y9 = x(indexx,18);

        x10 = x(indexx,19);
        y10 = x(indexx,20);

        x11 = x(indexx,21);
        y11 = x(indexx,22);

        x12 = x(indexx,23);
        y12 = x(indexx,24);

        M1X = [x1-L1/2   x1+L1/2   x1+L1/2   x1-L1/2   x1-L1/2];    M1Y = [y1-W1/2   y1-W1/2   y1+W1/2   y1+W1/2   y1-W1/2];
        M2X = [x2-L2/2   x2+L2/2   x2+L2/2   x2-L2/2   x2-L2/2];    M2Y = [y2-W2/2   y2-W2/2   y2+W2/2   y2+W2/2   y2-W2/2];
        M3X = [x3-L3/2   x3+L3/2   x3+L3/2   x3-L3/2   x3-L3/2];    M3Y = [y3-W3/2   y3-W3/2   y3+W3/2   y3+W3/2   y3-W3/2];
        M4X = [x4-L4/2   x4+L4/2   x4+L4/2   x4-L4/2   x4-L4/2];    M4Y = [y4-W4/2   y4-W4/2   y4+W4/2   y4+W4/2   y4-W4/2];
        M5X = [x5-L5/2   x5+L5/2   x5+L5/2   x5-L5/2   x5-L5/2];    M5Y = [y5-W5/2   y5-W5/2   y5+W5/2   y5+W5/2   y5-W5/2];
        M6X = [x6-L6/2   x6+L6/2   x6+L6/2   x6-L6/2   x6-L6/2];    M6Y = [y6-W6/2   y6-W6/2   y6+W6/2   y6+W6/2   y6-W6/2];
        M7X = [x7-L7/2   x7+L7/2   x7+L7/2   x7-L7/2   x7-L7/2];    M7Y = [y7-W7/2   y7-W7/2   y7+W7/2   y7+W7/2   y7-W7/2];
        M8X = [x8-L8/2   x8+L8/2   x8+L8/2   x8-L8/2   x8-L8/2];    M8Y = [y8-W8/2   y8-W8/2   y8+W8/2   y8+W8/2   y8-W8/2];
        M9X = [x9-L9/2   x9+L9/2   x9+L9/2   x9-L9/2   x9-L9/2];    M9Y = [y9-W9/2   y9-W9/2   y9+W9/2   y9+W9/2   y9-W9/2];
        M10X = [x10-L10/2   x10+L10/2   x10+L10/2   x10-L10/2   x10-L10/2];    M10Y = [y10-W10/2   y10-W10/2   y10+W10/2   y10+W10/2   y10-W10/2];
        M11X = [x11-L11/2   x11+L11/2   x11+L11/2   x11-L11/2   x11-L11/2];    M11Y = [y11-W11/2   y11-W11/2   y11+W11/2   y11+W11/2   y11-W11/2];
        M12X = [x12-L12/2   x12+L12/2   x12+L12/2   x12-L12/2   x12-L12/2];    M12Y = [y12-W12/2   y12-W12/2   y12+W12/2   y12+W12/2   y12-W12/2];

        MX = {M1X M2X M3X M4X M5X M6X M7X M8X M9X M10X M11X M12X}
        MY = {M1Y M2Y M3Y M4Y M5Y M6Y M7Y M8Y M9Y M10Y M11Y M12Y}
        ColorM = [ [1 0 0]; [0 1 0]; [0 0 1]; [.5 .5 1]; [.5 1 .5]; [1 .5 .5]; [.5 .5 .5]; [.25 .25 1]; [.5 .25 1]; [.2 .2 .2]; [.8 .2 .2]; [.2 .8 .2] ]

        figure(2)
        for i = 1:12
            plot(MX{i}, MY{i}, 'MarkerfaceColor', ColorM(i,:))
            hold on
            text( x((2*i-1)) ,x((2*i)) , num2str(i));
        end
        axis([0 L 0 W])
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%% Defining Inputs and Output %%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %============================== Raxtkan 1
        I1_1x = x1; I1_1y = y1;                     O1_1x = x1; O1_1y = y1;
        %============================== Saxte Kabin 2
        I2_1x = x2 - L2/2 + 2; I2_1y = y2 + W2/2;   O2_1x = x2 + L2/2; O2_1y = y2;
        %============================== Saxte Shasi 3
        I3_1x = x3 - L3/2 + 2; I3_1y = y3 + W3/2;   O3_1x = x3 + L3/2; O3_1y = y3;
        %============================== Rober Assemble 4
        I4_1x = x4 - L4/2; I4_1y = y4;              O4_1x = x4 - L4/2; O4_1y = y4;
        %============================== WC 5
        I5_1x = x5; I5_1y = y5;                     O5_1x = x5; O5_1y = y5;
        %============================== Health Care 6
        I6_1x = x6; I6_1y = y6;                     O6_1x = x6; O6_1y = y6;
        %============================== Main Office 7
        I7_1x = x7; I7_1y = y7;                     O7_1x = x7; O7_1y = y7;
        %============================== Assemble Line 8
        I8_1x = x8 - L8/2; I8_1y = y8 - W8/2;       I8_2x = x8 - L8/2; I8_2y = y8 - W8/2 + 3.5;
        I8_3x = x8 - L8/2; I8_3y = y8 - W8/2 + 7;   I8_4x = x8 - L8/2; I8_4y = y8 + 1.5;
        I8_5x = x8 - L8/2; I8_5y = y8 + 3.5;        I8_6x = x8 - L8/2; I8_6y = y8 + 6.5;
        I8_7x = x8 - L8/2; I8_7y = y8 + W8/2 - 2;

        O8_1x = x8 + L8/2; O8_1y = y8 - W8/2;       O8_2x = x8 + L8/2; O8_2y = y8 - W8/2 + 3.5;
        O8_3x = x8 + L8/2; O8_3y = y8 - W8/2 + 7;   O8_4x = x8 + L8/2; O8_4y = y8 + 1.5;
        O8_5x = x8 + L8/2; O8_5y = y8 + 3.5;        O8_6x = x8 + L8/2; O8_6y = y8 + 6.5;
        O8_7x = x8 + L8/2; O8_7y = y8 + W8/2 - 2;   O8_8x = x8 - L8/2; O8_8y = y8 - 2;
        C8x = x8; C8y = y8;
        %============================== Check Room 9
        I9_1x = x9 + L9/2; I9_1y = y9 + W9/2;       O9_1x = x9; O9_1y = y9 - W9/2;
        %============================== Cabine Painting 10
        I10_1x = x10 + L10/2; I10_1y = y10;         O10_1x = x10 - L10/2; O10_1y = y10;
        %============================== Tools Room 11
        I11_1x = x11; I11_1y = y11;                 O11_1x = x11; O11_1y = y11;
        %============================== Batri 12
        I12_1x = x12; I12_1y = y12;                 O12_1x = x12; O12_1y = y12;
        %============================== 1inci Gapi
        IO1x = 32.5;    IO1y = 50;
        %============================== 2inci Gapi
        IO2x = 8;       IO2y = 50;
        %============================== 3inci Gapi
        IO3x = 2.5;     IO3y = 0;
        % =================================================================
        InpuTT_X = {I1_1x   I2_1x   I3_1x   I4_1x   I5_1x   I6_1x   I7_1x ...
            I8_1x   I8_2x   I8_3x   I8_4x   I8_5x   I8_6x   I8_7x   I9_1x   I10_1x  I11_1x  I12_1x};
        InpuTT_Y = {I1_1y   I2_1y   I3_1y   I4_1y   I5_1y   I6_1y   I7_1y ...
            I8_1y   I8_2y   I8_3y   I8_4y   I8_5y   I8_6y   I8_7y   I9_1y   I10_1y  I11_1y  I12_1y};

        OutpuTT_X = {O1_1x   O2_1x   O3_1x   O4_1x   O5_1x   O6_1x   O7_1x ...
            O8_1x   O8_2x   O8_3x   O8_4x   O8_5x   O8_6x   O8_7x   O8_8x   O9_1x   O10_1x  O11_1x  O12_1x};
        OutpuTT_Y = {O1_1y   O2_1y   O3_1y   O4_1y   O5_1y   O6_1y   O7_1y ...
            O8_1y   O8_2y   O8_3y   O8_4y   O8_5y   O8_6y   O8_7y   O8_8y   O9_1y   O10_1y  O11_1y  O12_1y};

        Variables_Matrix = [    I1_1x   I2_1x   I3_1x   I4_1x   I5_1x   I6_1x   I7_1x  I8_1x   I8_2x   I8_3x   I8_4x   I8_5x   I8_6x   I8_7x   I9_1x   I10_1x  I11_1x  I12_1x  O1_1x   O2_1x   O3_1x   O4_1x   O5_1x   O6_1x   O7_1x   O8_1x   O8_2x   O8_3x   O8_4x   O8_5x   O8_6x   O8_7x   O8_8x   O9_1x   O10_1x  O11_1x  O12_1x   IO1x    IO2x     IO3x    C8x ...
            ;I1_1y   I2_1y   I3_1y   I4_1y   I5_1y   I6_1y   I7_1y  I8_1y   I8_2y   I8_3y   I8_4y   I8_5y   I8_6y   I8_7y   I9_1y   I10_1y  I11_1y  I12_1y  O1_1y   O2_1y   O3_1y   O4_1y   O5_1y   O6_1y   O7_1y   O8_1y   O8_2y   O8_3y   O8_4y   O8_5y   O8_6y   O8_7y   O8_8y   O9_1y   O10_1y  O11_1y  O12_1y   IO1y    IO2y     IO3y    C8y]';
        %VariablesMatrix = [    1       2       3       4       5       6       7      8       9       10      11      12      13      14      15      16      17      18      19      20      21      22      23      24      25      26      27      28      29      30      31      32      33      34      35      36      37       38      39       40      41];

        for i=1:size(Variables_Matrix,1)
            i
            hold on
            plot(Variables_Matrix(i,1),Variables_Matrix(i,2),'rs')
        end

        hold off

        Relation_Matrix = zeros(41);

        %     Relation_Matrix = [0  0  0  0  0  0 ...  0  0  0  0  0  0  ;...
        %                        0  0  0  0  0  0 ...  0  0  0  0  0  0  ;...
        %                        .  .  .  .  .  . ...  .  .  .  .  .  .
        %                        .  .  .  .  .  . ...  .  .  .  .  .  .
        %                        .  .  .  .  .  . ...  .  .  .  .  .  .
        %                        0  0  0  0  0  0 ...  0  0  0  0  0  0  ;...
        %                        0  0  0  0  0  0 ...  0  0  0  0  0  0  ;...
        %                        0  0  0  0  0  0 ...  0  0  0  0  0  0  ;...
        %%% ================== O1
        Relation_Matrix(2,19) = 50;     Relation_Matrix(3,19) = 50;     Relation_Matrix(4,19) = 20;     Relation_Matrix(5,19) = 0;
        Relation_Matrix(6,19) = 4;      Relation_Matrix(42,19) = 180;   Relation_Matrix(15,19) = 12;
        Relation_Matrix(16,19) = 40;    Relation_Matrix(17,19) = 2;     Relation_Matrix(18,19) = 4;
        %%% ================== O2
        Relation_Matrix(16,20) = 140;   Relation_Matrix(5,20) = 100;    Relation_Matrix(17,20) = 30;
        %%% ================== O3
        Relation_Matrix(8,21) = 140;    Relation_Matrix(5,21) = 100;    Relation_Matrix(17,21) = 30;
        %%% ================== O4
        Relation_Matrix(32,22) = 60;    Relation_Matrix(5,22) = 40;     Relation_Matrix(17,22) = 10;
        %%% ================== O8
        Relation_Matrix(26,38) = 60;
        Relation_Matrix(27,38) = 32;
        Relation_Matrix(28,38) = 32;
        Relation_Matrix(29,38) = 32;
        Relation_Matrix(30,38) = 32;
        Relation_Matrix(31,38) = 32;
        Relation_Matrix(32,38) = 70;
        Relation_Matrix(33,15) = 100;
        %%% ================== O9
        Relation_Matrix(34,41) = 160;
        %%% ================== 10
        Relation_Matrix(35,9) =160
        %%% ================== 11
        Relation_Matrix(36,2) =30
        Relation_Matrix(36,3) =30
        Relation_Matrix(36,4) =20
        Relation_Matrix(36,40) =200
        Relation_Matrix(36,15) =20
        Relation_Matrix(36,16) =20
        Relation_Matrix(36,18) =5
        %%% ================== 12
        Relation_Matrix(37,14) =30
        %%% ================== 1inci gapi
        Relation_Matrix(38,1) =40
        Relation_Matrix(38,2) =60
        Relation_Matrix(38,3) =60
        Relation_Matrix(38,4) =50
        Relation_Matrix(38,40) =200
        Relation_Matrix(38,18) =20
        %%% ================== 6
        Relation_Matrix(6,2) =3
        Relation_Matrix(6,3) =3
        Relation_Matrix(6,4) =2
        Relation_Matrix(6,40) =10
        Relation_Matrix(6,15) =1
        Relation_Matrix(6,16) =2
        Relation_Matrix(6,17) =.5
        Relation_Matrix(6,18) =1
        Relation_Matrix(6,38) =3
        %%% ================== 7
        Relation_Matrix(7,2) =30
        Relation_Matrix(7,3) =30
        Relation_Matrix(7,4) =20
        Relation_Matrix(7,40) =150
        Relation_Matrix(7,15) =20
        Relation_Matrix(7,16) =30
        Relation_Matrix(7,17) =4
        Relation_Matrix(7,18) =8
        Relation_Matrix

        SUM = 0;

        for ii = 1:size(Relation_Matrix,1)
            for jj = 1:size(Relation_Matrix,1)
                SUM  = SUM + Relation_Matrix(ii,jj) * sum( (Variables_Matrix(:,ii)-Variables_Matrix(:,jj)).^2 );
            end
            f(index,1) = SUM;
        end
    end
end