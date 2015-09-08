function igmm_RemoveAnIndividual(handles)
%
% GTAssist - IGMM 
% by eli@gsc.riken.jp
% 
% (c) 2006 RIKEN GSC
%
%---get select index----------
tmp=getappdata(0,'backupclass');
if isempty(tmp)
    uiwait(errordlg('Cannot remove the individual.','ERROR'));
    return
end    
glist=tmp(:,1);

%---remove--------------------
x=get(handles.axes1,'UserData');
tmp=[glist x(glist,3)];%save class
setappdata(0,'backupremoved',tmp);
x(glist,3)=NaN;

%---update----------------------
igmm_UpdatePlotData(handles,x);
igmm_ClearStatus(handles,1);
set(handles.axes1,'UserData',x);
setappdata(0,'backupclass',[]);

return
