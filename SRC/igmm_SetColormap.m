function igmm_SetColormap(handles,tmpcolor,select_idx)
%
% GTAssist - IGMM 
% by eli@gsc.riken.jp
% 
% (c) 2006 RIKEN GSC
%
%-- set colormap-----------
axes(handles.axes2);
colormap(tmpcolor);
axes(handles.axes1);
colormap(tmpcolor);

%-- updates---------------
setPlotColor();
setLabelColor();
setMenuCheck(select_idx);

return
%---------------------------------------------
function setMenuCheck(select_idx)

cm_tagnames={'CoolCM_MenuItem';'JetCM_MenuItem';'SpringCM_MenuItem';'SummerCM_MenuItem'};
for pp=1:4
    if pp==select_idx
        obj=findobj('Tag',cm_tagnames{pp,:});
        set(obj,'Checked','on');
    else
        obj=findobj('Tag',cm_tagnames{pp,:});
        set(obj,'Checked','off');
    end
end

return
%----------------------------------------------
function setPlotColor()

map=colormap;
mm=[1 22 43 64];
tmpcol=[map(mm(1),:);map(mm(2),:);map(mm(4),:);map(mm(3),:);0 0 0];

p1=getappdata(0,'origplot');
for pp=1:5
    set(p1(pp,1),'Color',tmpcol(pp,:));
end    

return
%-----------------------------------------------
function setLabelColor()

map=colormap;
mm=[1 22 43 64];
tmpcol=[0 0 0;map(mm(1),:);map(mm(2),:);map(mm(4),:);map(mm(3),:)];
tmplbl=['15';'11';'12';'14';'13'];
for pp=1:5
    tmpname=sprintf('text%s',tmplbl(pp,:));
    tmpobj=findobj('tag',tmpname);
    set(tmpobj,'ForegroundColor',tmpcol(pp,:));
end

return
