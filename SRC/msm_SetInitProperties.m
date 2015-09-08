function msm_SetInitProperties(handles)
%
% GTAssist - MSM
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
for mm=1:5
        str=sprintf('text%d',mm);
        tmpobj=findobj('Tag',str);
        set(tmpobj,'FontSize',dfs);
end
%------ fontsize (pushbutton) ---------------
for mm=1:7
        str=sprintf('pushbutton%d',mm);
        tmpobj=findobj('Tag',str);
        set(tmpobj,'FontSize',dfs);
end
%------ listbox-----------------------------
set(handles.listbox1,'FontSize',dfs);
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
