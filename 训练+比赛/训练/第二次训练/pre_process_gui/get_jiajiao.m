function angle=get_jiajiao(angle1,angle2)    % 0---180��

   angle =abs(angle1-angle2);
   if (angle>90)
       angle=180-angle;
   end
   