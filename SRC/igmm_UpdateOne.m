function igmm_UpdateOne(handles)
%
% GTAssist - IGMM 
% by eli@gsc.riken.jp
% 
% (c) 2006 RIKEN GSC
%

pr_igmm=getappdata(0,'pr_igmm');
list=find(pr_igmm==max(pr_igmm));
if ~isempty(list)
    maxidx=list(1);
else    
    return
end

if sum(pr_igmm)>0
%---------------------------------------
maxclass=getBarIdx2LabelIdx(maxidx);
%---------------------------------------
str_gid=get(handles.edit1,'String');
gid=str2double(str_gid);
%---------------------------------------
x=get(handles.axes1,'UserData');
setappdata(0,'backupclass',[gid x(gid,:)]);% backup data
x(gid,3)=maxclass;
%---- update status --------------------
set(handles.edit4,'String',getLabelIdx2LabelStr(maxclass));
set(handles.axes1,'UserData',x);
igmm_UpdatePlotData(handles,x);
end

return
%---------------------------------------
function out=getLabelIdx2LabelStr(in)
idxstr={'NTC';'homo1';'homo2';'hetero'};
out=idxstr{in+1};

return
%---------------------------------------
function out=getBarIdx2LabelIdx(in)

idxlist={0;1;3;2};
out=idxlist{in};

return
%---------------------------------------
