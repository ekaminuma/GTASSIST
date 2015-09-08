function msm_ClearFiles(handles)
%
% GTAssist - MSM
% by eli@gsc.riken.jp
% 
% (c) 2006 RIKEN GSC
%
list_entries = get(handles.listbox1,'String');
[Ntmp]=size(list_entries,1);
for nn=0:Ntmp
    matname=sprintf('tmp_%d.mat',nn);
    if exist(matname)==2
        %fprintf('ClearFile[%d][%s]\n',nn,matname);
        delete(matname);
    end        
end    
delete(handles.figure1);

return
