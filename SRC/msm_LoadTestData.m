function msm_LoadTestData(handles)
%
% GTAssist - MSM
% by eli@gsc.riken.jp
% 
% (c) 2006 RIKEN GSC
%

[fnames,fpath] = uigetfile( ...
    {'*.txt;*.csv;*.tab', 'Text files (*.txt, *.csv, *.tab)'; ...
    '*.*','All Files (*.*)'}, ...
    'Select a text file', ...
    'MultiSelect','on');

if ~iscell(fnames) 
    if fnames==0
        return
    end
end    

if iscell(fnames)
    fnames=sort(fnames);
end

[FN]=getNumberOfFiles(fnames);

[select_value]=addSNPsInListbox(handles,fnames,fpath,FN);

msm_PlotData(handles,select_value);

msm_CheckButtonEst(handles.axes3,handles.pushbutton4);

return
%----- check multiple files ------------------
function FN=getNumberOfFiles(fnames)

    FN=1;
    if iscell(fnames)
        FN=size(fnames,2);
    end    

return
%--------------------------------------------
function [select_value]=addSNPsInListbox(handles,fnames,fpath,FN)

list_entries = get(handles.listbox1,'String');
index_selected = get(handles.listbox1,'Value');
    
tmpflist=cell(1,1);
Ntmp=0;
    if isempty(list_entries)
        vars = cell(1,1);
        
            
         for nn=1:FN
              if iscell(fnames)
                    tmpname= fnames{1,nn};
              else
                    tmpname=fnames;
              end    
            vars{nn,1}=sprintf('[--] %s',tmpname);
            tmpflist{nn,1}=sprintf('%s%s',fpath,tmpname);
         end
    else    
        [Ntmp]=size(list_entries,1);
        vars=list_entries;
        tmpflist=getappdata(0,'filelist');
        count=1;
        for nn=1:FN
            %----check double opening-----------
            flag=0;
            if iscell(fnames)
               tmpname= fnames{1,nn};
            else
               tmpname=fnames;
            end    
            for mm=1:Ntmp
                pathfname=sprintf('%s/%s',fpath,tmpname);
               
                if strcmp(tmpflist{mm,1},pathfname)==1
                        flag=1;break;
                end    
            end    
            %----regist files--------------------
            if flag==0
                vars{Ntmp+count,1}=sprintf('[--] %s',tmpname);
                tmpflist{Ntmp+count,1}=pathfname;
                count=count+1;
            end%if-flag    
        end    
    end
    
    select_value=size(vars,1);

    set(handles.listbox1,'String',vars);
    set(handles.listbox1,'Value',select_value);
  
    %------- save data--------------------------------------

    setappdata(0,'filelist',tmpflist);

return
    

