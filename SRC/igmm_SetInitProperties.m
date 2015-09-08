function igmm_SetInitProperties(handles)
%
% GTAssist - IGMM 
% by eli@gsc.riken.jp
% 
% (c) 2006 RIKEN GSC
%
%------ fontname ---------------------------
set(0,'defaultuicontrolfontname','ariel');
set(0,'defaultaxesfontname','ariel');
set(0,'defaulttextfontname','ariel');

%------ fontsize (default) ----------------- 
dfs=get(0,'defaultuicontrolfontsize');
set(0,'defaultaxesfontsize',dfs);
set(0,'defaulttextfontsize',dfs);

%------ fontsize (text) --------------------
for mm=0:16
        str=sprintf('text%d',mm);
        tmpobj=findobj('Tag',str);
        set(tmpobj,'FontSize',dfs);
end
%------ fontsize (pushbutton) ---------------
for mm=1:5
        str=sprintf('pushbutton%d',mm);
        tmpobj=findobj('Tag',str);
        set(tmpobj,'FontSize',dfs);
end
set(handles.pushbutton2d,'FontSize',dfs);
set(handles.pushbutton3d,'FontSize',dfs);
%------ fontsize (pushbutton) ---------------
for mm=1:4
        str=sprintf('edit%d',mm);
        tmpobj=findobj('Tag',str);
        set(tmpobj,'FontSize',dfs);
end
%------ uipanel -----------------------------
set(handles.uipanel1,'FontSize',dfs);
set(handles.uipanel2,'FontSize',dfs);
%------ markermark ---------------------------
%------ markersize ---------------------------
if ~ispc
    mkmark='o';
    mksize=2.0;
    
else    
    mkmark='.';
    set(0,'Units','pixels');
    scrsize=get(0,'ScreenSize');
    set(0,'Units','normalize');
    if scrsize(4)<=768
        mksize=4.0;
    elseif scrsize(4) <=854
        mksize=5.0;
    else
        mksize=6.0; % default 
    end    
end    
setappdata(0,'markersize',mksize);
setappdata(0,'markermark',mkmark);

return
