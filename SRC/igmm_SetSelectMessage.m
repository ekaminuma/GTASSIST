function igmm_SetSelectMessage(handles,msgstr)
%
% GTAssist - IGMM 
% by eli@gsc.riken.jp
% 
% (c) 2006 RIKEN GSC
%
tmpobj=findobj('Tag','msgselect'); 
        
        if isempty(tmpobj)
            text(0.05,1.1,msgstr,'Tag','msgselect','FontName','Ariel');
        else
            if strcmp(msgstr,'')==1
                delete(tmpobj);
            else    
                set(tmpobj,'String',msgstr);
            end
        end
          

return