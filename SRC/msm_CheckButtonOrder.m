function msm_CheckButtonOrder(handles)
%
% GTAssist - MSM
% by eli@gsc.riken.jp
% 
% (c) 2006 RIKEN GSC
%
if ~isempty(get(handles.axes2,'Children')) 
    list_entries = get(handles.listbox1,'String');
    [Ntmp]=size(list_entries,1);
    flag=1;
    for nn=1:Ntmp
        tmpname=sprintf('tmp_%d.mat',nn);
        tmpval=exist(tmpname);
        %fprintf('CheckButtonOrder[%s]-->[%d]\n',tmpname,tmpval);
        if exist(tmpname)~=2
            flag=0;
            return;
        end    
    end    
    if flag==1
        set(handles.pushbutton5,'Enable','on');
        set(handles.OrderMenuItem,'Enable','on');
    end
end

return
