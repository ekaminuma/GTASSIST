function igmm_UpdatePlotData(handles,x)
%
% GTAssist - IGMM 
% by eli@gsc.riken.jp
% 
% (c) 2006 RIKEN GSC
%

filename= getappdata(0,'filename');
[tp,tmpname,te,tv]=fileparts(filename);
igmm_PlotData(handles,x,tmpname);
   
return
