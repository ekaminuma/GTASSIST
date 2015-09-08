function igmm_ClearStatus(handles,flag)
% GTAssist - IGMM 
% by eli@gsc.riken.jp
% 
% (c) 2006 RIKEN GSC

%------ clear pr_igmm------------------------------
igmm_PlotMembershipProb(handles,[]);

%------ update status------------------------------
if flag==1
    set(handles.edit0,'String','');
    set(handles.edit1,'String','');
    set(handles.edit2,'String','');
    set(handles.edit3,'String','');
    set(handles.edit4,'String','');
end

return
