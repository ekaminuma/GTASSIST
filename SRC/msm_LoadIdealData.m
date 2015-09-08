function msm_LoadIdealData(handles)
%
% GTAssist - MSM
% by eli@gsc.riken.jp
% 
% (c) 2006 RIKEN GSC
%
[fname,fpath] = uigetfile( ...
    {'*.txt;*.csv;*.tab', 'Text files (*.txt, *.csv, *.tab)'; ...
    '*.*','All Files (*.*)'}, ...
    'Select a text file', ...
    'MultiSelect','off');% single file
%----- check cancel or not-------------------------   
if fname==0
    return
end    
%----- save path data-----------------------------

tmpidname=sprintf('%s/%s',fpath,fname);
setappdata(0,'id_filename',tmpidname);

%------- plot data -------------------------------------
msm_PlotData(handles,0);
msm_CheckButtonEst(handles.axes1,handles.pushbutton2);

return
