function valid=valimatch(matchnode)
 len=size(matchnode,1);
 %diffnum=0;
 valid=0;
 tmp=Inf(1,4);
 tmp(1)=matchnode(1,2);
 ind=1;
 for i=2:len
     dif=1;
     for j=1:ind
         if matchnode(i,2)==tmp(j)
             dif=0;
         end
     end
     if dif==1
         ind=ind+1;
         tmp(ind)=matchnode(i,2);
     end
     if ind>=4
         valid=1;
         break
     end
     ind;
     valid;
 end
end