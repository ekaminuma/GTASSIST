function [pr_igmm]=igmm_GetMembershipProb(handles,idx)
%
% GTAssist - IGMM 
% by eli@gsc.riken.jp
% 
% (c) 2006 RIKEN GSC
%

pr_igmm=[];
x=get(handles.axes1,'UserData');

    [N,A,B,H]=getDatByGenotypes(x);
    if checkErrNumbers(N,A,B,H)>0
        %igmm_MarkHighlight(handles,[],[]);
        igmm_ClearStatus(handles,0);  
        return 
    end    
%-----calc Mahalanobis distances---------
    dat=x(idx,1:2);
    res=zeros(4,1);
  
   % fprintf('[N%d][A%d][H%d][B%d]',size(N,1),size(A,1),size(H,1),size(B,1));
  
    res(1,1)=mahal(dat,N)';%N group
    res(2,1)=mahal(dat,A)';%A group
    res(3,1)=mahal(dat,H)';%H group
    res(4,1)=mahal(dat,B)';%B group

%-----calc.chi-square prob.----------------------------

pvalue=1-chi2cdf(res,2);
pr_igmm=pvalue;

%-----------------------------------------------------
setappdata(0,'pr_igmm',pr_igmm);%for UpdateOne

return
%-----------------------------------------------------
function [flag]=checkErrNumbers(N,A,B,H)

flag=0;
str='';
if size(N,1)<=3
    str='NTC';   
    flag=flag+1;
end    
if size(A,1)<=3
    str='homo1';   
    flag=flag+1;
end    
if size(B,1)<=3
    str='homo2';   
    flag=flag+1;
end    
if size(H,1)<=3
    str='hetero';   
    flag=flag+1;
end

if flag==1
    msg=sprintf('%s requires more individuals.',str);
elseif flag>1
    msg='Please categorize the data.';
end

if flag>0
uiwait(errordlg(msg,'ANALYSIS ERROR'));
end

return
%---------------------------------------------
function [N,A,B,H]=getDatByGenotypes(x)

h0=find(x(:,3)==0);
h1=find(x(:,3)==1);
h2=find(x(:,3)==2);
h3=find(x(:,3)==3);

 N=zeros(length(h0),2);
 A=zeros(length(h1),2);
 B=zeros(length(h2),2);
 H=zeros(length(h3),2);
 
 N(:,1)=x(h0,1);
 N(:,2)=x(h0,2);
 A(:,1)=x(h1,1);
 A(:,2)=x(h1,2);
 B(:,1)=x(h2,1);
 B(:,2)=x(h2,2);
 H(:,1)=x(h3,1);
 H(:,2)=x(h3,2);
 
return
