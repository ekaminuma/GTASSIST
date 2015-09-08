function igmm_UpdateAll(handles)
%
% GTAssist - IGMM 
% by eli@gsc.riken.jp
% 
% (c) 2006 RIKEN GSC
%
if checkNumberEachClass()==1
    uiwait(errordlg('Please categorize the data.','ANALYSIS ERROR'));
    igmm_MarkHighlight(handles,[],[]);
    return
end    

%------ get list of unknown individuals-------------
x=get(handles.axes1,'UserData');
glist=find(x(:,3)==-1);
N=length(glist);

clist=zeros(N,1);
%-----calculate igmm----------------
for ii=1:N
    gid=glist(ii);
    maxclass=getMaxClassByIGMM(handles,gid);
    clist(ii,1)=maxclass;
end

%------set new class in x-------------------
setappdata(0,'backupclass',[glist x(glist,:)]);% backup data
x(glist,3)=clist;
%---- update status --------------------
set(handles.axes1,'UserData',x);
igmm_UpdatePlotData(handles,x);

return
%------------------------------------------------
function [flag]=checkNumberEachClass

flag=0;
p1=getappdata(0,'origplot');
for pp=2:5
    xtmp=get(p1(pp,1),'XData');
    if length(xtmp)<=3
       flag=1; 
    end    
end    

return
%--------------------------------------------------
function [maxclass]=getMaxClassByIGMM(handles,gid)

classcode=[0 1 3 2];
maxclass=[];
pr_igmm=igmm_GetMembershipProb(handles,gid);
if sum(pr_igmm)==0
    maxclass=-1;%unknown
else    
    list=find(pr_igmm==max(pr_igmm));
    if ~isempty(list)
        maxclass=classcode(list(1));
    end
end

return
%--------------------------------------------------