function igmm_SelectAllUnknown(handles)
%
% GTAssist - IGMM 
% by eli@gsc.riken.jp
% 
% (c) 2006 RIKEN GSC
%
%------ get list of unknown individuals-------------
x=get(handles.axes1,'UserData');
list=find(x(:,3)==-1);
%------ marking all unknown individuals ---------
igmm_MarkHighlight(handles,x(list,1),x(list,2));
%------ clear status-----------------------------
igmm_ClearStatus(handles,1);

return
