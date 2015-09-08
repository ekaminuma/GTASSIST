function igmm_PlotMembershipProb(handles, pr_igmm )
%
% GTAssist - IGMM 
% by eli@gsc.riken.jp
% 
% (c) 2006 RIKEN GSC
%
axes(handles.axes2);
if isempty(pr_igmm)    
    tmpobj=findobj('Tag','axes2labs');
    if ~isempty(tmpobj), delete(tmpobj);end
    tmpobj=findobj('Tag','barplot');
    if ~isempty(tmpobj), delete(tmpobj);end
    set(gca,'XTick',[],'YTick',[]);
else    
    if sum(pr_igmm)==0
        bar(pr_igmm);
        set(gca,'XLim',[0.2 4.8]);
        set(gca,'YLim',[0 1]);
        
    else    
        %---------------------------------------
        tmp=zeros(4,4);
        for kk=1:size(tmp,1)
            tmp(kk,kk)=pr_igmm(kk);
        end
        %---------------------------------------
    
        b1=bar(tmp,'stacked');
        set(gca,'XLim',[0.2 4.8]);
        %grid on;
        %set(gca,'XTick',[]);
        set(b1,'Tag','barplot');
    
    end
    %----------------------------------------
    labs={'NTC';'homo1';'hetero';'homo2'};
    set(gca,'XTickLabel',labs);
   
end

return
