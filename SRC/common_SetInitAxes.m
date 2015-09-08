function common_SetInitAxes(hObject)
%
% GTAssist - MSM, IGMM 
% by eli@gsc.riken.jp
% 
% (c) 2006 RIKEN GSC
%
gca=hObject;
 axis image;
        set(gca,'XLim',[-0.2 1.2]);
        set(gca,'YLim',[-0.2 1.2]);
        grid on;
        set(gca,'XTick',[0 0.5 1.0]);
        set(gca,'YTick',[0 0.5 1.0]);
        set(gca,'XTickLabel',[]);
        set(gca,'YTickLabel',[]);
        set(gca,'Box','on');

return
