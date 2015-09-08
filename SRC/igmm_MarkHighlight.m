function igmm_MarkHighlight(handles,xdat,ydat)
%
% GTAssist - IGMM 
% by eli@gsc.riken.jp
% 
% (c) 2006 RIKEN GSC
%
p1=findobj('tag','plotobj');
tmpobj=p1(1,1);

    set(tmpobj,'XData',xdat);
    set(tmpobj,'YData',ydat);
    mksize=getappdata(0,'markersize');
    if ~ispc
       mksize=mksize+4; 
    end    
    set(tmpobj,'MarkerSize',mksize);

return
