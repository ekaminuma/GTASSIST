function msm_CheckButtonEst(tmpaxes,tmpobj)
%
% GTAssist - MSM
% by eli@gsc.riken.jp
% 
% (c) 2006 RIKEN GSC
%
if strcmp(get(tmpobj,'Enable'),'on')==1
    return
end    
if ~isempty(get(tmpaxes,'Children')) 
    set(tmpobj,'Enable','on');
end

return
