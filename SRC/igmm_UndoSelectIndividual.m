function igmm_UndoSelectIndividual(handles)
%
% GTAssist - IGMM 
% by eli@gsc.riken.jp
% 
% (c) 2006 RIKEN GSC
%
tmp=getappdata(0,'backupclass');
if ~isempty(tmp) %UndoSelect
    glist=tmp(:,1);
    clist=tmp(:,4);
    %---- reset class-----------------------
    x=get(handles.axes1,'UserData');
    x(glist,3)=clist;
    %---- update status --------------------
    igmm_UpdatePlotData(handles,x);
    set(handles.axes1,'UserData',x);
else %UndoRemove
    idx=getappdata(0,'backupremoved');
    glist=idx(1,1);
    tmpclass=idx(1,2);
    x=get(handles.axes1,'UserData');
    x(glist,3)=tmpclass;
    igmm_UpdatePlotData(handles,x);
    set(handles.axes1,'UserData',x);

end    
return
%%%%%%%%% END %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%