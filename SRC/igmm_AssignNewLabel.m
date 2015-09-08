function igmm_AssignNewLabel(handles,tmpobj)
%
% GTAssist - IGMM 
% by eli@gsc.riken.jp
% 
% (c) 2006 RIKEN GSC

str=get(tmpobj,'String');
%----------------------------------------
idx=getLabel2ClassIdx(str);
if ~isnan(idx)
    setClassStringLabel(handles,str);
    str_gid=get(handles.edit1,'String');
    gid=str2double(str_gid);
    x=get(handles.axes1,'UserData');
    x(gid,3)=idx;
    igmm_UpdatePlotData(handles,x);
    set(handles.axes1,'UserData',x);
end
return
%---------------------------------------
function setClassStringLabel(handles,str)
if ~(strncmp(str,'h',1) | strncmp(str,'N',1) |strncmp(str,'u',1))
    labels={'unknown';'NTC';'homo1';'homo2';'hetero'};
    idx=str2double(str)+2;
    set(handles.edit4,'String',labels{idx,:});
end

return    

%----------------------------------------
function idx=getLabel2ClassIdx(str)
idx=NaN;
switch str
    case {'unknown','-1'}
        idx=-1;
    case {'NTC','0'}
        idx=0;
    case {'homo1','1'}
        idx=1;
    case {'homo2','2'}
        idx=2;
    case {'hetero','3'}
        idx=3;
    otherwise idx=NaN;
end
        
return
%------------------------------------------