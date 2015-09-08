function igmm_LoadData(handles)
%
% GTAssist - IGMM 
% by eli@gsc.riken.jp
% 
% (c) 2006 RIKEN GSC
%

[fname,fpath] = uigetfile( ...
    {'*.txt;*.csv;*.tab', 'Text files (*.txt, *.csv, *.tab)'; ...
    '*.*','All Files (*.*)'}, ...
    'Select a text file', ...
    'MultiSelect','off');% single file
   
%----- check cancel------------------------------------
if fname==0
	return
end
%----- save path data----------------------------------

filename=sprintf('%s/%s',fpath,fname);
setappdata(0,'filename',filename);

%------- plot data -------------------------------------

[x,tmpname]=common_LoadFileData(handles,filename);
x=assignClassEmptyData(x);
x=common_NormalizeData(x);
igmm_PlotData(handles,x,tmpname);

%------- save temporal data----------------------------
y=zeros(size(x,1),size(x,2)+1);
y(:,1:3)=x(:,1:3);
y(:,4:size(x,2)+1)=x(:,3:size(x,2));%backup in the 4-th column 
set(handles.axes1,'UserData',y);

%------- update status --------------------------------
set(handles.text0,'String',filename);
%buttons
set(handles.pushbutton2,'Enable','on');
set(handles.pushbutton3,'Enable','on');
set(handles.pushbutton2d,'Enable','on');
set(handles.pushbutton3d,'Enable','on');
set(handles.pushbutton4,'Enable','on');
%menus
set(handles.SaveMenuItem,'Enable','on');
set(handles.SelectMenuItem,'Enable','on');
set(handles.SelectAllMenuItem,'Enable','on');
set(handles.UpdateMenuItem,'Enable','on');
set(handles.UpdateAllMenuItem,'Enable','on');
return
%----------------------------------------------
function xout=assignClassEmptyData(xin)

codelist=[NaN,-1,0,1,2,3];
xout=xin;
list=[];
for pp=1:size(codelist,2)
    tmp=find(xout(:,3)==codelist(1,pp));
    if length(tmp)>0
        if isempty(list)
            list=tmp;
        else
            list=[list;tmp];
        end    
    end    
end

dat=ones(size(xout,1),1);
dat(list,1)=zeros(length(list),1);
emptylist=find(dat==1);

if length(emptylist)>0
    xout(emptylist,3)=-1*ones(length(emptylist),1);
    msg=sprintf('%d individuals\n[?]->[unknown]',length(emptylist));
    uiwait(warndlg(msg,'Warning'));
end
return
